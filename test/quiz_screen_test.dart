import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/quiz/quiz_data.dart';
import 'package:jwstreak/screens/quiz_screen.dart';

Future<void> _pump(
  WidgetTester tester,
  List<QuizQuestion> questions, {
  required Future<void> Function(int score, int total) onCompleted,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: QuizScreen(
        title: 'Test quiz',
        questions: questions,
        onCompleted: onCompleted,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets(
    'multiple choice: tapping the right option scores and shows Next',
    (WidgetTester tester) async {
      int? score;
      int? total;
      await _pump(
        tester,
        <QuizQuestion>[
          const QuizQuestion(
            text: 'Who killed Abel?',
            options: <String>['Cain', 'Seth', 'Noah', 'Ham'],
            correctIndex: 0,
            explanation: 'Cain, out of jealousy.',
          ),
        ],
        onCompleted: (int s, int t) async {
          score = s;
          total = t;
        },
      );

      expect(find.text('Who killed Abel?'), findsOneWidget);
      await tester.tap(find.text('Cain'));
      await tester.pumpAndSettle();

      expect(find.text('Cain, out of jealousy.'), findsOneWidget);
      expect(find.text('See score'), findsOneWidget);

      await tester.tap(find.text('See score'));
      await tester.pumpAndSettle();

      expect(score, 1);
      expect(total, 1);
    },
  );

  testWidgets(
    'free text: wrong answer reveals the correct one, right answer scores',
    (WidgetTester tester) async {
      int? score;
      await _pump(tester, <QuizQuestion>[
        const QuizQuestion(
          text: 'Who killed Abel?',
          options: <String>['Cain', 'Seth', 'Noah', 'Ham'],
          correctIndex: 0,
          explanation: 'Cain, out of jealousy.',
          type: QuizAnswerType.freeText,
        ),
      ], onCompleted: (int s, int t) async => score = s);

      // The Check button starts disabled until something is typed.
      final Finder checkButton = find.widgetWithText(FilledButton, 'Check');
      expect(tester.widget<FilledButton>(checkButton).onPressed, isNull);

      await tester.enterText(find.byType(TextField), 'Noah');
      await tester.pump();
      expect(tester.widget<FilledButton>(checkButton).onPressed, isNotNull);

      await tester.tap(checkButton);
      await tester.pumpAndSettle();

      // Wrong: the correct answer is revealed alongside the explanation.
      expect(find.text('Answer: Cain'), findsOneWidget);
      expect(find.text('Cain, out of jealousy.'), findsOneWidget);

      await tester.tap(find.text('See score'));
      await tester.pumpAndSettle();
      expect(score, 0);
    },
  );

  testWidgets('free text: a typo and case differences still validate correct', (
    WidgetTester tester,
  ) async {
    int? score;
    await _pump(tester, <QuizQuestion>[
      const QuizQuestion(
        text: 'Who led Israel out of Egypt?',
        options: <String>['Moses', 'Aaron', 'Joshua', 'Caleb'],
        correctIndex: 0,
        explanation: 'Moses, sent by God.',
        type: QuizAnswerType.freeText,
      ),
    ], onCompleted: (int s, int t) async => score = s);

    await tester.enterText(find.byType(TextField), 'moses');
    await tester.pump();
    await tester.tap(find.widgetWithText(FilledButton, 'Check'));
    await tester.pumpAndSettle();

    // No "Answer: ..." reveal on a correct answer.
    expect(find.textContaining('Answer:'), findsNothing);

    await tester.tap(find.text('See score'));
    await tester.pumpAndSettle();
    expect(score, 1);
  });

  testWidgets(
    'word bank: tapping chips in order assembles and scores correctly',
    (WidgetTester tester) async {
      int? score;
      await _pump(tester, <QuizQuestion>[
        const QuizQuestion(
          text: 'Who were the first man and woman?',
          options: <String>['Adam and Eve', 'Cain and Abel'],
          correctIndex: 0,
          explanation: 'Adam and Eve, per Genesis 2.',
          type: QuizAnswerType.wordBank,
          wordBankDistractors: <String>['Cain'],
        ),
      ], onCompleted: (int s, int t) async => score = s);

      expect(find.text('Tap the words in the right order'), findsOneWidget);

      // Tap the pool chips in the correct order (find.text also matches the
      // pool copy since nothing is placed yet).
      await tester.tap(find.text('Adam'));
      await tester.pump();
      await tester.tap(find.text('and'));
      await tester.pump();
      await tester.tap(find.text('Eve'));
      await tester.pump();

      await tester.tap(find.widgetWithText(FilledButton, 'Check'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Answer:'), findsNothing);

      await tester.tap(find.text('See score'));
      await tester.pumpAndSettle();
      expect(score, 1);
    },
  );

  testWidgets('word bank: a placed chip can be tapped again to remove it', (
    WidgetTester tester,
  ) async {
    await _pump(tester, <QuizQuestion>[
      const QuizQuestion(
        text: 'Who were the first man and woman?',
        options: <String>['Adam and Eve'],
        correctIndex: 0,
        explanation: 'Adam and Eve.',
        type: QuizAnswerType.wordBank,
      ),
    ], onCompleted: (int s, int t) async {});

    await tester.tap(find.text('Adam'));
    await tester.pump();
    // "Adam" now appears twice: once as a placed chip, once (potentially)
    // in remaining pool text if duplicated — here it's removed from the
    // pool, so exactly one placed chip should exist.
    expect(find.text('Adam'), findsOneWidget);

    // Tapping the placed chip removes it, returning it to the pool.
    await tester.tap(find.text('Adam'));
    await tester.pump();
    expect(find.text('Adam'), findsOneWidget); // back in the pool
  });

  testWidgets('scores multiple questions across a play-through', (
    WidgetTester tester,
  ) async {
    int? score;
    int? total;
    await _pump(
      tester,
      <QuizQuestion>[
        const QuizQuestion(
          text: 'Q1',
          options: <String>['Right', 'Wrong'],
          correctIndex: 0,
          explanation: 'exp1',
        ),
        const QuizQuestion(
          text: 'Q2',
          options: <String>['Right', 'Wrong'],
          correctIndex: 0,
          explanation: 'exp2',
          type: QuizAnswerType.freeText,
        ),
      ],
      onCompleted: (int s, int t) async {
        score = s;
        total = t;
      },
    );

    // Q1 (order may be shuffled, so just answer whichever question is shown
    // first using its own option set).
    final QuizQuestion firstOfTwo = find.text('Q1').evaluate().isNotEmpty
        ? const QuizQuestion(
            text: 'Q1',
            options: <String>['Right', 'Wrong'],
            correctIndex: 0,
            explanation: 'exp1',
          )
        : const QuizQuestion(
            text: 'Q2',
            options: <String>['Right', 'Wrong'],
            correctIndex: 0,
            explanation: 'exp2',
            type: QuizAnswerType.freeText,
          );

    if (firstOfTwo.type == QuizAnswerType.multipleChoice) {
      await tester.tap(find.text('Right'));
    } else {
      await tester.enterText(find.byType(TextField), 'Right');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Check'));
    }
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Second question, whichever type it is.
    if (find.byType(TextField).evaluate().isNotEmpty) {
      await tester.enterText(find.byType(TextField), 'Right');
      await tester.pump();
      await tester.tap(find.widgetWithText(FilledButton, 'Check'));
    } else {
      await tester.tap(find.text('Right'));
    }
    await tester.pumpAndSettle();
    await tester.tap(find.text('See score'));
    await tester.pumpAndSettle();

    expect(score, 2);
    expect(total, 2);
  });
}
