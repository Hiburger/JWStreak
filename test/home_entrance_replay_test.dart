import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

Finder _statValues() => find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.style?.fontSize == 40,
);

/// The lowest opacity among the entrance-driven FadeTransitions above the
/// first stat value. 1.0 means the entrance animation is over (or never
/// restarted); anything below means the tiles are replaying it.
double _statEntranceOpacity(WidgetTester tester) {
  final Iterable<FadeTransition> fades = tester.widgetList<FadeTransition>(
    find.ancestor(
      of: _statValues().first,
      matching: find.byType(FadeTransition),
    ),
  );
  double lowest = 1;
  for (final FadeTransition fade in fades) {
    if (fade.opacity.value < lowest) {
      lowest = fade.opacity.value;
    }
  }
  return lowest;
}

/// The home screen's lifecycle observer, driving it the way the OS would.
WidgetsBindingObserver homeObserver(WidgetTester tester) =>
    tester.state<State<HomeScreen>>(find.byType(HomeScreen))
        as WidgetsBindingObserver;

void main() {
  useTestDatabase();

  testWidgets('an overlay blip does not replay the tile entrance', (
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
    // First entrance finishes before anything else happens, and the lazy
    // home list has to have built the stats section before it can be
    // measured.
    await tester.pump(const Duration(seconds: 2));
    await tester.scrollUntilVisible(find.text('day streak'), 200);
    await tester.pump();
    expect(_statEntranceOpacity(tester), 1.0);

    final WidgetsBindingObserver home = homeObserver(tester);
    // Pulling the notification shade / Control Center: focus lost and
    // handed straight back, the app never left the screen.
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();

    expect(
      _statEntranceOpacity(tester),
      1.0,
      reason: 'an overlay opening and closing is not a page change',
    );
  });

  testWidgets('coming back from a real backgrounding still replays it', (
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
    await tester.pump(const Duration(seconds: 2));
    await tester.scrollUntilVisible(find.text('day streak'), 200);
    await tester.pump();
    expect(_statEntranceOpacity(tester), 1.0);

    final WidgetsBindingObserver home = homeObserver(tester);
    // Away to another app (or home, or the lock screen) and back: the
    // app passes through `hidden`, and the welcome-back replay is wanted.
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.hidden);
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();

    expect(
      _statEntranceOpacity(tester),
      lessThan(1.0),
      reason: 'returning from a real backgrounding must replay the entrance',
    );

    // And the replay finishes, back to a resting screen.
    await tester.pump(const Duration(seconds: 2));
    expect(_statEntranceOpacity(tester), 1.0);
  });
}
