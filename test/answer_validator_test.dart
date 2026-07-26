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
      expect(validator.matches('  Adam et Eve ! ', <String>['Adam et Ève']), isTrue);
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
}
