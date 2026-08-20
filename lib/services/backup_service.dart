import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'local_db_service.dart';

/// Marks a file as ours, so an unrelated JSON dropped into the importer is
/// rejected by name rather than by whatever it happens to be missing.
const String kBackupFormat = 'jwstreak-backup';

/// Version of the *envelope*, not of the database. Bumped only when the
/// shape around `tables` changes; [LocalDbService.schemaVersion] tracks the
/// tables themselves, and the two move independently.
const int kBackupFormatVersion = 1;

/// Why a backup file was refused. Carrying a reason rather than a bare
/// failure lets the UI say what is actually wrong with the file.
enum BackupRejection {
  /// Not JSON at all, or not an object.
  unreadable,

  /// Valid JSON, but not a JW Streak backup.
  notABackup,

  /// Written by a newer version of the app than this one understands.
  tooNew,

  /// Ours, right version, but the contents don't hold together.
  corrupt,
}

class BackupException implements Exception {
  const BackupException(this.rejection);

  final BackupRejection rejection;

  @override
  String toString() => 'BackupException(${rejection.name})';
}

/// A validated backup, ready to be described to the reader or restored.
class BackupData {
  const BackupData({
    required this.exportedAt,
    required this.appVersion,
    required this.schemaVersion,
    required this.tables,
  });

  final DateTime exportedAt;
  final String appVersion;
  final int schemaVersion;
  final Map<String, List<Map<String, Object?>>> tables;

  int countOf(String table) => tables[table]?.length ?? 0;

  /// The two numbers worth showing before replacing everything: they are
  /// what a reader recognises their own data by.
  int get noteCount => countOf('notes');
  int get chapterCount => countOf('readings');

  /// The app language this backup pins, or null when it followed the system.
  /// Lets the caller confirm the restore in the language the reader is about
  /// to get rather than the one they are leaving.
  String? get localeCode {
    for (final Map<String, Object?> row
        in tables['settings'] ?? const <Map<String, Object?>>[]) {
      if (row['key'] == 'app_locale') {
        final Object? value = row['value'];
        return value is String && value.isNotEmpty ? value : null;
      }
    }
    return null;
  }
}

/// Serialises the whole database to a single JSON document, and reads one
/// back.
///
/// Plain readable JSON is a deliberate choice: this app's promise is that
/// data never leaves the device unless the reader sends it somewhere, and a
/// file they can open and read for themselves is the only version of that
/// promise they can actually check. It also means a backup outlives the app
/// — the notes are recoverable with a text editor.
class BackupService {
  BackupService({LocalDbService? dbService})
    : _db = dbService ?? LocalDbService();

  final LocalDbService _db;

  /// The whole database as pretty-printed JSON.
  Future<String> exportToJson({required String appVersion}) async {
    final Map<String, Object?> tables = <String, Object?>{};
    final Map<String, Object?> counts = <String, Object?>{};
    for (final String table in LocalDbService.backupTables) {
      final List<Map<String, Object?>> rows = await _db.readBackupTable(table);
      tables[table] = rows;
      counts[table] = rows.length;
    }

    return const JsonEncoder.withIndent('  ').convert(<String, Object?>{
      'format': kBackupFormat,
      'formatVersion': kBackupFormatVersion,
      'appVersion': appVersion,
      'schemaVersion': LocalDbService.schemaVersion,
      'exportedAt': DateTime.now().toUtc().toIso8601String(),
      'counts': counts,
      'tables': tables,
    });
  }

  /// Suggested file name, dated so several backups sort readably together.
  String fileNameFor(DateTime date) {
    String two(int n) => n.toString().padLeft(2, '0');
    return 'jwstreak-backup-${date.year}-${two(date.month)}-${two(date.day)}.json';
  }

  /// Parses and checks [json], throwing [BackupException] if it can't be
  /// trusted. Nothing is written here — the caller decides whether to go
  /// ahead after showing the reader what the file holds.
  BackupData parse(String json) {
    final Object? decoded;
    try {
      decoded = jsonDecode(json);
    } on FormatException {
      throw const BackupException(BackupRejection.unreadable);
    }
    if (decoded is! Map<String, Object?>) {
      throw const BackupException(BackupRejection.unreadable);
    }
    if (decoded['format'] != kBackupFormat) {
      throw const BackupException(BackupRejection.notABackup);
    }

    final Object? formatVersion = decoded['formatVersion'];
    if (formatVersion is! int) {
      throw const BackupException(BackupRejection.corrupt);
    }
    if (formatVersion > kBackupFormatVersion) {
      throw const BackupException(BackupRejection.tooNew);
    }

    final Object? rawTables = decoded['tables'];
    if (rawTables is! Map<String, Object?>) {
      throw const BackupException(BackupRejection.corrupt);
    }

    final Map<String, List<Map<String, Object?>>> tables =
        <String, List<Map<String, Object?>>>{};
    for (final String table in LocalDbService.backupTables) {
      final Object? rows = rawTables[table];
      // A missing table is tolerated: a backup taken before that table
      // existed is still worth restoring, and it simply restores empty.
      if (rows == null) {
        tables[table] = const <Map<String, Object?>>[];
        continue;
      }
      if (rows is! List<Object?>) {
        throw const BackupException(BackupRejection.corrupt);
      }
      tables[table] = <Map<String, Object?>>[
        for (final Object? row in rows)
          if (row is Map<String, Object?>)
            row
          else
            throw const BackupException(BackupRejection.corrupt),
      ];
    }

    final Object? exportedAt = decoded['exportedAt'];
    final DateTime? parsedDate = exportedAt is String
        ? DateTime.tryParse(exportedAt)
        : null;
    if (parsedDate == null) {
      throw const BackupException(BackupRejection.corrupt);
    }

    return BackupData(
      exportedAt: parsedDate.toLocal(),
      appVersion: decoded['appVersion'] is String
          ? decoded['appVersion']! as String
          : '?',
      schemaVersion: decoded['schemaVersion'] is int
          ? decoded['schemaVersion']! as int
          : 0,
      tables: tables,
    );
  }

  /// Wipes the database and writes [data] in its place, in one transaction.
  ///
  /// Columns the current schema doesn't have are dropped rather than causing
  /// a failure, so a backup from an older *or* slightly different build
  /// still restores what it can instead of being refused wholesale.
  Future<void> restore(BackupData data) async {
    await _db.replaceAllData(data.tables);
  }
}

/// Bumped after a restore replaces the database underneath a running app.
///
/// Reading data is easy to refresh — the dashboard reloads when Settings
/// closes. Theme, language and skin are different: they live in the widget
/// at the root of the app, which has no reason to suspect the rows it read
/// at startup have just been swapped. Rather than thread a callback down
/// through four widgets to reach the one screen that can trigger this, the
/// root listens here.
final ValueNotifier<int> backupRestoredTick = ValueNotifier<int>(0);

/// Tells the app that the database has been replaced.
void notifyBackupRestored() => backupRestoredTick.value++;
