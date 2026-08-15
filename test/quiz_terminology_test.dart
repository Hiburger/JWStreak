import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Renderings of "church" across the app's languages. The New World
/// Translation consistently says "congregation" instead, and the church
/// wording carries a sense of Christendom that this app deliberately avoids —
/// so a stray one is worth failing the build over rather than hoping a
/// reviewer spots it among several thousand authored strings.
const Map<String, String> _churchWords = <String, String>{
  'église': 'congrégation',
  'the church': 'the congregation',
  'iglesia': 'congregación',
  'igreja': 'congregação',
  'chiesa': 'congregazione',
  'kirche': 'Versammlung',
  'kościół': 'zbór',
  'церковь': 'собрание',
  '教会': '会众',
};

void main() {
  test('no quiz text says "church" where the NWT says "congregation"', () {
    final List<File> files = Directory('lib/quiz')
        .listSync()
        .whereType<File>()
        .where((File f) => f.path.contains('quiz_data'))
        .toList();
    expect(files, isNotEmpty, reason: 'no quiz data files found');

    final List<String> problems = <String>[];
    for (final File file in files) {
      final List<String> lines = file.readAsLinesSync();
      for (int i = 0; i < lines.length; i++) {
        final String lower = lines[i].toLowerCase();
        for (final MapEntry<String, String> entry in _churchWords.entries) {
          if (lower.contains(entry.key)) {
            problems.add(
              '${file.path}:${i + 1} uses "${entry.key}" — '
              'the NWT says "${entry.value}"',
            );
          }
        }
      }
    }
    expect(problems, isEmpty, reason: problems.join('\n'));
  });
}
