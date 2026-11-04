import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  testWidgets('the flashcard quick action announces itself, inertly', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(skipBootstrap: true),
      ),
    );
    await tester.pump();
    await tester.scrollUntilVisible(find.text('Flashcards'), 300);
    await tester.pump();

    expect(find.text('Flashcards'), findsOneWidget);
    expect(find.text('Train your memory'), findsOneWidget);
    expect(find.text('Soon'), findsOneWidget);

    // Not a button: no tap handler, unlike its neighbours.
    final Finder tileInkWell = find.ancestor(
      of: find.text('Flashcards'),
      matching: find.byType(InkWell),
    );
    expect(tester.widget<InkWell>(tileInkWell).onTap, isNull);

    final Finder notesInkWell = find.ancestor(
      of: find.text('My notes'),
      matching: find.byType(InkWell),
    );
    expect(
      tester.widget<InkWell>(notesInkWell).onTap,
      isNotNull,
      reason: 'the neighbouring actions must stay tappable',
    );

    // Tapping it changes nothing: the home screen is still what's on top.
    await tester.tap(find.text('Flashcards'));
    await tester.pump();
    expect(find.text('Flashcards'), findsOneWidget);
    expect(find.text('Soon'), findsOneWidget);
  });
}
