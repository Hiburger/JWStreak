import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/quiz_data.dart';
import 'package:jwstreak/services/answer_validator.dart';

void main() {
  const FuzzyAnswerValidator validator = FuzzyAnswerValidator();
  final BibleBook genesis = kBibleBooks.firstWhere((b) => b.id == 'Genesis');

  List<QuizQuestion> genesis0(String lang) => checkpointsForBook(
    genesis,
    languageCode: lang,
  ).firstWhere((Checkpoint c) => c.id == 'Genesis#0').questions;

  /// Languages that use the richer answer types. Russian and Chinese stay
  /// multiple-choice on purpose: typed answers there mean Cyrillic case
  /// inflections and CJK input, which are hostile to type and to validate.
  const List<String> typedLanguages = <String>[
    'fr',
    'en',
    'de',
    'pl',
    'es',
    'it',
    'pt',
  ];
  const List<String> choiceOnlyLanguages = <String>['ru', 'zh'];

  test('typed languages expose the new question types', () {
    for (final String lang in typedLanguages) {
      final List<QuizQuestion> qs = genesis0(lang);
      final Iterable<QuizQuestion> typed =
          qs.where((QuizQuestion q) => q.type == QuizAnswerType.freeText);
      final Iterable<QuizQuestion> banked =
          qs.where((QuizQuestion q) => q.type == QuizAnswerType.wordBank);
      expect(typed, isNotEmpty, reason: '$lang has no freeText question');
      expect(banked, isNotEmpty, reason: '$lang has no wordBank question');

      // Every typed answer must be non-empty, else it can never be answered.
      for (final QuizQuestion q in <QuizQuestion>[...typed, ...banked]) {
        expect(q.correctAnswer, isNotEmpty, reason: '$lang: empty answer');
      }
    }
  });

  test('Russian and Chinese stay multiple-choice everywhere', () {
    // French is the per-checkpoint fallback, so a checkpoint that ru/zh do
    // not override would serve them the French question — including its
    // typed answer type, in French. This guards that leak across every book.
    for (final String lang in choiceOnlyLanguages) {
      for (final BibleBook book in kBibleBooks) {
        for (final Checkpoint cp
            in checkpointsForBook(book, languageCode: lang)) {
          for (final QuizQuestion q in cp.questions) {
            expect(
              q.type,
              QuizAnswerType.multipleChoice,
              reason: '$lang leaked a ${q.type} question at ${cp.id}: '
                  '"${q.text}"',
            );
          }
        }
      }
    }
  });

  /// The "who killed Abel" question, located by its answer rather than by its
  /// position. Matching on order would pin down which *other* questions in the
  /// checkpoint may be converted, which is content authoring's business, not
  /// this test's.
  QuizQuestion abelQuestion(String lang, String answer) => genesis0(lang)
      .firstWhere(
        (QuizQuestion q) =>
            q.type == QuizAnswerType.freeText && q.correctAnswer == answer,
        orElse: () => throw StateError(
          'no freeText question answered "$answer" in $lang Genesis#0',
        ),
      );

  const Map<String, String> abelAnswers = <String, String>{
    'fr': 'Caïn',
    'en': 'Cain',
    'de': 'Kain',
    'pl': 'Kain',
    'es': 'Caín',
    'it': 'Caino',
    'pt': 'Caim',
  };

  test('the canonical answer validates for each language', () {
    abelAnswers.forEach((String lang, String answer) {
      final QuizQuestion q = abelQuestion(lang, answer);
      expect(
        validator.matches(answer, q.allAcceptedAnswers),
        isTrue,
        reason: '$lang: canonical answer rejected',
      );
    });
  });

  test('every freeText answer validates against its own accepted list', () {
    // Guards the whole bank, not just one sample: an authored answer that its
    // own validator rejects would be impossible to get right.
    for (final String lang in typedLanguages) {
      for (final BibleBook book in kBibleBooks) {
        for (final Checkpoint cp
            in checkpointsForBook(book, languageCode: lang)) {
          for (final QuizQuestion q in cp.questions) {
            if (q.type != QuizAnswerType.freeText) {
              continue;
            }
            expect(
              validator.matches(q.correctAnswer, q.allAcceptedAnswers),
              isTrue,
              reason: '$lang ${cp.id}: "${q.correctAnswer}" fails its own check',
            );
          }
        }
      }
    }
  });

  test('accent-free and lowercase typing is accepted', () {
    final QuizQuestion fr = abelQuestion('fr', 'Caïn');
    expect(validator.matches('cain', fr.allAcceptedAnswers), isTrue);
    expect(validator.matches('CAIN', fr.allAcceptedAnswers), isTrue);
  });

  test('a wrong answer is still rejected', () {
    final QuizQuestion en = abelQuestion('en', 'Cain');
    expect(validator.matches('Noah', en.allAcceptedAnswers), isFalse);
    expect(validator.matches('Seth', en.allAcceptedAnswers), isFalse);
  });

  test('word bank chips reassemble into an accepted answer', () {
    const Map<String, List<String>> chips = <String, List<String>>{
      'fr': <String>['Adam', 'et', 'Ève'],
      'en': <String>['Adam', 'and', 'Eve'],
    };
    chips.forEach((String lang, List<String> words) {
      final QuizQuestion q = genesis0(lang)
          .firstWhere((QuizQuestion q) => q.type == QuizAnswerType.wordBank);
      expect(
        validator.matches(words.join(' '), q.allAcceptedAnswers),
        isTrue,
        reason: '$lang: reassembled chips rejected',
      );
    });
  });

  test('every word bank answer is splittable into at least two chips', () {
    // A one-chip bank would hand the user the whole answer.
    for (final String lang in typedLanguages) {
      for (final BibleBook book in kBibleBooks) {
        for (final Checkpoint cp
            in checkpointsForBook(book, languageCode: lang)) {
          for (final QuizQuestion q in cp.questions) {
            if (q.type != QuizAnswerType.wordBank) {
              continue;
            }
            final int chips = q.wordBankSegments.isNotEmpty
                ? q.wordBankSegments.length
                : q.correctAnswer
                      .split(RegExp(r'\s+'))
                      .where((String w) => w.isNotEmpty)
                      .length;
            expect(
              chips,
              greaterThan(1),
              reason: '$lang ${cp.id}: word bank "${q.correctAnswer}" '
                  'yields a single chip',
            );
          }
        }
      }
    }
  });

  test('no word bank distractor duplicates a word from its own answer', () {
    // A distractor equal to one of the answer's own words would put two
    // identical chips in the bank — ambiguous to place, and it also just
    // gives a free correct placement.
    for (final String lang in typedLanguages) {
      for (final BibleBook book in kBibleBooks) {
        for (final Checkpoint cp
            in checkpointsForBook(book, languageCode: lang)) {
          for (final QuizQuestion q in cp.questions) {
            if (q.type != QuizAnswerType.wordBank ||
                q.wordBankDistractors.isEmpty) {
              continue;
            }
            final List<String> answerWords = q.wordBankSegments.isNotEmpty
                ? q.wordBankSegments
                : q.correctAnswer.split(RegExp(r'\s+'));
            final Set<String> normalizedAnswerWords = answerWords
                .map(FuzzyAnswerValidator.normalize)
                .toSet();
            for (final String distractor in q.wordBankDistractors) {
              expect(
                normalizedAnswerWords.contains(
                  FuzzyAnswerValidator.normalize(distractor),
                ),
                isFalse,
                reason: '$lang ${cp.id}: distractor "$distractor" '
                    'duplicates a word in "${q.correctAnswer}"',
              );
            }
          }
        }
      }
    }
  });

  test('untouched questions still default to multiple choice', () {
    final List<QuizQuestion> qs = genesis0('en');
    expect(
      qs.where((QuizQuestion q) => q.type == QuizAnswerType.multipleChoice),
      isNotEmpty,
    );
  });
}
