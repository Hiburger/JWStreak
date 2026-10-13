import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/streak_lost_screen.dart';

void main() {
  testWidgets('shows the title, the message without its emoji, and pops', (
    WidgetTester tester,
  ) async {
    bool popped = false;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Center(
            child: Builder(
              builder: (BuildContext context) => FilledButton(
                onPressed: () async {
                  await pushStreakLostScreen(context);
                  popped = true;
                },
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('open'));
    // The ring and button glow repeat forever, so pump past the finite
    // entrance instead of settling.
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Your streak is lost'), findsOneWidget);
    final String message = tester
        .widget<Text>(find.textContaining('Your streak reset to zero'))
        .data!;
    expect(
      message,
      isNot(contains('💪')),
      reason: 'the emoji was dropped from the streak-lost message',
    );

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();
    expect(popped, isTrue);
    expect(find.text('Your streak is lost'), findsNothing);
  });
}
