import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/main.dart';

/// The "Open" button's shake transform. Its offset is what the nudge moves.
Finder _openTransform() => find.descendant(
  of: find.byKey(const Key('homeOpenNudge')),
  matching: find.byType(Transform),
);

double _openX(WidgetTester tester) =>
    tester.widget<Transform>(_openTransform()).transform.getTranslation().x;

void main() {
  testWidgets('tapping "Mark as read" too early shakes the Open button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const DailyJwApp(skipBootstrap: true));
    // No pumpAndSettle anywhere in here: the banner greeting's marquee can
    // repeat forever, so settling would never return.
    await tester.pump();
    await tester.pump();

    // Nothing has been opened yet, so "Mark as read" is disabled.
    expect(find.text('Mark as read'), findsOneWidget);
    expect(_openX(tester), 0, reason: 'should start at rest');

    await tester.tap(find.text('Mark as read'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    expect(
      _openX(tester),
      isNot(0),
      reason: 'the disabled tap should have nudged Open',
    );

    // And it settles back exactly where it started rather than leaving the
    // button parked off-centre.
    await tester.pump(const Duration(milliseconds: 600));
    expect(_openX(tester), 0);
  });

  testWidgets('the shake moves paint only, never layout', (
    WidgetTester tester,
  ) async {
    // An earlier animation attempt elsewhere in the app changed the size a
    // widget reported to its parent and collapsed the screen around it.
    // Transform.translate must not do that: same size, before and during.
    await tester.pumpWidget(const DailyJwApp(skipBootstrap: true));
    await tester.pump();
    await tester.pump();

    final Rect openBefore = tester.getRect(find.text('Open'));
    final Rect markBefore = tester.getRect(find.text('Mark as read'));

    await tester.tap(find.text('Mark as read'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 80));

    // The Open button paints shifted, so its rect moves horizontally — but
    // its size, and everything around it, must be untouched.
    final Rect openDuring = tester.getRect(find.text('Open'));
    expect(openDuring.size, openBefore.size);
    expect(openDuring.top, openBefore.top);
    expect(tester.getRect(find.text('Mark as read')), markBefore);

    await tester.pump(const Duration(milliseconds: 600));
    expect(tester.getRect(find.text('Open')), openBefore);
    expect(tester.takeException(), isNull);
  });
}
