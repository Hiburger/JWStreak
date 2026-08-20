import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Han, Hiragana, Katakana and Hangul — the scripts that should only ever
/// appear in the Chinese translations.
final RegExp _cjk = RegExp(r'[぀-ヿ㐀-䶿一-鿿가-힯]');
final RegExp _cyrillic = RegExp(r'[Ѐ-ӿ]');

void main() {
  final List<File> arbFiles =
      Directory('lib/l10n')
          .listSync()
          .whereType<File>()
          .where((File f) => f.path.endsWith('.arb'))
          .toList()
        ..sort((File a, File b) => a.path.compareTo(b.path));

  test('every language file is present', () {
    expect(arbFiles, hasLength(9));
  });

  for (final File file in arbFiles) {
    final String name = file.uri.pathSegments.last;
    final String lang = name.substring(4, name.length - 4);

    test('$name uses only the scripts it should', () {
      final Map<String, dynamic> entries =
          jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

      entries.forEach((String key, dynamic value) {
        // Keys starting with @ are translator metadata, not shown to anyone.
        if (key.startsWith('@') || value is! String) {
          return;
        }
        if (lang != 'zh') {
          expect(
            _cjk.hasMatch(value),
            isFalse,
            reason: 'CJK/Hangul character in $name → $key: "$value"',
          );
        }
        if (lang != 'ru') {
          expect(
            _cyrillic.hasMatch(value),
            isFalse,
            reason: 'Cyrillic character in $name → $key: "$value"',
          );
        }
      });
    });
  }
}
