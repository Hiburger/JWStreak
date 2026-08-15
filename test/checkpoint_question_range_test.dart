import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/quiz/quiz_data.dart';

/// A quiz only unlocks once every chapter up to its checkpoint has been
/// covered, so a question whose explanation points at a *later* chapter asks
/// the reader about something they have not read yet.
void main() {
  test('no checkpoint quiz cites a chapter the reader has not reached', () {
    // "(Jérémie 10:23)" / "(2 Thessaloniciens 2:2)" — a book name, then the
    // chapter. The prefix must end in a letter so that a trailing verse in a
    // list ("Exode 3:14, 15") is not mistaken for a chapter number, while
    // numbered book names like "2 Thessaloniciens" still match.
    final RegExp ref = RegExp(r'\(([^()]*?[A-Za-zÀ-ÿ])\s(\d+)(?::\d+)?\)');
    final List<String> problems = <String>[];

    for (final BibleBook book in kBibleBooks) {
      final List<Checkpoint> checkpoints = checkpointsForBook(book);
      for (final Checkpoint cp in checkpoints) {
        if (!cp.hasQuiz) {
          continue;
        }
        for (final QuizQuestion q in cp.questions) {
          for (final RegExpMatch m in ref.allMatches(q.explanation)) {
            final int? chapter = int.tryParse(m.group(2)!);
            if (chapter == null || chapter > book.chapters) {
              continue;
            }
            if (chapter > cp.afterChapter) {
              problems.add(
                '${cp.id} (read through ch ${cp.afterChapter}) cites '
                'ch $chapter: "${q.explanation}"',
              );
            }
          }
        }
      }
    }

    expect(problems, isEmpty, reason: problems.join('\n'));
  });
}
