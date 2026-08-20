import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/quiz/quiz_data.dart';
import 'package:jwstreak/quiz/quiz_data_de.dart';
import 'package:jwstreak/quiz/quiz_data_en.dart';
import 'package:jwstreak/quiz/quiz_data_es.dart';
import 'package:jwstreak/quiz/quiz_data_it.dart';
import 'package:jwstreak/quiz/quiz_data_pl.dart';
import 'package:jwstreak/quiz/quiz_data_pt.dart';
import 'package:jwstreak/quiz/quiz_data_ru.dart';
import 'package:jwstreak/quiz/quiz_data_zh.dart';

const Map<String, Set<String>> _classifierTraps = <String, Set<String>>{
  'nilo': _river,
  'nil': _river,
  'nile': _river,
  'nilu': _river,
  'giordano': _river,
  'jourdain': _river,
  'jordan': _river,
  'jordanie': _river,
  'jordán': _river,
  'jordão': _river,
  'jordanu': _river,
  'eufrate': _river,
  'euphrate': _river,
  'euphrates': _river,
  'éufrates': _river,
  'sinai': _mount,
  'sinaï': _mount,
  'synaj': _mount,
  'oreb': _mount,
  'horeb': _mount,
  'carmelo': _mount,
  'carmel': _mount,
  'ararat': _mount,
  'nebo': _mount,
  'moria': _mount,
  'gerusalemme': _city,
  'jérusalem': _city,
  'jerusalem': _city,
  'jerusalén': _city,
  'jerusalém': _city,
  'jerozolima': _city,
  'babilonia': _city,
  'babylone': _city,
  'babylon': _city,
  'babilônia': _city,
  'ninive': _city,
  'nineveh': _city,
  'nínive': _city,
};

const Set<String> _river = <String>{
  'fiume',
  'fleuve',
  'river',
  'río',
  'rio',
  'fluss',
  'rzeka',
  'rzece',
};
const Set<String> _mount = <String>{
  'monte',
  'mont',
  'mount',
  'mountain',
  'berg',
  'góra',
  'górze',
  'montagne',
  'montaña',
  'montanha',
  'montagna',
};
const Set<String> _city = <String>{
  'città',
  'ville',
  'city',
  'ciudad',
  'cidade',
  'stadt',
  'miasto',
  'miescie',
};

Iterable<QuizQuestion> _allQuestions() sync* {
  final List<Map<String, List<QuizQuestion>>> sets =
      <Map<String, List<QuizQuestion>>>[
        authoredQuizzesEn,
        extraQuizzesEn,
        authoredQuizzesDe,
        extraQuizzesDe,
        authoredQuizzesEs,
        extraQuizzesEs,
        authoredQuizzesIt,
        extraQuizzesIt,
        authoredQuizzesPl,
        extraQuizzesPl,
        authoredQuizzesPt,
        extraQuizzesPt,
        authoredQuizzesRu,
        extraQuizzesRu,
        authoredQuizzesZh,
        extraQuizzesZh,
      ];
  for (final Map<String, List<QuizQuestion>> set in sets) {
    for (final List<QuizQuestion> questions in set.values) {
      yield* questions;
    }
  }
}

void main() {
  late List<QuizQuestion> wordBanks;

  setUpAll(() {
    wordBanks = _allQuestions()
        .where((QuizQuestion q) => q.type == QuizAnswerType.wordBank)
        .toList(growable: false);
  });

  test('there are word-bank questions to check at all', () {
    // Guards the guards: if the accessors ever change shape, the assertions
    // below would pass vacuously on an empty list
    expect(wordBanks.length, greaterThan(100));
  });

  test('no decoy chip is a word the correct answer already uses', () {
    // A chip that belongs in the answer is not a decoy, it is a duplicate
    // the reader taps it, it lands in the right place, and they are marked
    // wrong for using the word the answer asked for.
    final List<String> offenders = <String>[];
    for (final QuizQuestion q in wordBanks) {
      final Set<String> answer = q.options[q.correctIndex]
          .toLowerCase()
          .split(RegExp(r'[^\wàâäéèêëîïôöùûüçñãõáíóúşğ]+'))
          .where((String w) => w.isNotEmpty)
          .toSet();
      for (final String chip in q.wordBankDistractors) {
        if (answer.contains(chip.toLowerCase())) {
          offenders.add('"$chip" in "${q.options[q.correctIndex]}"');
        }
      }
    }
    expect(offenders, isEmpty);
  });

  test('no decoy chip is the classifier the answer is begging for', () {
    // The Italian Moses question shipped with "fiume" as a decoy while the
    // answer ended "sul Nilo". Anyone writing natural Italian taps
    // "sul fiume Nilo" and is told they are wrong — the decoy punishes
    // fluency rather than testing knowledge.
    final List<String> offenders = <String>[];
    for (final QuizQuestion q in wordBanks) {
      final String answer = q.options[q.correctIndex];
      final Set<String> names = answer
          .split(RegExp(r'[^\w\u00C0-\u017F]+'))
          .map((String w) => w.toLowerCase())
          .toSet();
      for (final String chip in q.wordBankDistractors) {
        final String low = chip.toLowerCase();
        for (final String name in names) {
          if (_classifierTraps[name]?.contains(low) ?? false) {
            offenders.add('"$chip" offered against "$answer"');
          }
        }
      }
    }
    expect(offenders, isEmpty);
  });
}
