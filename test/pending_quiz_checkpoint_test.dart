import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/quiz/quiz_data.dart';

/// The book the home screen quiz banner should never fall back to in these
/// tests: `Genesis#0` (chapters 1-7) is always unlocked-and-untaken here on
/// purpose, so a passing test that reaches for it anyway is a real regression
/// of the "always shows Genesis 1-7" bug this function replaced.
final BibleBook _genesis = kBibleBooks.firstWhere(
  (BibleBook b) => b.id == 'Genesis',
);
final BibleBook _joshua = kBibleBooks.firstWhere(
  (BibleBook b) => b.id == 'Joshua',
);

void main() {
  test('no current book (the whole Bible is finished) suggests nothing', () {
    expect(
      pendingQuizCheckpointFor(
        currentBook: null,
        coveredKeys: <String>{},
        completedQuizIds: <String>{},
      ),
      isNull,
    );
  });

  test('a book with nothing read yet has no unlocked quiz to suggest', () {
    expect(
      pendingQuizCheckpointFor(
        currentBook: _joshua,
        coveredKeys: <String>{},
        completedQuizIds: <String>{},
      ),
      isNull,
    );
  });

  test('the current book’s own unlocked quiz is suggested, not an unrelated '
      'book’s — this is the bug report: Genesis 1-7 kept appearing for '
      'readers who had moved on', () {
    final Set<String> covered = <String>{
      for (int c = 1; c <= 50; c++) bibleChapterKey('Genesis', c),
      for (int c = 1; c <= 8; c++) bibleChapterKey('Joshua', c),
    };

    final Checkpoint? suggested = pendingQuizCheckpointFor(
      currentBook: _joshua,
      coveredKeys: covered,
      completedQuizIds: <String>{},
    );

    expect(suggested, isNotNull);
    expect(suggested!.bookId, 'Joshua');
    expect(suggested.id, isNot(contains('Genesis')));
  });

  test('reading only part of a book’s next segment suggests nothing — it '
      'does not fall back to an already-unlocked quiz elsewhere', () {
    final Set<String> covered = <String>{
      for (int c = 1; c <= 50; c++) bibleChapterKey('Genesis', c),
      for (int c = 1; c <= 4; c++) bibleChapterKey('Joshua', c),
    };

    expect(
      pendingQuizCheckpointFor(
        currentBook: _joshua,
        coveredKeys: covered,
        completedQuizIds: <String>{},
      ),
      isNull,
    );
  });

  test('the second checkpoint unlocks only once the first quiz is taken', () {
    final Set<String> covered = <String>{
      for (int c = 1; c <= 16; c++) bibleChapterKey('Joshua', c),
    };

    expect(
      pendingQuizCheckpointFor(
        currentBook: _joshua,
        coveredKeys: covered,
        completedQuizIds: <String>{},
      )!.id,
      'Joshua#0',
    );

    expect(
      pendingQuizCheckpointFor(
        currentBook: _joshua,
        coveredKeys: covered,
        completedQuizIds: <String>{'Joshua#0'},
      )!.id,
      'Joshua#1',
    );
  });

  test('every checkpoint in the current book taken suggests nothing, even '
      'though Genesis 1-7 remains untaken', () {
    final Set<String> covered = <String>{
      for (int c = 1; c <= 50; c++) bibleChapterKey('Genesis', c),
      for (int c = 1; c <= 24; c++) bibleChapterKey('Joshua', c),
    };

    expect(
      pendingQuizCheckpointFor(
        currentBook: _joshua,
        coveredKeys: covered,
        completedQuizIds: <String>{'Joshua#0', 'Joshua#1', 'Joshua#2'},
      ),
      isNull,
    );
  });

  test('Genesis itself still offers its own first quiz when current', () {
    final Set<String> covered = <String>{
      for (int c = 1; c <= 7; c++) bibleChapterKey('Genesis', c),
    };

    expect(
      pendingQuizCheckpointFor(
        currentBook: _genesis,
        coveredKeys: covered,
        completedQuizIds: <String>{},
      )!.id,
      'Genesis#0',
    );
  });
}
