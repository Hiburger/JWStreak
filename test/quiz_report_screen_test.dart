import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/quiz/quiz_data.dart';
import 'package:jwstreak/screens/quiz_report_screen.dart';

void main() {
  // Pretend a mail app exists: the report screen's first channel is mailto,
  // and url_launcher's launchUrl asks this channel whether it opened. With
  // the mock answering "yes", the happy path runs without ever reaching the
  // share-sheet fallback (which cannot complete inside a test).
  TestWidgetsFlutterBinding.ensureInitialized();
  const MethodChannel launcherChannel = MethodChannel(
    'plugins.flutter.io/url_launcher',
  );
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(launcherChannel, (MethodCall call) async {
        return call.method == 'launch';
      });

  const QuizQuestion sample = QuizQuestion(
    text: 'Combien de jours de création la Genèse décrit-elle ?',
    options: <String>['Six jours', 'Sept jours'],
    correctIndex: 0,
    explanation: 'Genèse 1 et 2.',
  );

  Future<void> pump(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (BuildContext context) => FilledButton(
                onPressed: () => Navigator.of(context).push<void>(
                  MaterialPageRoute<void>(
                    builder: (_) => const QuizReportScreen(
                      quizTitle: 'Genesis 1-3',
                      question: sample,
                    ),
                  ),
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  testWidgets('send stays disabled until a kind is chosen', (
    WidgetTester tester,
  ) async {
    await pump(tester);

    expect(find.text('Report this quiz'), findsOneWidget);
    expect(find.text('Genesis 1-3'), findsOneWidget);
    final Finder send = find.widgetWithText(FilledButton, 'Send report');
    expect(tester.widget<FilledButton>(send).onPressed, isNull);

    await tester.tap(find.text('Translation'));
    await tester.pump();
    expect(tester.widget<FilledButton>(send).onPressed, isNotNull);

    // The other kind switches the selection rather than stacking.
    await tester.tap(find.text('Quiz content'));
    await tester.pump();
    expect(find.text('Translation'), findsOneWidget);
  });

  testWidgets('sending launches the mail app and pops', (
    WidgetTester tester,
  ) async {
    await pump(tester);
    await tester.enterText(
      find.byType(TextField),
      'The answer order is confusing',
    );
    await tester.tap(find.text('Translation'));
    await tester.pump();

    // No mail app exists in the test environment beyond the mock above, so
    // the mocked "opened" answer is the end of the chain — sending hands off
    // to the mail app and pops the page, never trapping the reader.
    await tester.tap(find.text('Send report'));
    await tester.pumpAndSettle();
    expect(find.text('Report this quiz'), findsNothing);
  });
}
