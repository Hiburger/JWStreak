import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jwstreak/main.dart';
import 'package:jwstreak/screens/welcome_screen.dart';

void main() {
  testWidgets('JW Streak dashboard renders core actions', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DailyJwApp(skipBootstrap: true));

    expect(find.text('JW Streak'), findsOneWidget);
    expect(find.text('Marquer Genèse 1 comme lu'), findsOneWidget);
    expect(find.text('Configurer le rappel'), findsOneWidget);
  });

  testWidgets('Welcome screen renders and continues on tap', (
    WidgetTester tester,
  ) async {
    bool continued = false;
    await tester.pumpWidget(
      MaterialApp(
        home: WelcomeScreen(
          onContinue: () async {
            continued = true;
          },
        ),
      ),
    );

    // Let the staggered entrance animations play out.
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Bienvenue !'), findsOneWidget);
    expect(find.text('JW Streak'), findsOneWidget);

    await tester.tap(find.text('Bienvenue !'));
    await tester.pump();

    expect(continued, isTrue);
  });
}
