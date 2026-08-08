import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../achievements_data.dart';
import '../app_constants.dart';
import '../bible_data.dart';
import '../l10n/app_localizations.dart';
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
  });

  final int id;
  final String title;
  final String book;
  final int chapter;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;

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

  Future<Database> _openDatabase() async {
    final String dbPath = join(await getDatabasesPath(), _databaseName);
    final Database db = await openDatabase(
      dbPath,
      version: 7,
      onCreate: (Database database, int version) async {
        await database.execute('''
          CREATE TABLE readings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            book TEXT NOT NULL,
            chapter INTEGER NOT NULL,
            readAt TEXT NOT NULL
          )
        ''');

        await database.execute(_createNotesTableSql);
        await database.execute(_createQuizResultsTableSql);
        await database.execute(_createReflectionsTableSql);
        await database.execute(_createRemindersTableSql);
        await database.execute(_createFrozenDaysTableSql);
        await database.execute(_createAchievementsTableSql);
        await database.execute(_createEasterEggsTableSql);

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

  /// Latest reading time across every book/chapter (null if none yet).
  Future<DateTime?> getLastReadingAt() async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'readings',
      columns: const <String>['readAt'],
      orderBy: 'readAt DESC',
      limit: 1,
    );
    if (rows.isEmpty) {
      return null;
    }
    final Object? raw = rows.first['readAt'];
    return raw is String ? DateTime.parse(raw) : null;
  }

  Future<DateTime?> getLastReadAt({
    required String book,
    required int chapter,
  }) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.query(
      'readings',
      columns: const ['readAt'],
      where: 'book = ? AND chapter = ?',
      whereArgs: <Object>[book, chapter],
      orderBy: 'readAt DESC',
      limit: 1,
    );

    if (rows.isEmpty) {
      return null;
    }

    final Object? raw = rows.first['readAt'];
    if (raw is! String) {
      throw const FormatException('Invalid readAt value in local database.');
    }
    return DateTime.parse(raw);
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

  Future<List<DateTime>> getRecentReadingDays({int limit = 14}) async {
    final Database db = await _getDb();
    final List<Map<String, Object?>> rows = await db.rawQuery(
      '''
      SELECT DISTINCT substr(readAt, 1, 10) AS readingDay
      FROM readings
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
    return db.insert('notes', <String, Object>{
      'title': title,
      'book': book,
      'chapter': chapter,
      'content': content,
      'createdAt': now,
      'updatedAt': now,
    });
  }

  Future<void> updateNote({
    required int id,
    required String title,
    required String content,
  }) async {
    final Database db = await _getDb();
    await db.update(
      'notes',
      <String, Object>{
        'title': title,
        'content': content,
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

  Future<List<NoteEntry>> getAllNotes({String query = ''}) async {
    final Database db = await _getDb();
    final String normalized = query.trim();
    final List<Map<String, Object?>> rows = await db.query(
      'notes',
      where: normalized.isEmpty
          ? null
          : '(title LIKE ? OR book LIKE ? OR content LIKE ? OR CAST(chapter AS TEXT) LIKE ?)',
      whereArgs: normalized.isEmpty
          ? null
          : <Object>[
              '%$normalized%',
              '%$normalized%',
              '%$normalized%',
              '%$normalized%',
            ],
      orderBy: 'updatedAt DESC',
    );

    return rows.map(_noteFromRow).toList(growable: false);
  }

  NoteEntry _noteFromRow(Map<String, Object?> row) {
    final Object? id = row['id'];
    final Object? title = row['title'];
    final Object? book = row['book'];
    final Object? chapter = row['chapter'];
    final Object? content = row['content'];
    final Object? createdAt = row['createdAt'];
    final Object? updatedAt = row['updatedAt'];
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
    int freezes =
        int.tryParse(await _getSetting(db, 'streak_freezes') ?? '0') ?? 0;
    if (freezes >= missed) {
      freezes -= missed;
      await _setSetting(db, 'streak_freezes', freezes.toString());
      // Chain is now protected through yesterday.
      await _setSetting(
        db,
        'streak_chain',
        _dayKey(today.subtract(const Duration(days: 1))),
      );
      // Log each covered day so the calendar can show it as "frozen".
      for (int i = 1; i <= missed; i++) {
        final String key = _dayKey(chainDate.add(Duration(days: i)));
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
    final String todayKey = _dayKey(today);
    final String? chain = await _getSetting(db, 'streak_chain');
    if (chain == todayKey) {
      return; // Already counted today.
    }

    int count = int.tryParse(await _getSetting(db, 'streak_count') ?? '0') ?? 0;
    if (chain != null && today.difference(DateTime.parse(chain)).inDays == 1) {
      count += 1;
    } else {
      count = 1;
    }
    await _setSetting(db, 'streak_count', count.toString());
    await _setSetting(db, 'streak_chain', todayKey);
    await _setSetting(db, 'streak_lost', '0');
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
