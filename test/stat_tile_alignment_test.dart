import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

/// The colored banner at the top of a stat tile — the first colored Container
/// above the label text.
Finder _bannerOf(String labelText) => find.ancestor(
  of: find.text(labelText),
  matching: find.byWidgetPredicate(
    (Widget widget) => widget is Container && widget.color != null,
  ),
);

/// The three stat values ("10", "52", …) — the only 40px texts on the screen.
Finder _statValues() => find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.style?.fontSize == 40,
);

void main() {
  useTestDatabase();

  testWidgets('a two-line stat label keeps every tile section aligned', (
    WidgetTester tester,
  ) async {
    // Sized so the Italian streak label ("giorni di serie") needs two
    // lines while its single-word siblings fit on one — the exact
    // condition that used to grow one tile's banner taller than the other
    // two and stagger the gradient and value below it. (Widths here are
    // tuned for the test font, where every glyph is as wide as it is tall.)
    await tester.binding.setSurfaceSize(const Size(460, 720));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('it'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(skipBootstrap: true),
      ),
    );
    await tester.pump();
    // Let the tile entrance finish: its Slide/Fade transitions move paint,
    // and the test measures layout.
    await tester.pump(const Duration(seconds: 2));
    await tester.scrollUntilVisible(find.text('giorni di serie'), 200);
    await tester.pump();

    final Rect streakLabel = tester.getRect(find.text('giorni di serie'));
    final Rect readingsLabel = tester.getRect(find.text('letture'));
    // Premise: the streak label is the long one of the three — it still
    // occupies more width than its sibling even after scaling down.
    expect(streakLabel.width, greaterThan(readingsLabel.width));
    // A label too wide for its banner must shrink to a single line, not
    // wrap: a wrapped label would render taller than its one-line sibling
    // and stagger the sections below it.
    expect(
      streakLabel.height,
      lessThanOrEqualTo(readingsLabel.height * 1.05),
      reason: 'the long label must shrink, never wrap',
    );

    final Rect streakBanner = tester.getRect(_bannerOf('giorni di serie'));
    final Rect readingsBanner = tester.getRect(_bannerOf('letture'));
    final Rect starsBanner = tester.getRect(_bannerOf('stelle'));
    expect(
      streakBanner.height,
      readingsBanner.height,
      reason: 'banners must be equally tall in every tile',
    );
    expect(starsBanner.height, readingsBanner.height);

    final Finder values = _statValues();
    final List<double> valueTops = <double>[
      for (int i = 0; i < values.evaluate().length; i++)
        tester.getRect(values.at(i)).top,
    ];
    expect(valueTops.length, 3);
    expect(
      valueTops.toSet().length,
      1,
      reason: 'the three big numbers must start at the same height',
    );
  });
}
