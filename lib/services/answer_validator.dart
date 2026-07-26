/// Decides whether a typed answer counts as correct.
///
/// Deliberately an interface: the shipped [FuzzyAnswerValidator] is pure
/// string work (no assets, no latency, fully deterministic), but a smarter
/// implementation — e.g. a small multilingual embedding model scoring
/// semantic similarity — can be swapped in later without touching the quiz
/// screen.
abstract class AnswerValidator {
  const AnswerValidator();

  /// Whether [input] matches any of [acceptedAnswers].
  bool matches(String input, List<String> acceptedAnswers);
}

/// Forgiving string matcher: ignores case, accents, punctuation and spacing
/// differences, and tolerates a small number of typos proportional to the
/// answer's length.
///
/// Quiz results feed the streak/stars economy, so this errs on the side of
/// accepting: a wrongly-rejected correct answer is far more discouraging
/// than an occasional generous match.
class FuzzyAnswerValidator extends AnswerValidator {
  const FuzzyAnswerValidator();

  @override
  bool matches(String input, List<String> acceptedAnswers) {
    final String normalizedInput = normalize(input);
    if (normalizedInput.isEmpty) {
      return false;
    }
    for (final String accepted in acceptedAnswers) {
      final String normalizedAccepted = normalize(accepted);
      if (normalizedAccepted.isEmpty) {
        continue;
      }
      if (normalizedInput == normalizedAccepted) {
        return true;
      }
      if (_levenshtein(normalizedInput, normalizedAccepted) <=
          _typoToleranceFor(normalizedAccepted)) {
        return true;
      }
    }
    return false;
  }

  /// Case-folds, strips diacritics and punctuation, and collapses spacing so
  /// "Adam et Ève !" , "adam et eve" and "ADAM ET EVE" all compare equal.
  ///
  /// CJK text has no case or diacritics and is written without spaces, so
  /// removing whitespace here also makes Chinese input robust to stray
  /// spaces an IME may insert.
  static String normalize(String value) {
    final StringBuffer buffer = StringBuffer();
    for (final int rune in value.toLowerCase().runes) {
      final String char = String.fromCharCode(rune);
      final String? folded = _diacriticFolding[char];
      if (folded != null) {
        buffer.write(folded);
        continue;
      }
      if (_isLetterOrDigit(rune)) {
        buffer.write(char);
      }
      // Everything else (punctuation, spaces, quotes) is dropped.
    }
    return buffer.toString();
  }

  /// Typo budget: none for very short answers (where a single edit usually
  /// means a genuinely different word — "Cain"/"Caleb"), one for normal
  /// words, two for long phrases.
  static int _typoToleranceFor(String accepted) {
    if (accepted.length <= 4) {
      return 0;
    }
    if (accepted.length <= 12) {
      return 1;
    }
    return 2;
  }

  static bool _isLetterOrDigit(int rune) {
    // Latin/ASCII fast path.
    if ((rune >= 0x30 && rune <= 0x39) || (rune >= 0x61 && rune <= 0x7A)) {
      return true;
    }
    if (rune < 0x80) {
      return false; // ASCII punctuation/space.
    }
    // Beyond ASCII, keep letters of every script (Latin-1 accents, Greek,
    // Cyrillic, CJK, ...) and drop the general-punctuation blocks.
    const int generalPunctuationStart = 0x2000;
    const int generalPunctuationEnd = 0x206F;
    const int cjkPunctuationStart = 0x3000;
    const int cjkPunctuationEnd = 0x303F;
    const int fullwidthFormsStart = 0xFF00;
    const int fullwidthFormsEnd = 0xFF65;
    if (rune >= generalPunctuationStart && rune <= generalPunctuationEnd) {
      return false;
    }
    if (rune >= cjkPunctuationStart && rune <= cjkPunctuationEnd) {
      return false;
    }
    if (rune >= fullwidthFormsStart && rune <= fullwidthFormsEnd) {
      return false;
    }
    return true;
  }

  /// Standard Levenshtein edit distance, two-row variant.
  static int _levenshtein(String a, String b) {
    if (a == b) {
      return 0;
    }
    if (a.isEmpty) {
      return b.length;
    }
    if (b.isEmpty) {
      return a.length;
    }

    final List<int> aRunes = a.runes.toList(growable: false);
    final List<int> bRunes = b.runes.toList(growable: false);

    List<int> previous = List<int>.generate(bRunes.length + 1, (int i) => i);
    List<int> current = List<int>.filled(bRunes.length + 1, 0);

    for (int i = 0; i < aRunes.length; i++) {
      current[0] = i + 1;
      for (int j = 0; j < bRunes.length; j++) {
        final int cost = aRunes[i] == bRunes[j] ? 0 : 1;
        final int deletion = previous[j + 1] + 1;
        final int insertion = current[j] + 1;
        final int substitution = previous[j] + cost;
        current[j + 1] = deletion < insertion
            ? (deletion < substitution ? deletion : substitution)
            : (insertion < substitution ? insertion : substitution);
      }
      final List<int> swap = previous;
      previous = current;
      current = swap;
    }
    return previous[bRunes.length];
  }

  /// Diacritic folding for the Latin-script languages the app ships
  /// (fr/en/de/pl/es/it/pt), so "Ève" == "eve" and "Noé" == "noe". Cyrillic
  /// and CJK need no folding.
  static const Map<String, String> _diacriticFolding = <String, String>{
    'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a', 'ą': 'a',
    'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e', 'ę': 'e',
    'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
    'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o',
    'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
    'ý': 'y', 'ÿ': 'y',
    'ñ': 'n', 'ń': 'n', 'ç': 'c', 'ć': 'c',
    'æ': 'ae', 'œ': 'oe', 'ß': 'ss',
    // Polish-specific letters.
    'ł': 'l', 'ś': 's', 'ź': 'z', 'ż': 'z',
    // Cyrillic ё is often typed as е.
    'ё': 'е',
  };
}
