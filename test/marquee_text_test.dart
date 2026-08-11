import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/widgets/marquee_text.dart';

Widget _harness(Widget child, {double width = 300}) => MaterialApp(
  home: Scaffold(
    body: SizedBox(width: width, child: child),
  ),
);

void main() {
  testWidgets('text that fits stays a plain, unanimated line', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_harness(const MarqueeText(text: 'Good noon')));
    await tester.pump();
    // Give any would-be animation a chance to spin up before asserting it
    // didn't — this is the case that must stay inert.
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Good noon'), findsOneWidget);
    expect(find.byKey(const Key('marqueeTransform')), findsNothing);
    expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsNothing);
  });

  testWidgets('text too wide for its space starts scrolling', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _harness(
        const MarqueeText(
          text:
              'A greeting so long it could not possibly fit in the space '
              'this test gives it',
          style: TextStyle(fontSize: 20),
        ),
        width: 120,
      ),
    );
    await tester.pump();
    // The animation is built one frame after the first layout (it needs to
    // know the constraints before it can measure the overflow).
    await tester.pump();

    expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsOneWidget);

    final Finder transformFinder = find.byKey(const Key('marqueeTransform'));
    expect(transformFinder, findsOneWidget);
    final double offsetAtStart = tester
        .widget<Transform>(transformFinder)
        .transform
        .getTranslation()
        .x;
    // Held at the start of the loop initially — nothing has scrolled yet.
    expect(offsetAtStart, 0);

    // Past the initial hold, the text should have moved to reveal more of
    // itself.
    await tester.pump(const Duration(milliseconds: 1400));
    await tester.pump(const Duration(milliseconds: 400));
    final double offsetMidway = tester
        .widget<Transform>(transformFinder)
        .transform
        .getTranslation()
        .x;
    expect(
      offsetMidway,
      lessThan(offsetAtStart),
      reason: 'text should have scrolled left (negative x) by now',
    );
  });

  testWidgets('switching to a shorter text that now fits stops animating', (
    WidgetTester tester,
  ) async {
    const String longText =
        'A greeting so long it could not possibly fit in the space this '
        'test gives it';
    await tester.pumpWidget(
      _harness(
        const MarqueeText(text: longText, style: TextStyle(fontSize: 20)),
        width: 120,
      ),
    );
    await tester.pump();
    await tester.pump();
    expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsOneWidget);

    await tester.pumpWidget(
      _harness(
        const MarqueeText(text: 'Hi', style: TextStyle(fontSize: 20)),
        width: 120,
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Hi'), findsOneWidget);
    expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsNothing);
  });
}
