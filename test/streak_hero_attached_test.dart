import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  Future<void> pumpHome(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(skipBootstrap: true),
      ),
    );
    await tester.pump();
  }

  /// The hero: the gradient container highest on the screen.
  Rect heroRect(WidgetTester tester) {
    final Iterable<Rect> rects = tester
        .widgetList<Container>(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).gradient != null,
          ),
        )
        .map(
          (Container container) => tester.getRect(
            find.byWidgetPredicate((Widget w) => identical(w, container)).first,
          ),
        );
    double minTop = double.infinity;
    Rect hero = Rect.zero;
    for (final Rect rect in rects) {
      if (rect.top < minTop) {
        minTop = rect.top;
        hero = rect;
      }
    }
    return hero;
  }

  testWidgets('the streak banner takes over the app bar area', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
    final Rect hero = heroRect(tester);
    final Rect appBar = tester.getRect(find.byType(AppBar).first);

    expect(hero.left, 0, reason: 'the banner must touch the left screen edge');
    expect(
      hero.right,
      800,
      reason: 'the banner must touch the right screen edge',
    );
    expect(
      hero.top,
      0,
      reason: 'the banner must paint from the very top of the screen',
    );
    expect(
      hero.bottom,
      greaterThan(appBar.bottom),
      reason: 'the banner must still show below the app bar it sits behind',
    );
    expect(
      tester.widget<AppBar>(find.byType(AppBar).first).backgroundColor,
      Colors.transparent,
      reason: 'the app bar must be transparent so the banner shows through',
    );

    final Container heroContainer = tester
        .widgetList<Container>(
          find.byWidgetPredicate(
            (Widget widget) =>
                widget is Container &&
                widget.decoration is BoxDecoration &&
                (widget.decoration as BoxDecoration).gradient != null,
          ),
        )
        .firstWhere(
          (Container container) =>
              tester
                  .getRect(
                    find
                        .byWidgetPredicate(
                          (Widget w) => identical(w, container),
                        )
                        .first,
                  )
                  .top ==
              hero.top,
        );
    expect(
      (heroContainer.decoration as BoxDecoration).borderRadius,
      const BorderRadius.vertical(bottom: Radius.circular(28)),
      reason:
          'square top corners where the banner attaches, rounded bottom '
          'corners where it meets the content below',
    );
  });

  testWidgets('scrolling hands the app bar its surface back', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
    expect(
      tester.widget<AppBar>(find.byType(AppBar).first).backgroundColor,
      Colors.transparent,
    );

    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(
      tester.widget<AppBar>(find.byType(AppBar).first).backgroundColor,
      isNot(Colors.transparent),
      reason:
          'scrolled content must slide under an opaque app bar, not show '
          'through a transparent one',
    );
  });

  testWidgets('the sections below keep their screen gutter', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
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
