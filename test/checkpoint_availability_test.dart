import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/quiz/quiz_data.dart';

Checkpoint _cp(String id, int afterChapter, {bool hasQuiz = true}) =>
    Checkpoint(
      id: id,
      bookId: 'Genesis',
      index: 0,
      fromChapter: 1,
      afterChapter: afterChapter,
      questions: hasQuiz
          ? const <QuizQuestion>[
              QuizQuestion(
                text: 'x',
                options: <String>['a', 'b'],
                correctIndex: 0,
                explanation: 'x',
              ),
            ]
          : const <QuizQuestion>[],
    );

void main() {
  group('isCheckpointAvailable', () {
    test('locked until its own content is covered', () {
      final Checkpoint cp = _cp('Genesis#0', 10);
      final bool available = isCheckpointAvailable(
        checkpoint: cp,
        checkpointsInBook: <Checkpoint>[cp],
        isChapterCovered: (int c) => c < 10, // chapter 10 itself missing
        isQuizDone: (String id) => false,
      );
      expect(available, isFalse);
    });

    test('the first quiz in a book is available once covered', () {
      final Checkpoint cp = _cp('Genesis#0', 10);
      final bool available = isCheckpointAvailable(
        checkpoint: cp,
        checkpointsInBook: <Checkpoint>[cp],
        isChapterCovered: (int c) => c <= 10,
        isQuizDone: (String id) => false,
      );
      expect(available, isTrue);
    });

    test('a later quiz stays locked until the earlier one is done, even if '
        'its own content is covered', () {
      final Checkpoint first = _cp('Genesis#0', 10);
      final Checkpoint second = _cp('Genesis#1', 20);
      final List<Checkpoint> book = <Checkpoint>[first, second];

      final bool secondAvailable = isCheckpointAvailable(
        checkpoint: second,
        checkpointsInBook: book,
        // Everything through chapter 20 is covered...
        isChapterCovered: (int c) => c <= 20,
        // ...but quiz 1 hasn't been taken.
        isQuizDone: (String id) => false,
      );
      expect(secondAvailable, isFalse, reason: 'quiz 2 should wait for quiz 1');
    });

    test('a later quiz unlocks once the earlier one is done', () {
      final Checkpoint first = _cp('Genesis#0', 10);
      final Checkpoint second = _cp('Genesis#1', 20);
      final List<Checkpoint> book = <Checkpoint>[first, second];

      final bool secondAvailable = isCheckpointAvailable(
        checkpoint: second,
        checkpointsInBook: book,
        isChapterCovered: (int c) => c <= 20,
        isQuizDone: (String id) => id == 'Genesis#0',
      );
      expect(secondAvailable, isTrue);
    });

    test(
      'bulk coverage from onboarding still hands out quizzes one at a time',
      () {
        // Someone declared "I've already read through chapter 30" on day
        // one, with three checkpoints inside that range and nothing done
        // yet. Only the first should be available.
        final Checkpoint c1 = _cp('Genesis#0', 10);
        final Checkpoint c2 = _cp('Genesis#1', 20);
        final Checkpoint c3 = _cp('Genesis#2', 30);
        final List<Checkpoint> book = <Checkpoint>[c1, c2, c3];
        bool covered(int c) => c <= 30;
        bool noneDone(String id) => false;

        expect(
          isCheckpointAvailable(
            checkpoint: c1,
            checkpointsInBook: book,
            isChapterCovered: covered,
            isQuizDone: noneDone,
          ),
          isTrue,
        );
        expect(
          isCheckpointAvailable(
            checkpoint: c2,
            checkpointsInBook: book,
            isChapterCovered: covered,
            isQuizDone: noneDone,
          ),
          isFalse,
        );
        expect(
          isCheckpointAvailable(
            checkpoint: c3,
            checkpointsInBook: book,
            isChapterCovered: covered,
            isQuizDone: noneDone,
          ),
          isFalse,
        );
      },
    );

    test(
      'a reflection-only checkpoint only needs coverage, not quiz order',
      () {
        final Checkpoint quiz = _cp('Genesis#0', 10);
        final Checkpoint reflection = _cp('Genesis#1', 20, hasQuiz: false);
        final List<Checkpoint> book = <Checkpoint>[quiz, reflection];

        final bool available = isCheckpointAvailable(
          checkpoint: reflection,
          checkpointsInBook: book,
          isChapterCovered: (int c) => c <= 20,
          // The earlier quiz hasn't been done, but that shouldn't block a
          // reflection — reflections were never part of the quiz chain.
          isQuizDone: (String id) => false,
        );
        expect(available, isTrue);
      },
    );

    test('earlier reflection-only checkpoints never block a later quiz', () {
      final Checkpoint reflection = _cp('Genesis#0', 10, hasQuiz: false);
      final Checkpoint quiz = _cp('Genesis#1', 20);
      final List<Checkpoint> book = <Checkpoint>[reflection, quiz];

      final bool available = isCheckpointAvailable(
        checkpoint: quiz,
        checkpointsInBook: book,
        isChapterCovered: (int c) => c <= 20,
        isQuizDone: (String id) => false,
      );
      expect(available, isTrue);
    });
  });
}
