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

  testWidgets('the scroll only ever goes left, never back to the right', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _harness(
        const MarqueeText(
          text:
              'A greeting so long it could not possibly fit in the space '
              'this test gives it',
          style: TextStyle(fontSize: 20),
          pauseDuration: Duration(milliseconds: 200),
          // Fast enough that a whole pass fits in a handful of pumps; the
          // direction of travel is what's under test, not the speed.
          pixelsPerSecond: 500,
        ),
        width: 120,
      ),
    );
    await tester.pump();
    await tester.pump();

    final Finder transformFinder = find.byKey(const Key('marqueeTransform'));
    double x() =>
        tester.widget<Transform>(transformFinder).transform.getTranslation().x;

    // Sample across more than a full pass. The old behaviour slid out and
    // then back, so x would have started climbing again partway through.
    await tester.pump(const Duration(milliseconds: 300));
    double previous = x();
    int wraps = 0;
    for (int i = 0; i < 60; i++) {
      await tester.pump(const Duration(milliseconds: 150));
      final double current = x();
      if (current > previous) {
        // The only legal increase is the snap back to 0 as the loop wraps.
        expect(
          current,
          moreOrLessEquals(0, epsilon: 1),
          reason: 'x moved right mid-pass, so the scroll reversed',
        );
        wraps++;
      }
      previous = current;
    }
    expect(wraps, greaterThan(0), reason: 'the loop never came back around');
  });

  testWidgets('scrolling inside the home banner’s layout keeps its size', (
    WidgetTester tester,
  ) async {
    // A previous attempt at the one-way scroll wrapped the line in an
    // OverflowBox, which measured fine in the plain harness above but
    // collapsed the real banner — the greeting row shrank to a sliver and
    // took the rest of the home screen with it. This reproduces the banner's
    // actual constraints: Row > Expanded inside a shrink-wrapping Column.
    final Widget banner = Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(Icons.wb_sunny, size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: MarqueeText(
                    text: 'A greeting far too long to fit in this banner row',
                    style: const TextStyle(fontSize: 20),
                    pauseDuration: const Duration(milliseconds: 100),
                    pixelsPerSecond: 500,
                  ),
                ),
              ],
            ),
            const Text('below the greeting'),
          ],
        ),
      ),
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: banner)));
    await tester.pump();
    await tester.pump();
    expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsOneWidget);

    // The greeting must still occupy a real line, and what sits under it
    // must still be laid out — that is exactly what regressed before.
    final Size marqueeSize = tester.getSize(find.byType(MarqueeText));
    expect(marqueeSize.width, greaterThan(100));
    expect(marqueeSize.height, greaterThan(10));
    expect(find.text('below the greeting'), findsOneWidget);

    // And it must survive a few frames of actual scrolling, not just the
    // first build.
    await tester.pump(const Duration(milliseconds: 600));
    expect(tester.getSize(find.byType(MarqueeText)), marqueeSize);
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'a larger system text scale is measured, not just the base size',
    (WidgetTester tester) async {
      // At the default scale this text fits comfortably in 260px (measures
      // ~252px); it only overflows once the ambient text scale doubles it.
      // A TextPainter that measures at scale 1.0 regardless of context
      // would see no overflow and never start the marquee, silently
      // clipping the scaled-up text instead.
      await tester.pumpWidget(
        _harness(
          MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(2.0)),
            child: const MarqueeText(
              text: 'Good afternoon',
              style: TextStyle(fontSize: 18),
            ),
          ),
          width: 260,
        ),
      );
      await tester.pump();
      await tester.pump();

      expect(find.byKey(const Key('marqueeAnimatedBuilder')), findsOneWidget);
    },
  );
}
