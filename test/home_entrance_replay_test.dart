import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/home_screen.dart';

import 'support/db_test_harness.dart';

Finder _statValues() => find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.style?.fontSize == 40,
);

/// The entrance slide of the first stat value: 1.0 means it rests at its
/// place, anything below means the tiles are playing the entrance.
double _statEntranceProgress(WidgetTester tester) {
  final SlideTransition slide = tester.widget<SlideTransition>(
    find
        .ancestor(
          of: _statValues().first,
          matching: find.byType(SlideTransition),
        )
        .first,
  );
  return 1 - slide.position.value.dy;
}

/// The home screen's lifecycle observer, driving it the way the OS would.
WidgetsBindingObserver homeObserver(WidgetTester tester) =>
    tester.state<State<HomeScreen>>(find.byType(HomeScreen))
        as WidgetsBindingObserver;

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
    await tester.pump(const Duration(seconds: 2));
    await tester.scrollUntilVisible(find.text('day streak'), 200);
    await tester.pump();
  }

  testWidgets('an overlay blip does not replay the tile entrance', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
    expect(_statEntranceProgress(tester), 1.0);

    final WidgetsBindingObserver home = homeObserver(tester);
    // Pulling the notification shade / Control Center: focus lost and
    // handed straight back, the app never left the screen.
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();

    expect(
      _statEntranceProgress(tester),
      1.0,
      reason: 'an overlay opening and closing is not a page change',
    );
  });

  testWidgets('coming back from a real backgrounding still replays it', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
    expect(_statEntranceProgress(tester), 1.0);

    final WidgetsBindingObserver home = homeObserver(tester);
    // Away to another app (or home, or the lock screen) and back: the
    // app passes through `hidden`, and the welcome-back replay is wanted.
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.hidden);
    home.didChangeAppLifecycleState(AppLifecycleState.inactive);
    home.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();

    expect(
      _statEntranceProgress(tester),
      lessThan(1.0),
      reason: 'returning from a real backgrounding must replay the entrance',
    );

    // And the replay finishes, back to a resting screen.
    await tester.pump(const Duration(seconds: 2));
    expect(_statEntranceProgress(tester), 1.0);
  });

  testWidgets('the stat values never fade, they only rise', (
    WidgetTester tester,
  ) async {
    await pumpHome(tester);
    expect(_statEntranceProgress(tester), 1.0);

    // Replay the entrance and catch its very first frame: a fading
    // digit's thin arcs vanish against the wash first and read as the
    // number being cut off at its top and bottom — the value must be at
    // full opacity at every frame of the rise.
    homeObserver(tester)
      ..didChangeAppLifecycleState(AppLifecycleState.hidden)
      ..didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();

    expect(_statEntranceProgress(tester), lessThan(1.0));
    expect(
      find.descendant(
        of: find
            .ancestor(
              of: _statValues().first,
              matching: find.byWidgetPredicate(
                (Widget widget) =>
                    widget is DecoratedBox &&
                    (widget.decoration as BoxDecoration).gradient != null,
              ),
            )
            .first,
        matching: find.byType(FadeTransition),
      ),
      findsNothing,
      reason: 'the values must be solid ink from the first frame',
    );
  });
}
