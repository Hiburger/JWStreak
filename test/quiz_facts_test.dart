import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/quiz/quiz_data.dart';
import 'package:jwstreak/quiz/quiz_facts.dart';

/// The authored fact files, French source first.
const List<String> _factFiles = <String>[
  'lib/quiz/quiz_facts.dart',
  'lib/quiz/quiz_facts_en.dart',
  'lib/quiz/quiz_facts_de.dart',
  'lib/quiz/quiz_facts_es.dart',
  'lib/quiz/quiz_facts_it.dart',
  'lib/quiz/quiz_facts_pl.dart',
  'lib/quiz/quiz_facts_pt.dart',
  'lib/quiz/quiz_facts_ru.dart',
  'lib/quiz/quiz_facts_zh.dart',
];

/// Every "God Almighty" form across the app's languages. Ruled out for this
/// app's content, so it's worth failing the build over rather than trusting
/// a reviewer to spot one in a file of hundreds of authored strings.
const List<String> _bannedPhrases = <String>[
  'tout-puissant',
  'tout puissant',
  'almighty',
  'allmächtig',
  'todopoderoso',
  'todo-poderoso',
  'onnipotente',
  'wszechmocny',
  'wszechmogący',
  'всемогущ',
  '全能者',
];

/// Books with a single chapter, whose references carry a verse number only.
const List<String> _singleChapterBooks = <String>[
  'Obadiah',
  'Philemon',
  '2 John',
  '3 John',
  'Jude',
];

void main() {
  test('no fact uses an "Almighty" form', () {
    for (final String path in _factFiles) {
      final String contents = File(path).readAsStringSync().toLowerCase();
      for (final String banned in _bannedPhrases) {
        expect(
          contents.contains(banned),
          isFalse,
          reason: '$path contains the banned phrase "$banned"',
        );
      }
    }
  });

  test('no Latin-script words leak into the Russian facts', () {
    // Same hazard as the CJK check, in the other direction: authoring nine
    // languages at once makes it easy for a Latin-script word to land inside
    // a Cyrillic sentence, where it is invisible unless you read Russian.
    // Map keys ("Genesis#0") are Latin by design, so only the quoted values
    // are examined.
    final String source = File(
      'lib/quiz/quiz_facts_ru.dart',
    ).readAsStringSync();
    final RegExp value = RegExp(r"^\s{6}'(.*)',$", multiLine: true);
    for (final RegExpMatch m in value.allMatches(source)) {
      expect(
        RegExp(r'[A-Za-zÀ-ÿ]').hasMatch(m.group(1)!),
        isFalse,
        reason: 'Latin script inside a Russian fact: "${m.group(1)}"',
      );
    }
  });

  test('no CJK characters leak into a non-Chinese fact file', () {
    // Authoring nine languages in one pass makes it easy for a character to
    // land in the wrong file, where it is invisible to anyone who does not
    // read that script.
    final RegExp cjk = RegExp(r'[一-鿿　-〿]');
    for (final String path in _factFiles) {
      if (path.endsWith('_zh.dart')) {
        continue;
      }
      expect(
        cjk.hasMatch(File(path).readAsStringSync()),
        isFalse,
        reason: '$path contains CJK characters',
      );
    }
  });

  test('every authored fact cites a verse', () {
    // A fact with no reference can't be checked by the reader, which is the
    // whole bar this content is held to.
    for (final String language in <String>[
      'fr',
      'en',
      'de',
      'es',
      'it',
      'pl',
      'pt',
      'ru',
      'zh',
    ]) {
      // Every checkpoint that actually has a quiz, derived from the book list
      // rather than pinned to a copy of it: authoring a new quiz now fails
      // this test until its fact is written too. Single-chapter books still
      // generate three checkpoints, but only the first one carries questions,
      // so the empty ones are skipped rather than demanding a fact.
      for (final String id
          in kBibleBooks
              .expand(checkpointsForBook)
              .where((Checkpoint cp) => cp.questions.isNotEmpty)
              .map((Checkpoint cp) => cp.id)) {
        final String? fact = checkpointFactFor(id, languageCode: language);
        expect(fact, isNotNull, reason: '$id missing for $language');
        // Single-chapter books are referenced by verse alone ("Obadiah 21"),
        // so there is no chapter:verse pair to look for.
        final bool singleChapter = _singleChapterBooks.any(id.startsWith);
        // Chinese closes the reference with a full-width bracket and marks
        // the verse with 节, so both forms have to be accepted.
        final RegExp reference = singleChapter
            ? RegExp(r'\d+\s*节?\s*[)）]')
            : RegExp(r'\d+:\d+');
        expect(
          reference.hasMatch(fact!),
          isTrue,
          reason: '$id ($language) cites no verse: $fact',
        );
      }
    }
  });

  test('no fact points past the chapters its checkpoint covers', () {
    // A fact is shown right after the quiz, so citing a later chapter spoils
    // reading the reader has not done yet. Checked on the French source,
    // where every translation takes its chapter numbers from.
    for (final Checkpoint cp in kBibleBooks.expand(checkpointsForBook)) {
      if (cp.questions.isEmpty) {
        continue;
      }
      final String fact = checkpointFactFor(cp.id, languageCode: 'fr')!;
      for (final RegExpMatch m in RegExp(
        r'\(([^()]*?[A-Za-zÀ-ÿ])\s(\d+):\d+',
      ).allMatches(fact)) {
        expect(
          int.parse(m.group(2)!),
          lessThanOrEqualTo(cp.afterChapter),
          reason:
              '${cp.id} covers through chapter ${cp.afterChapter} '
              'but its fact cites ${m.group(1)} ${m.group(2)}: $fact',
        );
      }
    }
  });

  test('an unauthored checkpoint has no fact rather than a placeholder', () {
    expect(checkpointFactFor('Revelation#7', languageCode: 'fr'), isNull);
  });

  test('an untranslated fact falls back to French, never to nothing', () {
    // 'ja' has no fact file at all, so every id must still resolve.
    expect(checkpointFactFor('Genesis#0', languageCode: 'ja'), isNotNull);
    expect(
      checkpointFactFor('Genesis#0', languageCode: 'ja'),
      checkpointFactFor('Genesis#0', languageCode: 'fr'),
    );
  });

  test('a random fact is drawn only from the ids it was given', () {
    // The whole-book and review quizzes pass only checkpoints the reader has
    // already covered; drawing outside that set would spoil unread passages.
    const List<String> ids = <String>['Genesis#0', 'Genesis#1'];
    final Set<String> allowed = <String>{
      for (final String id in ids) checkpointFactFor(id, languageCode: 'fr')!,
    };
    for (int seed = 0; seed < 25; seed++) {
      final String? drawn = randomCheckpointFact(
        ids,
        languageCode: 'fr',
        random: Random(seed),
      );
      expect(allowed, contains(drawn));
    }
  });

  test('a random fact is null when none of the ids has one', () {
    expect(
      randomCheckpointFact(<String>['Nowhere#9'], languageCode: 'fr'),
      isNull,
    );
    expect(randomCheckpointFact(<String>[], languageCode: 'fr'), isNull);
  });

  test('every quiz entry point can produce a fact', () {
    // Whole-book quiz: any book's own checkpoints must yield one.
    for (final BibleBook book in kBibleBooks) {
      expect(
        randomCheckpointFact(
          checkpointsForBook(book).map((Checkpoint cp) => cp.id),
          languageCode: 'fr',
        ),
        isNotNull,
        reason: 'full-book quiz for ${book.id} would show no fact',
      );
    }
  });
}
