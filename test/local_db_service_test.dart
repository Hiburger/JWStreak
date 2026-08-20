import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/local_db_service.dart';

import 'support/db_test_harness.dart';

/// First tests to touch the persistence layer at all. They pin the behaviour
/// backup and restore will depend on: that data written through the service
/// comes back unchanged, and that the streak's own bookkeeping survives a
/// round trip through the database.
void main() {
  useTestDatabase();

  test('a fresh database starts empty', () async {
    final LocalDbService db = LocalDbService();
    expect(await db.getAllNotes(), isEmpty);
    expect(await db.getReadChapterKeys(), isEmpty);
    expect(await db.getNotesCount(), 0);
  });

  test('a note survives a write and read unchanged', () async {
    final LocalDbService db = LocalDbService();
    final int id = await db.createNote(
      title: 'Ma note',
      book: 'Genesis',
      chapter: 3,
      content: 'ligne un\nligne deux',
    );

    final NoteEntry? note = await db.getNoteById(id);
    expect(note, isNotNull);
    expect(note!.title, 'Ma note');
    expect(note.book, 'Genesis');
    expect(note.chapter, 3);
    // The line break matters: it is the thing the reader fix was about, and
    // a backup that silently normalised it would lose the note's shape.
    expect(note.content, 'ligne un\nligne deux');
  });

  test('re-pointing a note at another chapter is persisted', () async {
    final LocalDbService db = LocalDbService();
    final int id = await db.createNote(
      title: 'Note',
      book: 'Genesis',
      chapter: 1,
      content: 'texte',
    );

    await db.updateNote(
      id: id,
      title: 'Note',
      content: 'texte',
      book: 'Exodus',
      chapter: 12,
    );

    final NoteEntry note = (await db.getNoteById(id))!;
    expect(note.book, 'Exodus');
    expect(note.chapter, 12);
  });

  test('updating only the text leaves the chapter link alone', () async {
    final LocalDbService db = LocalDbService();
    final int id = await db.createNote(
      title: 'Note',
      book: 'Ruth',
      chapter: 2,
      content: 'avant',
    );

    await db.updateNote(id: id, title: 'Note', content: 'après');

    final NoteEntry note = (await db.getNoteById(id))!;
    expect(note.content, 'après');
    expect(note.book, 'Ruth');
    expect(note.chapter, 2);
  });

  test('marking a chapter read records it and starts a streak', () async {
    final LocalDbService db = LocalDbService();
    await db.markChapterRead(book: 'Genesis', chapter: 1);

    expect(await db.getReadChapterKeys(), contains('Genesis|1'));
    expect((await db.getStreakState()).count, 1);
  });

  test('a quiz-only day counts as an active day', () async {
    // The bug this pins: the streak calendar read only the readings table,
    // so a day spent on quizzes built a streak that the calendar showed as
    // blank. Both kinds of activity have to appear here.
    final LocalDbService db = LocalDbService();
    await db.saveQuizResult(quizId: 'Genesis#0', score: 3, total: 3);

    expect(await db.getRecentReadingDays(), hasLength(1));
    expect((await db.getStreakState()).count, 1);
  });

  test('reading and quizzing on the same day is one active day', () async {
    final LocalDbService db = LocalDbService();
    await db.markChapterRead(book: 'Genesis', chapter: 1);
    await db.saveQuizResult(quizId: 'Genesis#0', score: 3, total: 3);

    expect(await db.getRecentReadingDays(), hasLength(1));
    expect((await db.getStreakState()).count, 1);
  });

  test('replaying a quiz updates the score without awarding twice', () async {
    final LocalDbService db = LocalDbService();
    final bool first = await db.saveQuizResult(
      quizId: 'Genesis#0',
      score: 1,
      total: 3,
    );
    final bool replay = await db.saveQuizResult(
      quizId: 'Genesis#0',
      score: 3,
      total: 3,
    );

    expect(replay, isFalse, reason: 'a replay must never award a freeze');
    expect(first, isA<bool>());
    expect((await db.getCompletedQuizIds()), <String>{'Genesis#0'});
    expect((await db.getQuizResult('Genesis#0'))!.score, 3);
  });

  test('settings round-trip through the database', () async {
    final LocalDbService db = LocalDbService();
    await db.saveAppLocale('pl');
    await db.setGuidedTourDone();

    expect(await db.getAppLocale(), 'pl');
    expect(await db.isGuidedTourDone(), isTrue);
  });

  test('the cached connection can be dropped and reopened', () async {
    // Restoring a backup will have to close, replace and reopen the database
    // underneath a running app, so this has to hold.
    final LocalDbService db = LocalDbService();
    await db.createNote(
      title: 'Persistée',
      book: 'Genesis',
      chapter: 1,
      content: 'texte',
    );

    await db.resetForTesting();

    expect(await db.getNotesCount(), 1);
  });
}
