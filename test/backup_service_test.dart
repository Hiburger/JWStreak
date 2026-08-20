import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/backup_service.dart';
import 'package:jwstreak/services/local_db_service.dart';

import 'support/db_test_harness.dart';

/// Fills every table a backup covers, so a round trip proves the whole
/// database survives rather than only the tables a test remembered.
Future<void> _seed(LocalDbService db) async {
  await db.markChapterRead(book: 'Genesis', chapter: 1);
  await db.markChapterRead(book: 'Genesis', chapter: 2);
  await db.createNote(
    title: 'Ma note',
    book: 'Genesis',
    chapter: 1,
    content: 'ligne un\nligne deux',
  );
  await db.saveQuizResult(quizId: 'Genesis#0', score: 3, total: 3);
  await db.saveReflection(
    promptId: 'p1',
    book: 'Genesis',
    chapter: 1,
    answer: 'une réflexion',
  );
  await db.addReminder(hour: 7, minute: 30);
  await db.saveAppLocale('pl');
  await db.setGuidedTourDone();
}

void main() {
  useTestDatabase();

  test('a backup carries every table the database has', () async {
    final LocalDbService db = LocalDbService();
    await _seed(db);

    final String json = await BackupService().exportToJson(
      appVersion: '1.6.2+13',
    );
    final Map<String, Object?> decoded =
        jsonDecode(json) as Map<String, Object?>;
    final Map<String, Object?> tables =
        decoded['tables']! as Map<String, Object?>;

    for (final String table in LocalDbService.backupTables) {
      expect(tables.containsKey(table), isTrue, reason: '$table missing');
    }
    expect(decoded['format'], kBackupFormat);
    expect(decoded['formatVersion'], kBackupFormatVersion);
    expect(decoded['appVersion'], '1.6.2+13');
  });

  test('export then wipe then restore brings everything back', () async {
    final LocalDbService db = LocalDbService();
    await _seed(db);

    final BackupService backup = BackupService();
    final String json = await backup.exportToJson(appVersion: '1.6.2+13');

    // The real scenario: a different device, with nothing on it.
    await db.replaceAllData(<String, List<Map<String, Object?>>>{});
    expect(await db.getNotesCount(), 0);
    expect(await db.getReadChapterKeys(), isEmpty);

    await backup.restore(backup.parse(json));

    expect(await db.getReadChapterKeys(), <String>{'Genesis|1', 'Genesis|2'});
    expect(await db.getNotesCount(), 1);
    final NoteEntry note = (await db.getAllNotes()).single;
    expect(note.title, 'Ma note');
    expect(note.content, 'ligne un\nligne deux');
    expect(await db.getCompletedQuizIds(), <String>{'Genesis#0'});
    expect((await db.getReminders()).single.hour, 7);
    expect(await db.getAppLocale(), 'pl');
    expect(await db.isGuidedTourDone(), isTrue);
  });

  test('restoring replaces what is already there, never merges', () async {
    final LocalDbService db = LocalDbService();
    await db.createNote(
      title: 'Ancienne',
      book: 'Genesis',
      chapter: 1,
      content: 'a',
    );
    final String json = await BackupService().exportToJson(appVersion: 'test');

    await db.createNote(
      title: 'Écrite après',
      book: 'Exodus',
      chapter: 2,
      content: 'b',
    );
    expect(await db.getNotesCount(), 2);

    final BackupService backup = BackupService();
    await backup.restore(backup.parse(json));

    final List<NoteEntry> notes = await db.getAllNotes();
    expect(notes, hasLength(1));
    expect(notes.single.title, 'Ancienne');
  });

  test('the counts shown before restoring match the file', () async {
    final LocalDbService db = LocalDbService();
    await _seed(db);
    final BackupService backup = BackupService();

    final BackupData data = backup.parse(
      await backup.exportToJson(appVersion: 'test'),
    );

    expect(data.noteCount, 1);
    expect(data.chapterCount, 2);
    expect(
      data.exportedAt.isBefore(DateTime.now().add(Duration(minutes: 1))),
      isTrue,
    );
  });

  test('an empty database backs up and restores without complaint', () async {
    final BackupService backup = BackupService();
    final String json = await backup.exportToJson(appVersion: 'test');
    await backup.restore(backup.parse(json));
    expect(await LocalDbService().getNotesCount(), 0);
  });

  group('a file that cannot be trusted is refused', () {
    final BackupService backup = BackupService();

    test('plain nonsense', () {
      expect(
        () => backup.parse('not json at all'),
        throwsA(
          isA<BackupException>().having(
            (BackupException e) => e.rejection,
            'rejection',
            BackupRejection.unreadable,
          ),
        ),
      );
    });

    test('valid JSON from somewhere else', () {
      expect(
        () => backup.parse('{"hello": "world"}'),
        throwsA(
          isA<BackupException>().having(
            (BackupException e) => e.rejection,
            'rejection',
            BackupRejection.notABackup,
          ),
        ),
      );
    });

    test('written by a newer version of the app', () {
      final String json = jsonEncode(<String, Object?>{
        'format': kBackupFormat,
        'formatVersion': kBackupFormatVersion + 1,
        'exportedAt': DateTime.now().toIso8601String(),
        'tables': <String, Object?>{},
      });
      expect(
        () => backup.parse(json),
        throwsA(
          isA<BackupException>().having(
            (BackupException e) => e.rejection,
            'rejection',
            BackupRejection.tooNew,
          ),
        ),
      );
    });

    test('ours, but with a mangled table', () {
      final String json = jsonEncode(<String, Object?>{
        'format': kBackupFormat,
        'formatVersion': kBackupFormatVersion,
        'exportedAt': DateTime.now().toIso8601String(),
        'tables': <String, Object?>{'notes': 'this should be a list'},
      });
      expect(
        () => backup.parse(json),
        throwsA(
          isA<BackupException>().having(
            (BackupException e) => e.rejection,
            'rejection',
            BackupRejection.corrupt,
          ),
        ),
      );
    });
  });

  test('a table missing from an older backup restores as empty', () async {
    final LocalDbService db = LocalDbService();
    await _seed(db);

    final Map<String, Object?> decoded =
        jsonDecode(await BackupService().exportToJson(appVersion: 'test'))
            as Map<String, Object?>;
    (decoded['tables']! as Map<String, Object?>).remove('easter_eggs');

    final BackupService backup = BackupService();
    final BackupData data = backup.parse(jsonEncode(decoded));
    await backup.restore(data);

    expect(await db.getNotesCount(), 1);
    expect(await db.getFoundEasterEggIds(), isEmpty);
  });

  test('a column this build does not know is dropped, not fatal', () async {
    // Forward compatibility: a backup from a later version that added a
    // column should still restore everything the two versions share
    final LocalDbService db = LocalDbService();
    await _seed(db);

    final Map<String, Object?> decoded =
        jsonDecode(await BackupService().exportToJson(appVersion: 'test'))
            as Map<String, Object?>;
    final List<Object?> notes =
        (decoded['tables']! as Map<String, Object?>)['notes']! as List<Object?>;
    (notes.first! as Map<String, Object?>)['moodRating'] = 5;

    final BackupService backup = BackupService();
    await backup.restore(backup.parse(jsonEncode(decoded)));

    expect(await db.getNotesCount(), 1);
    expect((await db.getAllNotes()).single.title, 'Ma note');
  });

  test('a backup reports the language it pins', () async {
    // Drives the success message after a restore: it must greet the reader
    // in the language they are about to get, not the one they are leaving
    final LocalDbService db = LocalDbService();
    await db.saveAppLocale('ru');
    final BackupService backup = BackupService();

    final BackupData data = backup.parse(
      await backup.exportToJson(appVersion: 'test'),
    );

    expect(data.localeCode, 'ru');
  });

  test('a backup that follows the system language pins nothing', () async {
    final BackupService backup = BackupService();
    final BackupData data = backup.parse(
      await backup.exportToJson(appVersion: 'test'),
    );
    expect(data.localeCode, isNull);
  });

  test('onboarding state travels with the backup', () async {
    // This is what lets a restore on a new phone skip setup entirely and
    // land the reader on their own dashboard
    final LocalDbService db = LocalDbService();
    await db.setGuidedTourDone();
    await db.setOnboardingDone();
    final BackupService backup = BackupService();
    final String json = await backup.exportToJson(appVersion: 'test');

    await db.replaceAllData(<String, List<Map<String, Object?>>>{});
    expect(await db.isOnboardingDone(), isFalse);

    await backup.restore(backup.parse(json));
    expect(await db.isOnboardingDone(), isTrue);
    expect(await db.isGuidedTourDone(), isTrue);
  });
}
