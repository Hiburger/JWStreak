import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/answer_validator.dart';

void main() {
  const FuzzyAnswerValidator validator = FuzzyAnswerValidator();

  group('accepts', () {
    test('exact match', () {
      expect(validator.matches('Cain', <String>['Cain']), isTrue);
    });

    test('case differences', () {
      expect(validator.matches('CAIN', <String>['Cain']), isTrue);
      expect(validator.matches('cain', <String>['Cain']), isTrue);
    });

    test('accents (French/Spanish/Portuguese)', () {
      expect(validator.matches('eve', <String>['Ève']), isTrue);
      expect(validator.matches('Noe', <String>['Noé']), isTrue);
      expect(validator.matches('Adan', <String>['Adán']), isTrue);
      expect(validator.matches('Genesis', <String>['Gênesis']), isTrue);
    });

    test('surrounding punctuation and spacing', () {
      expect(
        validator.matches('  Adam et Eve ! ', <String>['Adam et Ève']),
        isTrue,
      );
      expect(validator.matches('adameteve', <String>['Adam et Ève']), isTrue);
    });

    test('a typo in a medium-length answer', () {
      expect(validator.matches('Abrahm', <String>['Abraham']), isTrue);
    });

    test('two typos in a long phrase', () {
      expect(
        validator.matches('la tour de babl', <String>['la tour de Babel']),
        isTrue,
      );
    });

    test('an alias from the accepted list', () {
      expect(
        validator.matches('Каина', <String>['Каин', 'Каина', 'Каину']),
        isTrue,
      );
    });

    test('Chinese with stray IME spacing', () {
      expect(validator.matches(' 该隐 ', <String>['该隐']), isTrue);
    });

    test('Chinese fullwidth punctuation', () {
      expect(validator.matches('该隐。', <String>['该隐']), isTrue);
    });

    test('a leading article the question did not ask for', () {
      expect(validator.matches('Una colomba', <String>['colomba']), isTrue);
      expect(validator.matches('La colomba', <String>['colomba']), isTrue);
      expect(validator.matches('the dove', <String>['dove']), isTrue);
      expect(validator.matches('el arca', <String>['arca']), isTrue);
    });

    test('an answer phrased as a sentence around the expected words', () {
      expect(
        validator.matches('interpretò i sogni', <String>['i sogni']),
        isTrue,
      );
      expect(
        validator.matches('he interpreted the dreams', <String>['dreams']),
        isTrue,
      );
    });

    test('extra words plus a typo still counts', () {
      expect(validator.matches('una colmba', <String>['colomba']), isTrue);
    });

    test('a name without the word introducing it', () {
      expect(validator.matches('Sinaï', <String>['Au mont Sinaï']), isTrue);
      expect(validator.matches('Séba', <String>['La reine de Séba']), isTrue);
      expect(validator.matches('Juda', <String>['la tribu de Juda']), isTrue);
      expect(
        validator.matches('Elijah', <String>['the prophet Elijah']),
        isTrue,
      );
    });

    test('Cyrillic ё typed as е', () {
      expect(validator.matches('Ноев', <String>['Ноёв']), isTrue);
    });
  });

  group('rejects', () {
    test('empty input', () {
      expect(validator.matches('', <String>['Cain']), isFalse);
      expect(validator.matches('   ', <String>['Cain']), isFalse);
    });

    test('a genuinely different short name', () {
      // Short answers get no typo budget, so near-miss names stay distinct.
      expect(validator.matches('Caleb', <String>['Cain']), isFalse);
      expect(validator.matches('Seth', <String>['Cain']), isFalse);
    });

    test('a different answer entirely', () {
      expect(validator.matches('Moise', <String>['Abraham']), isFalse);
    });

    test('a partial answer that drops an expected word', () {
      // Leniency runs one way only: extra words are forgiven, missing ones
      // are not, or "Adam" would pass for "Adam and Eve" !
      expect(validator.matches('Adam', <String>['Adam et Ève']), isFalse);
      expect(
        validator.matches('la tour', <String>['la tour de Babel']),
        isFalse,
      );
    });

    test('a wall of text that happens to contain the answer', () {
      expect(
        validator.matches(
          'honestly I have no idea but maybe it was the dove or something',
          <String>['dove'],
        ),
        isFalse,
      );
    });

    test('filler words alone are not an answer', () {
      expect(validator.matches('la', <String>['la colomba']), isFalse);
      expect(validator.matches('the of and', <String>['the dove']), isFalse);
    });

    test('the introducing word on its own', () {
      expect(
        validator.matches('la reine', <String>['La reine de Séba']),
        isFalse,
      );
      expect(validator.matches('le mont', <String>['Au mont Sinaï']), isFalse);
    });

    test('a different name after the same introducing word', () {
      expect(
        validator.matches('mont Nébo', <String>['Au mont Sinaï']),
        isFalse,
      );
    });

    test('an answer that really is just a title still needs saying', () {
      expect(validator.matches('Salomon', <String>['le roi']), isFalse);
    });

    test('too many typos', () {
      expect(validator.matches('Abrhm', <String>['Abraham']), isFalse);
    });
  });

  group('normalize', () {
    test('folds accents and strips punctuation', () {
      expect(FuzzyAnswerValidator.normalize('Adam et Ève !'), 'adameteve');
    });

    test('leaves Cyrillic and CJK letters intact', () {
      expect(FuzzyAnswerValidator.normalize('Каин'), 'каин');
      expect(FuzzyAnswerValidator.normalize('该隐'), '该隐');
    });
  });

  group('word-bank answers get no latitude for extra words', () {
    test('selecting the answer plus a distractor is wrong', () {
      expect(
        validator.matches('Adam et Ève Caïn', <String>[
          'Adam et Ève',
        ], allowExtraWords: false),
        isFalse,
      );
    });

    test('the exact answer still passes', () {
      expect(
        validator.matches('Adam et Ève', <String>[
          'Adam et Ève',
        ], allowExtraWords: false),
        isTrue,
      );
    });

    test('typed answers keep their latitude', () {
      expect(validator.matches('Una colomba', <String>['colomba']), isTrue);
    });
  });
}
