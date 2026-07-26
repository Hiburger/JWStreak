import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/widgets/guided_tour.dart';

const TourLabels _labels = TourLabels(
  skip: 'Skip',
  next: 'Next',
  done: 'Got it',
);

/// A tiny host screen exposing keyed targets, so the tour has something real
/// to measure and scroll to.
class _Host extends StatelessWidget {
  const _Host({required this.keys, required this.steps});

  final List<GlobalKey> keys;
  final List<TourStep> Function() steps;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext inner) => ListView(
            children: <Widget>[
              ElevatedButton(
                onPressed: () =>
                    showGuidedTour(inner, steps: steps(), labels: _labels),
                child: const Text('start'),
              ),
              for (final GlobalKey k in keys)
                SizedBox(key: k, height: 400, child: const Text('target')),
            ],
          ),
        ),
      ),
    );
  }
}

/// pumpAndSettle never converges here: the spotlight's glow runs on a
/// repeating AnimationController by design. Settle everything else (route
/// transition, scroll-into-view, card crossfade) with fixed pumps instead.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump(); // process the tap/frame callback
  await tester.pump(const Duration(milliseconds: 300)); // route fade-in
  await tester.pump(const Duration(milliseconds: 300)); // scroll-into-view
  await tester.pump(const Duration(milliseconds: 320)); // spotlight glide
  await tester.pump(const Duration(milliseconds: 200)); // card crossfade
}

void main() {
  testWidgets('walks through every step and closes on the last one', (
    WidgetTester tester,
  ) async {
    final List<GlobalKey> keys = <GlobalKey>[GlobalKey(), GlobalKey()];
    await tester.pumpWidget(
      _Host(
        keys: keys,
        steps: () => <TourStep>[
          TourStep(targetKey: keys[0], title: 'First', body: 'one'),
          TourStep(targetKey: keys[1], title: 'Second', body: 'two'),
        ],
      ),
    );

    await tester.tap(find.text('start'));
    await _settle(tester);
    expect(find.text('First'), findsOneWidget);
    // Not the last step, so the action button invites the user onward.
    expect(find.text('Next'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await _settle(tester);
    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);

    await tester.tap(find.text('Got it'));
    await _settle(tester);
    expect(find.text('Second'), findsNothing);
  });

  testWidgets('tapping anywhere on the scrim advances', (
    WidgetTester tester,
  ) async {
    final List<GlobalKey> keys = <GlobalKey>[GlobalKey(), GlobalKey()];
    await tester.pumpWidget(
      _Host(
        keys: keys,
        steps: () => <TourStep>[
          TourStep(targetKey: keys[0], title: 'First', body: 'one'),
          TourStep(targetKey: keys[1], title: 'Second', body: 'two'),
        ],
      ),
    );

    await tester.tap(find.text('start'));
    await _settle(tester);
    expect(find.text('First'), findsOneWidget);

    // A bare tap on the dimmed backdrop, away from any button.
    await tester.tapAt(const Offset(10, 10));
    await _settle(tester);
    expect(find.text('Second'), findsOneWidget);
  });

  testWidgets('skip closes the tour immediately', (WidgetTester tester) async {
    final List<GlobalKey> keys = <GlobalKey>[GlobalKey(), GlobalKey()];
    await tester.pumpWidget(
      _Host(
        keys: keys,
        steps: () => <TourStep>[
          TourStep(targetKey: keys[0], title: 'First', body: 'one'),
          TourStep(targetKey: keys[1], title: 'Second', body: 'two'),
        ],
      ),
    );

    await tester.tap(find.text('start'));
    await _settle(tester);
    await tester.tap(find.text('Skip'));
    await _settle(tester);

    expect(find.text('First'), findsNothing);
    expect(find.text('Second'), findsNothing);
  });

  testWidgets('steps whose target is absent are skipped', (
    WidgetTester tester,
  ) async {
    final List<GlobalKey> keys = <GlobalKey>[GlobalKey()];
    // This key is never attached to anything on screen.
    final GlobalKey orphan = GlobalKey();
    await tester.pumpWidget(
      _Host(
        keys: keys,
        steps: () => <TourStep>[
          TourStep(targetKey: orphan, title: 'Ghost', body: 'nope'),
          TourStep(targetKey: keys[0], title: 'Real', body: 'yes'),
        ],
      ),
    );

    await tester.tap(find.text('start'));
    await _settle(tester);

    expect(find.text('Ghost'), findsNothing);
    // The only surviving step is also the last one.
    expect(find.text('Real'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
  });

  testWidgets('does nothing when no target is on screen', (
    WidgetTester tester,
  ) async {
    final GlobalKey orphan = GlobalKey();
    await tester.pumpWidget(
      _Host(
        keys: const <GlobalKey>[],
        steps: () => <TourStep>[
          TourStep(targetKey: orphan, title: 'Ghost', body: 'nope'),
        ],
      ),
    );

    await tester.tap(find.text('start'));
    await _settle(tester);

    expect(find.text('Ghost'), findsNothing);
    expect(find.text('Skip'), findsNothing);
  });
}
