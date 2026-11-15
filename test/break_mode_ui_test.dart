import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/streak_detail_screen.dart';
import 'package:jwstreak/services/local_db_service.dart';
import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  Future<void> pumpUntil(
    WidgetTester tester,
    Finder finder, {
    int frames = 40,
  }) async {
    for (int i = 0; i < frames; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 25)),
      );
      await tester.pump(const Duration(milliseconds: 50));
      if (finder.evaluate().isNotEmpty) {
        return;
      }
    }
    fail('widget never appeared');
  }

  testWidgets('break sheet lists tiers with yearly counts and a reason field', (
    WidgetTester tester,
  ) async {
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(800, 2400);
    addTearDown(tester.view.reset);

    final LocalDbService db = LocalDbService();
    await tester.runAsync(() async {
      await db.markChapterRead(book: 'Genesis', chapter: 1);
    });
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: StreakDetailScreen(
          dbService: db,
          streak: 1,
          freezes: 4,
          recentReadingDays: const <DateTime>[],
          frozenDays: const <String>{},
        ),
      ),
    );
    await pumpUntil(tester, find.text('Take a break'));
    await tester.scrollUntilVisible(find.text('Take a break'), 200);
    await tester.tap(find.text('Take a break'));
    await pumpUntil(tester, find.textContaining('Mini'));

    // All four tiers with their durations and remaining yearly uses
    expect(find.textContaining('Mini (1 day)'), findsOneWidget);
    expect(find.textContaining('Small (3 days)'), findsOneWidget);
    expect(find.textContaining('Medium (7 days)'), findsOneWidget);
    expect(find.textContaining('Big (14 days)'), findsOneWidget);
    expect(find.textContaining('12 left this year'), findsOneWidget);
    expect(find.textContaining('1 left this year'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'exams');
    await tester.pump();
    expect(find.text('5/80'), findsOneWidget);
  });
}
