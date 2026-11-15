import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../achievements_data.dart';
import '../app_constants.dart';
import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../reading_plan.dart';
import '../theme/app_skin.dart';
import '../theme/theme_preference.dart';

class ReminderSettings {
  const ReminderSettings({
    required this.hour,
    required this.minute,
    required this.book,
    required this.chapter,
  });

  final int hour;
  final int minute;
  final String book;
  final int chapter;
}

class DailyTextReminderSettings {
  const DailyTextReminderSettings({
    required this.enabled,
    required this.hour,
    required this.minute,
  });

  final bool enabled;
  final int hour;
  final int minute;
}

class NoteEntry {
  const NoteEntry({
    required this.id,
    required this.title,
    required this.book,
    required this.chapter,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    this.position = 0,
  });

  final int id;
  final String title;
  final String book;
  final int chapter;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double position;

  /// Title to display: explicit title, else first line of content,
  /// else a placeholder.
  String displayTitle(BuildContext context) {
    if (title.trim().isNotEmpty) {
      return title.trim();
    }
    final String firstLine = content
        .trim()
        .split('\n')
        .first
        .replaceAll(RegExp(r'^[#>*\-\s]+'), '')
        .trim();
    return firstLine.isEmpty
        ? AppLocalizations.of(context)!.noteUntitled
        : firstLine;
  }
}

/// Sort orders for the notes library. [manual] is the reader's own drag order persisted in the position column
enum NoteSortOrder {
  recentlyUpdated,
  recentlyCreated,
  titleAZ,
  bibleOrder,
  manual,
}

/// "Created when" buckets for the notes library filter.
enum NoteCreatedFilter { all, today, thisWeek, thisMonth, earlier }

({DateTime? after, DateTime? before}) noteCreatedBounds(
  NoteCreatedFilter filter,
  DateTime now,
) {
  final DateTime day = DateTime(now.year, now.month, now.day);
  switch (filter) {
    case NoteCreatedFilter.all:
      return (after: null, before: null);
    case NoteCreatedFilter.today:
      return (after: day, before: null);
    case NoteCreatedFilter.thisWeek:
      // ISO weeks start on Monday.
      return (
        after: day.subtract(Duration(days: now.weekday - 1)),
        before: null,
      );
    case NoteCreatedFilter.thisMonth:
      return (after: DateTime(now.year, now.month, 1), before: null);
    case NoteCreatedFilter.earlier:
      return (after: null, before: DateTime(now.year, now.month, 1));
  }
}

