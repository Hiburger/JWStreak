import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/reading_plan.dart';

void main() {
  // The orderings are hand-written book lists. A single typo or a book left
  // out would silently make a whole plan unable to finish the Bible, and it
  // would take a user hundreds of chapters to notice — so every plan is
  // checked against the canon rather than eyeballed.
  group('every plan covers the whole Bible exactly once', () {
    for (final ReadingPlan plan in ReadingPlan.values) {
      test(plan.storageValue, () {
        final List<PlanChapter> sequence = chaptersForPlan(plan);

        expect(
          sequence.length,
          kTotalBibleChapters,
          reason: 'wrong number of chapters',
        );

        final Set<String> keys = sequence.map((PlanChapter c) => c.key).toSet();
        expect(
          keys.length,
          sequence.length,
          reason: 'the sequence repeats a chapter',
        );

        final Set<String> expected = <String>{
          for (final BibleBook b in kBibleBooks)
            for (int c = 1; c <= b.chapters; c++) bibleChapterKey(b.id, c),
        };
        expect(keys, expected, reason: 'missing or unknown chapters');
      });
    }
  });

  test('canonical is Genesis 1 through Revelation 22, in print order', () {
    final List<PlanChapter> sequence = chaptersForPlan(ReadingPlan.canonical);
    expect(sequence.first.key, bibleChapterKey('Genesis', 1));
    expect(sequence.last.key, bibleChapterKey('Revelation', 22));
  });

  test('the mixed plan keeps both Scriptures running to the end', () {
    final List<PlanChapter> sequence = chaptersForPlan(
      ReadingPlan.hebrewGreekMix,
    );
    // The point of the plan is that neither half runs dry early, so check
    // the tail — a strict 1:1 alternation would leave this final stretch
    // entirely Hebrew Scriptures.
    final List<PlanChapter> lastHundred = sequence.sublist(
      sequence.length - 100,
    );
    expect(
      lastHundred.any((PlanChapter c) => c.book.oldTestament),
      isTrue,
      reason: 'Hebrew Scriptures exhausted before the end',
    );
    expect(
      lastHundred.any((PlanChapter c) => !c.book.oldTestament),
      isTrue,
      reason: 'Greek Scriptures exhausted before the end',
    );
  });

  test(
    'the thematic plan rotates instead of finishing one theme at a time',
    () {
      final List<PlanChapter> sequence = chaptersForPlan(ReadingPlan.thematic);
      final Set<String> firstTen = sequence
          .take(10)
          .map((PlanChapter c) => c.book.id)
          .toSet();
      expect(
        firstTen.length,
        greaterThan(3),
        reason: 'the opening days should span several themes',
      );
    },
  );

  group('next chapter', () {
    test('is the first unread one in the plan when nothing is read', () {
      final PlanChapter? next = nextChapterInPlan(
        plan: ReadingPlan.canonical,
        readKeys: const <String>{},
      );
      expect(next?.key, bibleChapterKey('Genesis', 1));
    });

    test('starts at the resume point rather than the beginning', () {
      final PlanChapter? next = nextChapterInPlan(
        plan: ReadingPlan.canonical,
        readKeys: const <String>{},
        startKey: bibleChapterKey('Matthew', 1),
      );
      expect(next?.key, bibleChapterKey('Matthew', 1));
    });

    test(
      'wraps around to pick up chapters skipped before the resume point',
      () {
        // Everything from Revelation 22 backwards to the resume point is done,
        // so the only thing left is behind the starting line.
        final List<PlanChapter> sequence = chaptersForPlan(
          ReadingPlan.canonical,
        );
        final int start = sequence.indexWhere(
          (PlanChapter c) => c.key == bibleChapterKey('Matthew', 1),
        );
        final Set<String> read = <String>{
          for (final PlanChapter c in sequence.sublist(start)) c.key,
          for (final PlanChapter c in sequence.sublist(1, start)) c.key,
        };
        final PlanChapter? next = nextChapterInPlan(
          plan: ReadingPlan.canonical,
          readKeys: read,
          startKey: bibleChapterKey('Matthew', 1),
        );
        expect(next?.key, bibleChapterKey('Genesis', 1));
      },
    );

    test('returns null once the whole Bible is read', () {
      final Set<String> everything = <String>{
        for (final PlanChapter c in chaptersForPlan(ReadingPlan.canonical))
          c.key,
      };
      expect(
        nextChapterInPlan(plan: ReadingPlan.thematic, readKeys: everything),
        isNull,
      );
    });

    test('a resume point from another plan is honoured, not ignored', () {
      // Switching plans keeps the stored chapter key; it simply sits at a
      // different index in the new order.
      final PlanChapter? next = nextChapterInPlan(
        plan: ReadingPlan.chronological,
        readKeys: const <String>{},
        startKey: bibleChapterKey('Job', 1),
      );
      expect(next?.key, bibleChapterKey('Job', 1));
    });
  });

  group('chapters before the resume point', () {
    test('is empty when no resume point is set', () {
      expect(chaptersBeforeStart(null), isEmpty);
      expect(chaptersBeforeStart(''), isEmpty);
    });

    test('covers exactly the chapters printed before it', () {
      final Set<String> before = chaptersBeforeStart(
        bibleChapterKey('Exodus', 5),
      );
      // Genesis is 50 chapters, plus Exodus 1-4.
      expect(before.length, 54);
      expect(before, contains(bibleChapterKey('Genesis', 50)));
      expect(before, contains(bibleChapterKey('Exodus', 4)));
      expect(before, isNot(contains(bibleChapterKey('Exodus', 5))));
      expect(before, isNot(contains(bibleChapterKey('Leviticus', 1))));
    });

    test('reads in printed order even under a reordered plan', () {
      // Job sits between Genesis and Exodus chronologically. Someone who
      // says "I stopped at Exodus 5" never claimed to have read it, so it
      // must not be counted as covered just because they picked that order.
      final Set<String> before = chaptersBeforeStart(
        bibleChapterKey('Exodus', 5),
      );
      expect(before, isNot(contains(bibleChapterKey('Job', 1))));
    });

    test('an unknown chapter key claims nothing', () {
      // A stale key must fail closed — claiming the whole Bible as covered
      // would wipe out the progress bar's meaning.
      expect(chaptersBeforeStart('Nonexistent|3'), isEmpty);
    });

    test('the first chapter of the Bible leaves nothing behind it', () {
      expect(chaptersBeforeStart(bibleChapterKey('Genesis', 1)), isEmpty);
    });
  });
}
