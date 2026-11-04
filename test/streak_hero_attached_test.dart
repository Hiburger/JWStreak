import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  testWidgets('the streak hero is attached to the top, edge to edge', (
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

    // The hero is the gradient banner closest to the top of the screen.
    final List<Container> gradientContainers = tester
        .widgetList<Container>(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).gradient != null,
          ),
        )
        .toList();
    expect(gradientContainers, isNotEmpty);
    final Iterable<Rect> rects = gradientContainers.map(
      (Container container) => tester.getRect(
        find.byWidgetPredicate((Widget w) => identical(w, container)).first,
      ),
    );
    int heroIndex = 0;
    for (int i = 1; i < rects.length; i++) {
      if (rects.elementAt(i).top < rects.elementAt(heroIndex).top) {
        heroIndex = i;
      }
    }
    final Rect hero = rects.elementAt(heroIndex);

    expect(hero.left, 0, reason: 'the banner must touch the left screen edge');
    expect(
      hero.right,
      800,
      reason: 'the banner must touch the right screen edge',
    );
    expect(
      hero.top,
      tester.getRect(find.byType(AppBar).first).bottom,
      reason: 'the banner must sit flush against the app bar, no gap',
    );

    final BoxDecoration decoration =
        gradientContainers[heroIndex].decoration! as BoxDecoration;
    expect(
      decoration.borderRadius,
      const BorderRadius.vertical(bottom: Radius.circular(28)),
      reason:
          'square top corners where the banner attaches, rounded bottom '
          'corners where it meets the content below',
    );
  });

  testWidgets('the sections below keep their screen gutter', (
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
    await tester.scrollUntilVisible(find.text('Quick actions'), 200);
    await tester.pump();

    final Rect sectionTitle = tester.getRect(find.text('Quick actions'));
    expect(
      sectionTitle.left,
      greaterThanOrEqualTo(16),
      reason: 'sections below the hero must keep their 16px gutter',
    );
  });
}