/// Day key (yyyy-MM-dd) for [d], matching what the streak/break tables store.
String dayKeyOf(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

/// The calendar day before [now], at local midnight. Built with the
/// DateTime constructor's component normalisation (day 0 rolls back into
/// the previous month) rather than by subtracting 24 hours, which across a
/// daylight-saving change can land on the wrong day.
DateTime yesterdayOf(DateTime now) =>
    DateTime(now.year, now.month, now.day - 1);

/// Whether [day] has no recorded activity (reading or quiz) among
/// [activityDays] — i.e. the day was missed. Day-granular, so the time
/// component of either side is ignored.
bool dayWasMissed(Iterable<DateTime> activityDays, DateTime day) {
  final DateTime d = DateTime(day.year, day.month, day.day);
  return !activityDays.any(
    (DateTime a) => a.year == d.year && a.month == d.month && a.day == d.day,
  );
}

class StreakState {
  const StreakState({
    required this.count,
    required this.freezes,
    required this.activeToday,
    required this.justLost,
  });

  final int count;
  final int freezes;
  final bool activeToday; // an activity was recorded today
  final bool justLost; // the streak broke since the user last saw it
}

class Reminder {
  const Reminder({required this.id, required this.hour, required this.minute});

  final int id;
  final int hour;
  final int minute;

  String get label =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

class QuizResult {
  const QuizResult({
    required this.quizId,
    required this.score,
    required this.total,
    required this.passedAt,
  });

  final String quizId;
  final int score;
  final int total;
  final DateTime passedAt;

  bool get isPerfect => total > 0 && score == total;

  /// 1-3 stars based on the ratio (0 only when nothing correct).
  int get stars => total == 0 ? 0 : ((score / total) * 3).ceil().clamp(1, 3);
}

/// The streak count after a day of activity, or null when there is nothing
/// to record.
///
/// Null covers two cases that both mean "leave the streak alone": activity
/// was already counted today, and the stored chain sits *ahead* of today.
///
/// A chain in the future is what happens to someone who travels. Crossing
/// westward over enough longitude moves the local date backwards, so a
/// reading logged yesterday in Tokyo can be dated tomorrow once they land in
/// Los Angeles. This used to fall through to `count = 1`: the difference came
/// out negative, missed the "exactly one day" branch, and silently reset a
/// long streak to 1 the moment a traveller opened the app after a flight.
///
/// The conservative reading is that the reader has done nothing wrong, so the
/// streak is held where it is until the local date catches up with the chain.
@visibleForTesting
int? nextStreakCount({
  required String? chainKey,
  required DateTime today,
  required int currentCount,
}) {
  if (chainKey == null) {
    return 1; // First ever activity.
  }
  // tryParse, not parse: this value can come back from a restored backup,
  // and a hand-edited or truncated file would otherwise throw here — inside
  // the path that records a chapter as read. Losing the chain costs the
  // reader a streak; throwing costs them the ability to mark anything read
  // at all.
  final DateTime? chain = DateTime.tryParse(chainKey);
  if (chain == null) {
    return 1;
  }
  final int gap = DateTime(
    today.year,
    today.month,
    today.day,
  ).difference(DateTime(chain.year, chain.month, chain.day)).inDays;
  if (gap <= 0) {
    return null;
  }
  return gap == 1 ? currentCount + 1 : 1;
}

/// A planned break from daily reading. Tiers differ in length, and each has
/// a yearly usage cap (the longer the break, the fewer times per year), precaution to preserve the reading habit
enum BreakTier {
  mini(1, 12),
  small(3, 6),
  medium(7, 3),
  big(14, 1);

  const BreakTier(this.durationDays, this.yearlyCap);
  final int durationDays;
  final int yearlyCap;
}

/// One row of the breaks table: a break of [tier] covering [startDay]..[endDay] inclusive (yyyy-MM-dd day keys)
class Break {
  const Break({
    required this.id,
    required this.tier,
    required this.startDay,
    required this.endDay,
    this.reason = '',
  });

  final int id;
  final BreakTier tier;
  final String startDay;
  final String endDay;
  final String reason;

  bool covers(String dayKey) =>
      dayKey.compareTo(startDay) >= 0 && dayKey.compareTo(endDay) <= 0;
}

/// whether [dayKey] (yyyy-MM-dd) falls inside any of [breaks]
bool isDayInBreaks(Iterable<Break> breaks, String dayKey) =>
    breaks.any((Break b) => b.covers(dayKey));

/// After the latest break ends there's a cooldown so breaks can't be chained and abused. Not reading for a while can easily make the habit dissapear
DateTime? nextBreakAllowedOn(Iterable<Break> breaks, DateTime today) {
  Break? last;
  for (final Break b in breaks) {
    if (last == null || b.endDay.compareTo(last.endDay) > 0) {
      last = b;
    }
  }
  if (last == null) {
    return null;
  }
  final DateTime end = DateTime.parse(last.endDay);
  final int cooldown = last.tier.durationDays < 7 ? 7 : last.tier.durationDays;
  final DateTime allowed = DateTime(end.year, end.month, end.day + cooldown);
  final DateTime day = DateTime(today.year, today.month, today.day);
  return allowed.isAfter(day) ? allowed : null;
}

class LocalDbService {
  LocalDbService._internal();

  static final LocalDbService _instance = LocalDbService._internal();
  factory LocalDbService() => _instance;

  static const String _databaseName = 'jwstreak.db';
  Database? _database;

  Future<void> initialize() async {
    await _getDb();
  }

  Future<Database> _getDb() async {
    _database ??= await _openDatabase();
    return _database!;
  }

  /// Closes and forgets the cached connection so a test can start from a
  /// clean database. Production code never needs this — the singleton is
  /// meant to live for the whole life of the process.
  @visibleForTesting
  Future<void> resetForTesting() async {
    await _database?.close();
    _database = null;
  }

  /// Every table a backup covers, in the order a restore must write them.
  /// Order matters only for readability here — none of these carry foreign
  /// keys — but keeping one list means a table added later gets backed up by
  /// changing a single line rather than three functions.
  static const List<String> backupTables = <String>[
    'readings',
    'notes',
    'quiz_results',
    'reflections',
    'reminders',
    'frozen_days',
    'achievements',
    'easter_eggs',
    'breaks',
    'settings',
  ];

  /// The schema version a backup file records, so a later app version can
  /// tell how to read it.
  static const int schemaVersion = 9;

  /// Raw rows of [table], for the backup serializer. Deliberately not a
  /// general-purpose query hatch: it accepts only the known backup tables,
  /// so a caller can't reach arbitrary SQL through it.
  Future<List<Map<String, Object?>>> readBackupTable(String table) async {
    assert(backupTables.contains(table), 'unknown backup table: $table');
    final Database db = await _getDb();
    return db.query(table);
  }

  /// Replaces the whole database with [tables] in one transaction: either
  /// every table is swapped or none is, so a file that turns out to be bad
  /// partway through can't leave the reader with half their data gone.
  ///
  /// Columns this build doesn't know are dropped instead of throwing. That
  /// is what lets a backup taken on a newer version still restore here — it
  /// brings back everything the two versions have in common rather than
  /// being refused outright.
  Future<void> replaceAllData(
    Map<String, List<Map<String, Object?>>> tables,
  ) async {
    final Database db = await _getDb();
    await db.transaction((Transaction txn) async {
      for (final String table in backupTables) {
        final Set<String> columns = <String>{
          for (final Map<String, Object?> column in await txn.rawQuery(
            'PRAGMA table_info($table)',
          ))
            column['name']! as String,
        };
        await txn.delete(table);
        for (final Map<String, Object?> row
            in tables[table] ?? const <Map<String, Object?>>[]) {
          final Map<String, Object?> known = <String, Object?>{
            for (final MapEntry<String, Object?> cell in row.entries)
              if (columns.contains(cell.key)) cell.key: cell.value,
          };
          if (known.isNotEmpty) {
            await txn.insert(table, known);
          }
        }
      }
    });
  }

  static const String _createNotesTableSql = '''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL DEFAULT '',
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            content TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''';

  /// Fresh installs get the position column straight away; existing
  /// databases reach the same shape through the v8 upgrade below. Nullable
  /// on purpose: a backup from before this column restores rows without it,
  /// and those NULLs are what backfillNotePositions looks for.
  static const String _createNotesTableV8Sql = '''
          CREATE TABLE notes (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL DEFAULT '',
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            content TEXT NOT NULL,
            createdAt TEXT NOT NULL,
            updatedAt TEXT NOT NULL,
            position REAL
          )
        ''';

  static const String _createQuizResultsTableSql = '''
          CREATE TABLE quiz_results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            quizId TEXT NOT NULL UNIQUE,
            score INTEGER NOT NULL,
            total INTEGER NOT NULL,
            passedAt TEXT NOT NULL
          )
        ''';

  static const String _createReflectionsTableSql = '''
          CREATE TABLE reflections (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            promptId TEXT NOT NULL UNIQUE,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            answer TEXT NOT NULL,
            updatedAt TEXT NOT NULL
          )
        ''';

  static const String _createRemindersTableSql = '''
          CREATE TABLE reminders (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hour INTEGER NOT NULL,
            minute INTEGER NOT NULL
          )
        ''';

  static const String _createFrozenDaysTableSql = '''
          CREATE TABLE frozen_days (
            day TEXT PRIMARY KEY
          )
        ''';

  static const String _createAchievementsTableSql = '''
          CREATE TABLE achievements (
            id TEXT PRIMARY KEY,
            unlockedAt TEXT NOT NULL
          )
        ''';

  static const String _createEasterEggsTableSql = '''
          CREATE TABLE easter_eggs (
            id TEXT PRIMARY KEY,
            foundAt TEXT NOT NULL
          )
        ''';

  static const String _createBreaksTableSql = '''
          CREATE TABLE breaks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tier TEXT NOT NULL,
            startDay TEXT NOT NULL,
            endDay TEXT NOT NULL,
            reason TEXT NOT NULL DEFAULT ''
          )
        ''';

  Future<Database> _openDatabase() async {
    final String dbPath = join(await getDatabasesPath(), _databaseName);
    final Database db = await openDatabase(
      dbPath,
      version: 9,
      onCreate: (Database database, int version) async {
        await database.execute('''
          CREATE TABLE readings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            readAt TEXT NOT NULL
          )
        ''');

        await database.execute(_createNotesTableV8Sql);
        await database.execute(_createQuizResultsTableSql);
        await database.execute(_createReflectionsTableSql);
        await database.execute(_createRemindersTableSql);
        await database.execute(_createFrozenDaysTableSql);
        await database.execute(_createAchievementsTableSql);
        await database.execute(_createEasterEggsTableSql);
        await database.execute(_createBreaksTableSql);

        await database.execute('''
          CREATE TABLE settings (
            key TEXT PRIMARY KEY,
            value TEXT NOT NULL
          )
        ''');
      },
      onUpgrade: (Database database, int oldVersion, int newVersion) async {
        if (oldVersion < 7) {
          await database.execute(_createEasterEggsTableSql);
        }
        if (oldVersion < 6) {
          await database.execute(_createAchievementsTableSql);
        }
        if (oldVersion < 5) {
          await database.execute(_createFrozenDaysTableSql);
        }
        if (oldVersion < 4) {
          await database.execute(_createRemindersTableSql);
          // Migrate the former single reminder (stored in settings) into the
          // new multi-reminder table.
          final List<Map<String, Object?>> rows = await database.query(
            'settings',
            where: 'key IN (?, ?)',
            whereArgs: const <String>['reminder_hour', 'reminder_minute'],
          );
          int? hour;
          int? minute;
          for (final Map<String, Object?> row in rows) {
            final Object? key = row['key'];
            final Object? value = row['value'];
            if (value is! String) {
              continue;
            }
            if (key == 'reminder_hour') {
              hour = int.tryParse(value);
            } else if (key == 'reminder_minute') {
              minute = int.tryParse(value);
            }
          }
          if (hour != null && minute != null) {
            await database.insert('reminders', <String, Object>{
              'hour': hour,
              'minute': minute,
            });
          }
        }
        if (oldVersion < 3) {
          await database.execute(_createQuizResultsTableSql);
          await database.execute(_createReflectionsTableSql);
        }
        if (oldVersion < 2) {
          // v1 keyed notes by (book, chapter), allowing a single note per
          // chapter. v2 gives each note its own id, title and createdAt.
          await database.execute(
            _createNotesTableSql.replaceFirst(
              'CREATE TABLE notes',
              'CREATE TABLE notes_v2',
            ),
          );
          await database.execute('''
            INSERT INTO notes_v2 (title, book, chapter, content, createdAt, updatedAt)
            SELECT '', book, chapter, content, updatedAt, updatedAt FROM notes
          ''');
          await database.execute('DROP TABLE notes');
          await database.execute('ALTER TABLE notes_v2 RENAME TO notes');
        }
        // Last on purpose: the v2 step above recreates the notes table from
        // the position-less schema, so the column can only be added after it.
        if (oldVersion < 8) {
          await database.execute('ALTER TABLE notes ADD COLUMN position REAL');
          await _backfillNotePositions(database);
        }
        if (oldVersion < 9) {
          await database.execute(_createBreaksTableSql);
        }
      },
    );

    await _seedDefaults(db);
    return db;
  }

  Future<void> _seedDefaults(Database db) async {
    await db.insert('settings', {
      'key': 'default_book',
      'value': kDefaultBook,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.insert('settings', {
      'key': 'default_chapter',
      'value': kDefaultChapter.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
    await db.insert('settings', {
      'key': 'theme_preference',
      'value': ThemePreference.system.storageValue,
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Reminder>> getReminders() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'reminders',
      orderBy: 'hour, minute',
    );
    return rows
        .map(
          (Map<String, Object?> r) => Reminder(
            id: r['id'] as int,
            hour: r['hour'] as int,
            minute: r['minute'] as int,
          ),
        )
        .toList(growable: false);
  }

  Future<Reminder> addReminder({required int hour, required int minute}) async {
    final Database db = await _getDb();
    final int id = await db.insert('reminders', <String, Object>{
      'hour': hour,
      'minute': minute,
    });
    return Reminder(id: id, hour: hour, minute: minute);
  }

  Future<void> deleteReminder(int id) async {
    final Database db = await _getDb();
    await db.delete('reminders', where: 'id = ?', whereArgs: <Object>[id]);
  }

  Future<void> saveReminderSettings(ReminderSettings settings) async {
    final Database db = await _getDb();
    final Batch batch = db.batch();
    batch.insert('settings', {
      'key': 'reminder_hour',
      'value': settings.hour.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    batch.insert('settings', {
      'key': 'reminder_minute',
      'value': settings.minute.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    batch.insert('settings', {
      'key': 'reminder_book',
      'value': settings.book,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    batch.insert('settings', {
      'key': 'reminder_chapter',
      'value': settings.chapter.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    await batch.commit(noResult: true);
  }

  Future<ReminderSettings?> getReminderSettings() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'settings',
      where: 'key IN (?, ?, ?, ?)',
      whereArgs: const [
        'reminder_hour',
        'reminder_minute',
        'reminder_book',
        'reminder_chapter',
      ],
    );

    if (rows.isEmpty) {
      return null;
    }

    final Map<String, String> values = <String, String>{};
    for (final Map<String, Object?> row in rows) {
      final Object? key = row['key'];
      final Object? value = row['value'];
      if (key is String && value is String) {
        values[key] = value;
      }
    }

    final String? hourValue = values['reminder_hour'];
    final String? minuteValue = values['reminder_minute'];
    final String? book = values['reminder_book'];
    final String? chapterValue = values['reminder_chapter'];

    if (hourValue == null ||
        minuteValue == null ||
        book == null ||
        chapterValue == null) {
      return null;
    }

    final int? hour = int.tryParse(hourValue);
    final int? minute = int.tryParse(minuteValue);
    final int? chapter = int.tryParse(chapterValue);
    if (hour == null || minute == null || chapter == null) {
      throw const FormatException(
        'Invalid reminder settings in local database.',
      );
    }

    return ReminderSettings(
      hour: hour,
      minute: minute,
      book: book,
      chapter: chapter,
    );
  }

  Future<void> markChapterRead({
    required String book,
    required int chapter,
  }) async {
    final Database db = await _getDb();
    await db.insert('readings', <String, Object>{
      'book': book,
      'chapter': chapter,
      'readAt': DateTime.now().toIso8601String(),
    });
    await _recordStreakActivity(db);
  }

  Future<void> unmarkChapterRead({
    required String book,
    required int chapter,
  }) async {
    final Database db = await _getDb();
    await db.delete(
      'readings',
      where: 'book = ? AND chapter = ?',
      whereArgs: <Object>[book, chapter],
    );
  }

  /// Distinct "book|chapter" keys that have at least one reading.
  Future<Set<String>> getReadChapterKeys() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      'SELECT DISTINCT book, chapter FROM readings',
    );
    return rows
        .map((Map<String, Object?> r) => '${r['book']}|${r['chapter']}')
        .toSet();
  }

  Future<int> getTotalReadings() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM readings',
    );
    return (result.first['total'] as int?) ?? 0;
  }

  Future<int> getCurrentStreak() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.rawQuery('''
      SELECT DISTINCT substr(readAt, 1, 10) AS readingDay
      FROM readings
      ORDER BY readingDay DESC
    ''');

    if (rows.isEmpty) {
      return 0;
    }

    DateTime? previousDay;
    int streak = 0;
    final DateTime today = _dateOnly(DateTime.now());
    final DateTime yesterday = today.subtract(const Duration(days: 1));

    for (final Map<String, Object?> row in rows) {
      final Object? value = row['readingDay'];
      if (value is! String) {
        throw const FormatException(
          'Invalid readingDay value in local database.',
        );
      }
      final DateTime current = _dateOnly(DateTime.parse(value));

      if (previousDay == null) {
        if (current != today && current != yesterday) {
          return 0;
        }
        streak = 1;
        previousDay = current;
        continue;
      }

      final int diff = previousDay.difference(current).inDays;
      if (diff == 1) {
        streak += 1;
        previousDay = current;
      } else {
        break;
      }
    }
    return streak;
  }

  /// Days that count as "active" — the same two things that keep a streak
  /// alive, marking a chapter read *or* finishing a quiz.
  ///
  /// Both are unioned here because `_recordStreakActivity` is called from
  /// [markChapterRead] and [saveQuizResult] alike. Reading only the
  /// `readings` table made the streak calendar disagree with the streak
  /// itself: a day spent on quizzes counted toward the number at the top of
  /// the screen but showed as missed on the grid below it.
  Future<List<DateTime>> getRecentReadingDays({int limit = 14}) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      '''
      SELECT readingDay FROM (
        SELECT substr(readAt, 1, 10) AS readingDay FROM readings
        UNION
        SELECT substr(passedAt, 1, 10) AS readingDay FROM quiz_results
      )
      ORDER BY readingDay DESC
      LIMIT ?
      ''',
      <Object>[limit],
    );

    return rows
        .map((Map<String, Object?> row) {
          final Object? value = row['readingDay'];
          if (value is! String) {
            throw const FormatException(
              'Invalid readingDay value in local database.',
            );
          }
          return DateTime.parse(value);
        })
        .toList(growable: false);
  }

  /// Saves a quiz result. Returns `true` if this was the quiz's first-ever
  /// completion and it happens to be the [kQuizzesPerFreeze]th, 2×, 3×, ...
  /// distinct quiz ever completed — which awards +1 streak freeze. Replaying
  /// an already-completed quiz updates its score but never awards a freeze.
  Future<bool> saveQuizResult({
    required String quizId,
    required int score,
    required int total,
  }) async {
    final Database db = await _getDb();
    final bool isNewCompletion = await getQuizResult(quizId) == null;

    await db.insert('quiz_results', <String, Object>{
      'quizId': quizId,
      'score': score,
      'total': total,
      'passedAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    await _recordStreakActivity(db);

    if (!isNewCompletion) {
      return false;
    }
    final int distinctCompletedCount = (await getCompletedQuizIds()).length;
    if (distinctCompletedCount % kQuizzesPerFreeze != 0) {
      return false;
    }
    await addStreakFreeze();
    return true;
  }

  Future<QuizResult?> getQuizResult(String quizId) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'quiz_results',
      where: 'quizId = ?',
      whereArgs: <Object>[quizId],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return _quizResultFromRow(rows.first);
  }

  QuizResult _quizResultFromRow(Map<String, Object?> r) {
    return QuizResult(
      quizId: r['quizId'] as String,
      score: (r['score'] as int?) ?? 0,
      total: (r['total'] as int?) ?? 0,
      passedAt: DateTime.parse(r['passedAt'] as String),
    );
  }

  /// Quiz ids that have a stored result (used for badges/unlock display).
  Future<Set<String>> getCompletedQuizIds() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'quiz_results',
      columns: const <String>['quizId'],
    );
    return rows.map((Map<String, Object?> r) => r['quizId'] as String).toSet();
  }

  /// All quiz results keyed by quizId (score, stars and completion time).
  Future<Map<String, QuizResult>> getAllQuizResults() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query('quiz_results');
    return <String, QuizResult>{
      for (final Map<String, Object?> r in rows)
        r['quizId'] as String: _quizResultFromRow(r),
    };
  }

  /// Stars earned per book id (sum of a book's checkpoint-quiz stars). The
  /// optional full-book quiz (`<book>#full`) is excluded so earned ≤ max.
  Future<Map<String, int>> getEarnedStarsByBook() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query('quiz_results');
    final Map<String, int> stars = <String, int>{};
    for (final Map<String, Object?> row in rows) {
      final QuizResult r = _quizResultFromRow(row);
      final int hash = r.quizId.indexOf('#');
      if (hash <= 0) {
        continue;
      }
      if (r.quizId.substring(hash + 1) == 'full') {
        continue;
      }
      final String book = r.quizId.substring(0, hash);
      stars[book] = (stars[book] ?? 0) + r.stars;
    }
    return stars;
  }

  Future<void> saveReflection({
    required String promptId,
    required String book,
    required int chapter,
    required String answer,
  }) async {
    final Database db = await _getDb();
    await db.insert('reflections', <String, Object>{
      'promptId': promptId,
      'book': book,
      'chapter': chapter,
      'answer': answer,
      'updatedAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Set<String>> getAnsweredReflectionIds() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'reflections',
      columns: const <String>['promptId'],
    );
    return rows
        .map((Map<String, Object?> r) => r['promptId'] as String)
        .toSet();
  }

  Future<String?> getReflection(String promptId) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'reflections',
      columns: const <String>['answer'],
      where: 'promptId = ?',
      whereArgs: <Object>[promptId],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return rows.first['answer'] as String?;
  }

  Future<int> createNote({
    required String title,
    required String book,
    required int chapter,
    required String content,
  }) async {
    final Database db = await _getDb();
    final String now = DateTime.now().toIso8601String();
    // New notes land at the end of the custom order.
    final double maxPosition = await _maxNotePosition(db) ?? 0;
    return db.insert('notes', <String, Object>{
      'title': title,
      'book': book,
      'chapter': chapter,
      'content': content,
      'createdAt': now,
      'updatedAt': now,
      'position': maxPosition + 1024,
    });
  }

  static Future<double?> _maxNotePosition(Database db) async {
    final List<Map<String, Object?>> rows = await db.rawQuery(
      'SELECT MAX(position) AS maxPos FROM notes',
    );
    final Object? maxPos = rows.first['maxPos'];
    return maxPos is num ? maxPos.toDouble() : null;
  }

  /// Persists a note's rank in the custom order. Only the moved note is
  /// written — the drag position is fractional, so neighbours keep theirs.
  Future<void> setNotePosition(int id, double position) async {
    final Database db = await _getDb();
    await db.update(
      'notes',
      <String, Object>{'position': position},
      where: 'id = ?',
      whereArgs: <Object>[id],
    );
  }

  /// Gives a position to every note that has none (fresh migration, or a
  /// backup taken before the column existed). Ordered by last edit so the
  /// custom order starts out matching what the library already showed.
  Future<void> backfillNotePositions() async {
    await _backfillNotePositions(await _getDb());
  }

  /// The notes library's persisted view (sort + filters), so a reordered
  /// list is still in that order the next time the screen opens.
  Future<({NoteSortOrder sort, String? book, NoteCreatedFilter created})>
  getNotesViewState() async {
    final Database db = await _getDb();
    final String? sort = await _getSetting(db, 'notes_sort');
    final String? book = await _getSetting(db, 'notes_filter_book');
    final String? created = await _getSetting(db, 'notes_filter_created');
    return (
      sort: NoteSortOrder.values.asNameMap()[sort] ?? NoteSortOrder.manual,
      book: book == null || book.isEmpty ? null : book,
      created:
          NoteCreatedFilter.values.asNameMap()[created] ??
          NoteCreatedFilter.all,
    );
  }

  Future<void> saveNotesViewState({
    required NoteSortOrder sort,
    required String? book,
    required NoteCreatedFilter created,
  }) async {
    final Database db = await _getDb();
    await _setSetting(db, 'notes_sort', sort.name);
    await _setSetting(db, 'notes_filter_book', book ?? '');
    await _setSetting(db, 'notes_filter_created', created.name);
  }

  static Future<void> _backfillNotePositions(Database db) async {
    double next = await _maxNotePosition(db) ?? 0;
    final List<Map<String, Object?>> unordered = await db.query(
      'notes',
      where: 'position IS NULL',
      orderBy: 'updatedAt DESC',
    );
    for (final Map<String, Object?> row in unordered) {
      next += 1024;
      await db.update(
        'notes',
        <String, Object>{'position': next},
        where: 'id = ?',
        whereArgs: <Object>[row['id']!],
      );
    }
  }

  /// [book]/[chapter] are optional so callers that only edit the text leave
  /// the note's reading link untouched; the editor passes them when the
  /// reader re-points a note at a different chapter.
  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
    String? book,
    int? chapter,
  }) async {
    final Database db = await _getDb();
    await db.update(
      'notes',
      <String, Object>{
        'title': title,
        'content': content,
        'book': ?book,
        'chapter': ?chapter,
        'updatedAt': DateTime.now().toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: <Object>[id],
    );
  }

  Future<void> deleteNote(int id) async {
    final Database db = await _getDb();
    await db.delete('notes', where: 'id = ?', whereArgs: <Object>[id]);
  }

  Future<NoteEntry?> getNoteById(int id) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: <Object>[id],
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    return _noteFromRow(rows.first);
  }

  /// All notes linked to a specific reference (book/chapter), newest first.
  Future<List<NoteEntry>> getNotesByReference({
    required String book,
    required int chapter,
  }) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'notes',
      where: 'book = ? AND chapter = ?',
      whereArgs: <Object>[book, chapter],
      orderBy: 'updatedAt DESC',
    );
    return rows.map(_noteFromRow).toList(growable: false);
  }

  Future<List<NoteEntry>> getAllNotes({
    String query = '',
    String? book,
    NoteCreatedFilter createdFilter = NoteCreatedFilter.all,
    NoteSortOrder sort = NoteSortOrder.manual,
  }) async {
    final Database db = await _getDb();
    final String normalized = query.trim();
    final List<String> conditions = <String>[];
    final List<Object> args = <Object>[];
    if (normalized.isNotEmpty) {
      conditions.add(
        '(title LIKE ? OR book LIKE ? OR content LIKE ? OR CAST(chapter AS TEXT) LIKE ?)',
      );
      args.addAll(<Object>[
        '%$normalized%',
        '%$normalized%',
        '%$normalized%',
        '%$normalized%',
      ]);
    }
    if (book != null) {
      conditions.add('book = ?');
      args.add(book);
    }
    final (:DateTime? after, :DateTime? before) = noteCreatedBounds(
      createdFilter,
      DateTime.now(),
    );
    if (after != null) {
      conditions.add('createdAt >= ?');
      args.add(after.toIso8601String());
    }
    if (before != null) {
      conditions.add('createdAt < ?');
      args.add(before.toIso8601String());
    }
    final List<Map<String, Object?>> rows = await db.query(
      'notes',
      where: conditions.isEmpty ? null : conditions.join(' AND '),
      whereArgs: args.isEmpty ? null : args,
    );

    // Sorted here rather than in SQL: Bible order needs the book's position
    // in kBibleBooks, which the schema doesn't know about.
    final List<NoteEntry> notes = rows.map(_noteFromRow).toList();
    switch (sort) {
      case NoteSortOrder.recentlyUpdated:
        notes.sort(
          (NoteEntry a, NoteEntry b) => b.updatedAt.compareTo(a.updatedAt),
        );
      case NoteSortOrder.recentlyCreated:
        notes.sort(
          (NoteEntry a, NoteEntry b) => b.createdAt.compareTo(a.createdAt),
        );
      case NoteSortOrder.titleAZ:
        notes.sort(
          (NoteEntry a, NoteEntry b) => _noteSortTitle(
            a,
          ).toLowerCase().compareTo(_noteSortTitle(b).toLowerCase()),
        );
      case NoteSortOrder.bibleOrder:
        notes.sort((NoteEntry a, NoteEntry b) {
          final int byBook = _bookNumber(a.book).compareTo(_bookNumber(b.book));
          if (byBook != 0) {
            return byBook;
          }
          final int byChapter = a.chapter.compareTo(b.chapter);
          if (byChapter != 0) {
            return byChapter;
          }
          return b.updatedAt.compareTo(a.updatedAt);
        });
      case NoteSortOrder.manual:
        notes.sort(
          (NoteEntry a, NoteEntry b) => a.position.compareTo(b.position),
        );
    }
    return List<NoteEntry>.unmodifiable(notes);
  }

  /// Book ids that have at least one note, in Bible order — the notes
  /// library's book filter offers these rather than all 66 books.
  Future<List<String>> getNoteBookIds() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      'SELECT DISTINCT book FROM notes',
    );
    final List<String> ids = rows
        .map((Map<String, Object?> row) => row['book'] as String)
        .toList();
    ids.sort((String a, String b) => _bookNumber(a).compareTo(_bookNumber(b)));
    return List<String>.unmodifiable(ids);
  }

  static String _noteSortTitle(NoteEntry note) => note.title.trim().isNotEmpty
      ? note.title.trim()
      : note.content
            .trim()
            .split('\n')
            .first
            .replaceAll(RegExp(r'^[#>*\-\s]+'), '')
            .trim();

  static int _bookNumber(String bookId) => bibleBookById(bookId)?.number ?? 999;

  NoteEntry _noteFromRow(Map<String, Object?> row) {
    final Object? id = row['id'];
    final Object? title = row['title'];
    final Object? book = row['book'];
    final Object? chapter = row['chapter'];
    final Object? content = row['content'];
    final Object? createdAt = row['createdAt'];
    final Object? updatedAt = row['updatedAt'];
    final Object? position = row['position'];
    if (id is! int ||
        title is! String ||
        book is! String ||
        chapter is! int ||
        content is! String ||
        createdAt is! String ||
        updatedAt is! String) {
      throw const FormatException('Invalid note entry in local database.');
    }
    return NoteEntry(
      id: id,
      title: title,
      book: book,
      chapter: chapter,
      content: content,
      createdAt: DateTime.parse(createdAt),
      updatedAt: DateTime.parse(updatedAt),
      position: position is num ? position.toDouble() : 0,
    );
  }

  Future<bool> isOnboardingDone() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'settings',
      columns: const ['value'],
      where: 'key = ?',
      whereArgs: const ['onboarding_done'],
      limit: 1,
    );
    if (rows.isEmpty) {
      return false;
    }
    return rows.first['value'] == 'true';
  }

  Future<void> setOnboardingDone() async {
    final Database db = await _getDb();
    await db.insert('settings', {
      'key': 'onboarding_done',
      'value': 'true',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Whether the home-screen guided tour has already been shown. It runs once
  /// automatically after onboarding; [resetGuidedTour] lets the user replay it
  /// from the settings screen.
  Future<bool> isGuidedTourDone() async {
    final Database db = await _getDb();
    return await _getSetting(db, 'guided_tour_done') == 'true';
  }

  Future<void> setGuidedTourDone() async {
    final Database db = await _getDb();
    await _setSetting(db, 'guided_tour_done', 'true');
  }

  Future<void> resetGuidedTour() async {
    final Database db = await _getDb();
    await db.delete(
      'settings',
      where: 'key = ?',
      whereArgs: const <String>['guided_tour_done'],
    );
  }

  Future<void> saveThemePreference(ThemePreference preference) async {
    final Database db = await _getDb();
    await db.insert('settings', {
      'key': 'theme_preference',
      'value': preference.storageValue,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<ThemePreference> getThemePreference() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'settings',
      columns: const ['value'],
      where: 'key = ?',
      whereArgs: const ['theme_preference'],
      limit: 1,
    );
    if (rows.isEmpty) {
      return ThemePreference.system;
    }
    final Object? rawValue = rows.first['value'];
    if (rawValue is! String) {
      throw const FormatException(
        'Invalid theme preference in local database.',
      );
    }
    return themePreferenceFromStorage(rawValue);
  }

  /// The order chapters are handed out in.
  Future<void> saveReadingPlan(ReadingPlan plan) async {
    final Database db = await _getDb();
    await _setSetting(db, 'reading_plan', plan.storageValue);
  }

  Future<ReadingPlan> getReadingPlan() async {
    final Database db = await _getDb();
    return readingPlanFromStorage(await _getSetting(db, 'reading_plan'));
  }

  /// Where in the plan the reader said they'd pick up, as a chapter key.
  ///
  /// Stored as the chapter itself rather than an index into the plan, so
  /// switching orders later moves the resume point along with the reader
  /// instead of leaving it pointing at whatever book now sits at that index.
  ///
  /// Deliberately does *not* mark everything before it as read: the reader is
  /// telling us where to resume, not claiming they read those chapters in
  /// this app. Fabricating those rows would invent reading dates and hand out
  /// streaks and achievements nobody earned.
  Future<void> savePlanStartKey(String? key) async {
    final Database db = await _getDb();
    await _setSetting(db, 'plan_start_key', key ?? '');
  }

  Future<String?> getPlanStartKey() async {
    final Database db = await _getDb();
    final String? value = await _getSetting(db, 'plan_start_key');
    return (value == null || value.isEmpty) ? null : value;
  }

  /// The visual style (palette + signature icons + typeface), independent of
  /// the light/dark preference above.
  Future<void> saveAppSkin(AppSkin skin) async {
    final Database db = await _getDb();
    await _setSetting(db, 'app_skin', skin.storageValue);
  }

  Future<AppSkin> getAppSkin() async {
    final Database db = await _getDb();
    return appSkinFromStorage(await _getSetting(db, 'app_skin'));
  }

  Future<void> saveUseDynamicColor(bool value) async {
    final Database db = await _getDb();
    await db.insert('settings', <String, Object>{
      'key': 'use_dynamic_color',
      'value': value ? '1' : '0',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Whether to use the device's Material You wallpaper-derived palette
  /// instead of the app's fixed brand seed color (the default).
  Future<bool> getUseDynamicColor() async {
    final Database db = await _getDb();
    final String? value = await _getSetting(db, 'use_dynamic_color');
    return value == '1';
  }

  /// Whether Bible chapters should open on jw.org (web) instead of in the JW
  /// Library app. Persisted as '1' (web) / '0' (JW Library app, the default).
  Future<void> saveOpenBibleOnWeb(bool value) async {
    final Database db = await _getDb();
    await db.insert('settings', <String, Object>{
      'key': 'open_bible_on_web',
      'value': value ? '1' : '0',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Defaults to false: the JW Library app is the preferred Bible target.
  Future<bool> getOpenBibleOnWeb() async {
    final Database db = await _getDb();
    final String? value = await _getSetting(db, 'open_bible_on_web');
    return value == '1';
  }

  /// The optional "daily text" reminder: a single time, separate from the
  /// book-reading reminders list, since it points at jw.org's daily text
  /// rather than a chapter. Off by default.
  Future<void> saveDailyTextReminder({
    required bool enabled,
    required int hour,
    required int minute,
  }) async {
    final Database db = await _getDb();
    final Batch batch = db.batch();
    batch.insert('settings', <String, Object>{
      'key': 'daily_text_reminder_enabled',
      'value': enabled ? '1' : '0',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    batch.insert('settings', <String, Object>{
      'key': 'daily_text_reminder_hour',
      'value': hour.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    batch.insert('settings', <String, Object>{
      'key': 'daily_text_reminder_minute',
      'value': minute.toString(),
    }, conflictAlgorithm: ConflictAlgorithm.replace);
    await batch.commit(noResult: true);
  }

  /// Returns null hour/minute when never configured, defaulting the picker
  /// to a sensible morning time (8:00) rather than midnight.
  Future<DailyTextReminderSettings> getDailyTextReminder() async {
    final Database db = await _getDb();
    final bool enabled =
        await _getSetting(db, 'daily_text_reminder_enabled') == '1';
    final int hour =
        int.tryParse(await _getSetting(db, 'daily_text_reminder_hour') ?? '') ??
        8;
    final int minute =
        int.tryParse(
          await _getSetting(db, 'daily_text_reminder_minute') ?? '',
        ) ??
        0;
    return DailyTextReminderSettings(
      enabled: enabled,
      hour: hour,
      minute: minute,
    );
  }

  /// Whether the app asks for the device's screen lock (fingerprint, face or
  /// PIN) before showing its content. Off by default — turning it on is a
  /// deliberate choice made in settings.
  Future<void> saveAppLockEnabled(bool value) async {
    final Database db = await _getDb();
    await db.insert('settings', <String, Object>{
      'key': 'app_lock_enabled',
      'value': value ? '1' : '0',
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> getAppLockEnabled() async {
    final Database db = await _getDb();
    return await _getSetting(db, 'app_lock_enabled') == '1';
  }

  /// Persists the chosen UI language code (e.g. 'en', 'fr'), or clears it
  /// to follow the system language when [code] is null.
  Future<void> saveAppLocale(String? code) async {
    final Database db = await _getDb();
    if (code == null) {
      await db.delete(
        'settings',
        where: 'key = ?',
        whereArgs: const ['app_locale'],
      );
      return;
    }
    await db.insert('settings', <String, Object>{
      'key': 'app_locale',
      'value': code,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// null means "follow system language".
  Future<String?> getAppLocale() async {
    final Database db = await _getDb();
    return _getSetting(db, 'app_locale');
  }

  // ---------------------------------------------------------------------------
  // Streak engine (Duolingo-style, with monthly freezes).
  //
  // Activity = a chapter marked read OR a quiz completed, aggregated per day.
  // Each missed day between two active days consumes one freeze; when no freeze
  // is left to cover a gap, the streak resets to 0. Freezes refill to
  // [_monthlyFreezes] at the start of each calendar month; extra freezes can be
  // earned (e.g. a review quiz) via [addStreakFreeze].
  // PLEASE NOTE - This comment section has been written by my IA agent, I'll keep it until this file gets refactored. Some other files have similar chunks of not very necessary comments.
  // Activity = a chapter marked read OR a quiz completed, aggregated per day.
  // Each missed day between two active days consumes one freeze; when no freeze
  // is left to cover a gap, the streak resets to 0. Freezes refill to
  // [_monthlyFreezes] at the start of each calendar month; extra freezes can be
  // earned (e.g. a review quiz) via [addStreakFreeze]
  // ---------------------------------------------------------------------------

  static const int _monthlyFreezes = 4;

  String _dayKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  String _monthKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}';

  Future<String?> _getSetting(Database db, String key) async {
    final List<Map<String, Object?>> rows = await db.query(
      'settings',
      columns: const <String>['value'],
      where: 'key = ?',
      whereArgs: <Object>[key],
      limit: 1,
    );
    return rows.isEmpty ? null : rows.first['value'] as String?;
  }

  Future<void> _setSetting(Database db, String key, String value) async {
    await db.insert('settings', <String, Object>{
      'key': key,
      'value': value,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _seedStreakIfNeeded(Database db) async {
    if (await _getSetting(db, 'streak_init') == '1') {
      return;
    }
    // Seed from any pre-existing reading history so current users keep their
    // streak when the engine is introduced.
    final int existing = await getCurrentStreak();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      'SELECT MAX(substr(readAt, 1, 10)) AS d FROM readings',
    );
    final Object? lastDay = rows.isEmpty ? null : rows.first['d'];
    final DateTime now = _dateOnly(DateTime.now());
    await _setSetting(db, 'streak_init', '1');
    await _setSetting(db, 'streak_count', existing.toString());
    await _setSetting(db, 'streak_freezes', _monthlyFreezes.toString());
    await _setSetting(db, 'streak_freeze_month', _monthKey(now));
    await _setSetting(db, 'streak_lost', '0');
    if (existing > 0 && lastDay is String) {
      await _setSetting(db, 'streak_chain', lastDay);
    } else {
      await db.delete(
        'settings',
        where: 'key = ?',
        whereArgs: <Object>['streak_chain'],
      );
    }
  }

  Future<void> _reconcileStreak(Database db) async {
    final DateTime today = _dateOnly(DateTime.now());

    // Monthly freeze refill.
    final String month = _monthKey(today);
    if (await _getSetting(db, 'streak_freeze_month') != month) {
      await _setSetting(db, 'streak_freezes', _monthlyFreezes.toString());
      await _setSetting(db, 'streak_freeze_month', month);
    }

    final String? chain = await _getSetting(db, 'streak_chain');
    if (chain == null) {
      return; // No active streak to reconcile.
    }
    final DateTime chainDate = DateTime.parse(chain);
    final int gap = today.difference(chainDate).inDays;
    if (gap <= 1) {
      return; // Active today or yesterday — chain still intact.
    }

    final int missed = gap - 1; // full days with no activity before today
    // Days inside a break are excused without spending a freeze.
    final List<Break> breaks = (await db.query(
      'breaks',
    )).map(_breakFromRow).toList();
    final List<String> freezeCovered = <String>[];
    for (int i = 1; i <= missed; i++) {
      // not +24h: across a DST change that can land on the wrong day
      final String key = _dayKey(
        DateTime(chainDate.year, chainDate.month, chainDate.day + i),
      );
      if (!isDayInBreaks(breaks, key)) {
        freezeCovered.add(key);
      }
    }
    int freezes =
        int.tryParse(await _getSetting(db, 'streak_freezes') ?? '0') ?? 0;
    if (freezes >= freezeCovered.length) {
      freezes -= freezeCovered.length;
      await _setSetting(db, 'streak_freezes', freezes.toString());
      // Chain is now protected through yesterday.
      await _setSetting(db, 'streak_chain', _dayKey(yesterdayOf(today)));
      // Log each covered day so the calendar can show it as "frozen".
      for (final String key in freezeCovered) {
        await db.insert('frozen_days', <String, Object>{
          'day': key,
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
      }
    } else {
      await _setSetting(db, 'streak_count', '0');
      await _setSetting(db, 'streak_lost', '1');
      await db.delete(
        'settings',
        where: 'key = ?',
        whereArgs: <Object>['streak_chain'],
      );
    }
  }

  Future<void> _recordStreakActivity(Database db) async {
    await _seedStreakIfNeeded(db);
    await _reconcileStreak(db);

    final DateTime today = _dateOnly(DateTime.now());
    final String? chain = await _getSetting(db, 'streak_chain');
    final int current =
        int.tryParse(await _getSetting(db, 'streak_count') ?? '0') ?? 0;

    final int? count = nextStreakCount(
      chainKey: chain,
      today: today,
      currentCount: current,
    );
    if (count == null) {
      return; // Nothing to record — see nextStreakCount.
    }

    await _setSetting(db, 'streak_count', count.toString());
    await _setSetting(db, 'streak_chain', _dayKey(today));
    await _setSetting(db, 'streak_lost', '0');
  }

  Break _breakFromRow(Map<String, Object?> row) => Break(
    id: row['id'] as int,
    tier: BreakTier.values.byName(row['tier'] as String),
    startDay: row['startDay'] as String,
    endDay: row['endDay'] as String,
    reason: row['reason'] as String? ?? '',
  );

  Future<List<Break>> getAllBreaks() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'breaks',
      orderBy: 'startDay DESC',
    );
    return rows.map(_breakFromRow).toList(growable: false);
  }

  Future<Break?> getActiveBreak() async {
    final Database db = await _getDb();
    final String today = _dayKey(_dateOnly(DateTime.now()));
    final List<Map<String, Object?>> rows = await db.query(
      'breaks',
      where: 'endDay >= ?',
      whereArgs: <Object>[today],
      orderBy: 'endDay DESC',
      limit: 1,
    );
    return rows.isEmpty ? null : _breakFromRow(rows.first);
  }

  /// How many times [tier] was used in the current calendar year.
  Future<int> breakUsageThisYear(BreakTier tier) async {
    final Database db = await _getDb();
    final String year = DateTime.now().year.toString();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      'SELECT COUNT(*) AS c FROM breaks WHERE tier = ? AND substr(startDay, 1, 4) = ?',
      <Object>[tier.name, year],
    );
    return (rows.first['c'] as int?) ?? 0;
  }

  /// Testing affordance: `flutter run --dart-define=DISABLE_BREAK_LIMITS=true`
  /// lifts the yearly caps and the cooldown so breaks can be exercised
  /// repeatedly without wiping data. Absent in normal, test and release
  /// builds — behavior there is untouched.
  static const bool _breakLimitsDisabled = bool.fromEnvironment(
    'DISABLE_BREAK_LIMITS',
  );

  /// Earliest day a new break may start (null = today), applying the
  /// cooldown after the latest break.
  Future<DateTime?> nextBreakAllowedDay() async {
    if (_breakLimitsDisabled) {
      return null;
    }
    return nextBreakAllowedOn(await getAllBreaks(), DateTime.now());
  }

  Future<bool> canStartBreak(BreakTier tier) async {
    if (await getActiveBreak() != null) {
      return false;
    }
    if (await nextBreakAllowedDay() != null) {
      return false;
    }
    return _breakLimitsDisabled ||
        (await breakUsageThisYear(tier)) < tier.yearlyCap;
  }

  /// Starts a [tier] break today, covering today..today+duration-1.
  /// [reason] is the reader's optional free-text note about why.
  Future<void> startBreak(BreakTier tier, {String reason = ''}) async {
    final Database db = await _getDb();
    final DateTime today = _dateOnly(DateTime.now());
    await db.insert('breaks', <String, Object>{
      'tier': tier.name,
      'startDay': _dayKey(today),
      'endDay': _dayKey(
        DateTime(today.year, today.month, today.day + tier.durationDays - 1),
      ),
      'reason': reason.trim(),
    });
  }

  /// Ends the active break early. Past days stay excused; the row is kept (with endDay moved back)
  Future<void> cancelActiveBreak() async {
    final Database db = await _getDb();
    final Break? active = await getActiveBreak();
    if (active == null) {
      return;
    }
    await db.update(
      'breaks',
      <String, Object>{'endDay': _dayKey(yesterdayOf(DateTime.now()))},
      where: 'id = ?',
      whereArgs: <Object>[active.id],
    );
  }

  /// Calendar days (yyyy-MM-dd) covered by a streak freeze rather than by
  /// real activity — used to render them distinctly on the mini calendar.
  Future<Set<String>> getFrozenDays() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query('frozen_days');
    return rows.map((Map<String, Object?> r) => r['day'] as String).toSet();
  }

  Future<StreakState> getStreakState() async {
    final Database db = await _getDb();
    await _seedStreakIfNeeded(db);
    await _reconcileStreak(db);
    final int count =
        int.tryParse(await _getSetting(db, 'streak_count') ?? '0') ?? 0;
    final int freezes =
        int.tryParse(await _getSetting(db, 'streak_freezes') ?? '0') ?? 0;
    final String? chain = await _getSetting(db, 'streak_chain');
    final bool activeToday = chain == _dayKey(_dateOnly(DateTime.now()));
    final bool justLost = await _getSetting(db, 'streak_lost') == '1';
    return StreakState(
      count: count,
      freezes: freezes,
      activeToday: activeToday,
      justLost: justLost,
    );
  }

  /// Adds a freeze (e.g. earned from a review quiz).
  Future<void> addStreakFreeze() async {
    final Database db = await _getDb();
    await _seedStreakIfNeeded(db);
    final int freezes =
        int.tryParse(await _getSetting(db, 'streak_freezes') ?? '0') ?? 0;
    await _setSetting(db, 'streak_freezes', (freezes + 1).toString());
  }

  /// Clears the "just lost" flag once the gentle message has been shown.
  Future<void> acknowledgeStreakLoss() async {
    final Database db = await _getDb();
    await _setSetting(db, 'streak_lost', '0');
  }

  Future<int> getNotesCount() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM notes',
    );
    return (result.first['total'] as int?) ?? 0;
  }

  /// Ids of achievements permanently unlocked so far (see [syncAchievements]).
  Future<Set<String>> getUnlockedAchievementIds() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'achievements',
      columns: const <String>['id'],
    );
    return rows.map((Map<String, Object?> r) => r['id'] as String).toSet();
  }

  /// How many achievements were unlocked the last time the achievements
  /// screen was actually opened — compared against the current unlocked
  /// count, this is what decides whether the trophy icon gets a "new" dot.
  /// A count rather than the id set: simpler, and the badge only needs to
  /// know "is there something to see," not which ones.
  Future<void> saveAchievementsSeenCount(int count) async {
    final Database db = await _getDb();
    await _setSetting(db, 'achievements_seen_count', '$count');
  }

  Future<int> getAchievementsSeenCount() async {
    final Database db = await _getDb();
    final String? value = await _getSetting(db, 'achievements_seen_count');
    return int.tryParse(value ?? '') ?? 0;
  }

  /// Records that the user found the given secret (see [kEasterEggIds]).
  /// Idempotent — retriggering an already-found egg is a no-op.
  Future<void> markEasterEggFound(String id) async {
    final Database db = await _getDb();
    await db.insert('easter_eggs', <String, Object>{
      'id': id,
      'foundAt': DateTime.now().toIso8601String(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<Set<String>> getFoundEasterEggIds() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'easter_eggs',
      columns: const <String>['id'],
    );
    return rows.map((Map<String, Object?> r) => r['id'] as String).toSet();
  }

  /// Gathers the stats [AchievementDef]s are evaluated against.
  /// Every parameter is optional: pass in whatever a caller already fetched
  /// moments ago (e.g. HomeScreen's own dashboard refresh reads readKeys,
  /// starsByBook, streakState and reminders anyway) to skip re-querying it
  /// here — this used to always re-read all five from scratch even when the
  /// caller had them sitting in a local variable one line above.
  Future<AchievementStats> getAchievementStats({
    Set<String>? readKeys,
    Map<String, QuizResult>? quizResults,
    Map<String, int>? starsByBook,
    StreakState? streakState,
    List<Reminder>? reminders,
  }) async {
    // Whatever wasn't handed in gets fetched here, all concurrently instead
    // of one round-trip at a time — Future.value wraps an already-known
    // value so it lines up with the rest of the list without an extra query.
    final List<dynamic> fetched = await Future.wait<dynamic>(<Future<dynamic>>[
      readKeys != null
          ? Future<Set<String>>.value(readKeys)
          : getReadChapterKeys(),
      quizResults != null
          ? Future<Map<String, QuizResult>>.value(quizResults)
          : getAllQuizResults(),
      starsByBook != null
          ? Future<Map<String, int>>.value(starsByBook)
          : getEarnedStarsByBook(),
      streakState != null
          ? Future<StreakState>.value(streakState)
          : getStreakState(),
      reminders != null
          ? Future<List<Reminder>>.value(reminders)
          : getReminders(),
      getNotesCount(),
      getFoundEasterEggIds(),
    ]);
    final Set<String> resolvedReadKeys = fetched[0] as Set<String>;
    final Map<String, QuizResult> resolvedQuizResults =
        fetched[1] as Map<String, QuizResult>;
    final Map<String, int> resolvedStarsByBook = fetched[2] as Map<String, int>;
    final StreakState resolvedStreakState = fetched[3] as StreakState;
    final List<Reminder> resolvedReminders = fetched[4] as List<Reminder>;
    final int notesCount = fetched[5] as int;
    final Set<String> foundEggs = fetched[6] as Set<String>;

    final Set<String> booksRead = resolvedReadKeys
        .map((String key) => key.split('|').first)
        .toSet();
    final BibleBook? genesis = bibleBookById('Genesis');
    final bool genesisComplete =
        genesis != null &&
        List<int>.generate(genesis.chapters, (int i) => i + 1).every(
          (int chapter) =>
              resolvedReadKeys.contains(bibleChapterKey('Genesis', chapter)),
        );

    return AchievementStats(
      chaptersRead: resolvedReadKeys.length,
      distinctBooksRead: booksRead.length,
      genesisComplete: genesisComplete,
      wholeBibleComplete: resolvedReadKeys.length >= kTotalBibleChapters,
      completedQuizzes: resolvedQuizResults.length,
      hasPerfectQuiz: resolvedQuizResults.values.any(
        (QuizResult r) => r.isPerfect,
      ),
      totalStars: resolvedStarsByBook.values.fold<int>(
        0,
        (int a, int b) => a + b,
      ),
      currentStreak: resolvedStreakState.count,
      notesCount: notesCount,
      hasReminder: resolvedReminders.isNotEmpty,
      easterEggsFound: foundEggs.intersection(kEasterEggIds.toSet()).length,
    );
  }

  /// Persists any newly-met achievement so it stays unlocked even if the
  /// underlying stat later regresses (e.g. the streak resets). Returns the
  /// full set of unlocked ids, including ones just unlocked. Pass [stats] if
  /// the caller already computed it (see [getAchievementStats]) to avoid
  /// computing it a second time right after.
  Future<Set<String>> syncAchievements({AchievementStats? stats}) async {
    final Database db = await _getDb();
    final AchievementStats resolvedStats = stats ?? await getAchievementStats();
    final Set<String> unlocked = await getUnlockedAchievementIds();
    for (final AchievementDef def in kAchievementDefs) {
      if (!unlocked.contains(def.id) && def.isMet(resolvedStats)) {
        await db.insert('achievements', <String, Object>{
          'id': def.id,
          'unlockedAt': DateTime.now().toIso8601String(),
        }, conflictAlgorithm: ConflictAlgorithm.ignore);
        unlocked.add(def.id);
      }
    }
    return unlocked;
  }

  DateTime _dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }
}
