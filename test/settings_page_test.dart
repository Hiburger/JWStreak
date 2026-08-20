import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/screens/settings/settings_common.dart';

void main() {
  testWidgets(
    'a long translated title shrinks to fit instead of being cut off',
    (WidgetTester tester) async {
      // Regression test: "Конфиденциальность и данные" used to render as
      // "Конфиденциальность и данн…" in the app bar because a plain Text()
      // has no room to grow and Flutter silently clips/ellipsizes the
      // overflow at paint time — something a bare `find.text()` check can't
      // catch, since the widget's data string is unchanged either way. What
      // can be checked is the fix itself: the title sits inside a FittedBox
      // that scales the whole thing down to fit, so nothing is ever cut.
      const String longTitle =
          'Конфиденциальность и данные, а longer title than any app bar '
          'should reasonably fit at full size';

      await tester.pumpWidget(
        MaterialApp(
          home: SettingsPage(title: longTitle, children: const <Widget>[]),
        ),
      );

      final Finder titleText = find.descendant(
        of: find.byType(AppBar),
        matching: find.text(longTitle),
      );
      expect(titleText, findsOneWidget);

      final Finder fittedBox = find.ancestor(
        of: titleText,
        matching: find.byType(FittedBox),
      );
      expect(
        fittedBox,
        findsOneWidget,
        reason: 'the app bar title must be able to shrink to fit',
      );
      expect(tester.widget<FittedBox>(fittedBox).fit, BoxFit.scaleDown);
    },
  );

  testWidgets('a short title still renders normally', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: SettingsPage(title: 'Privacy', children: const <Widget>[]),
      ),
    );
    expect(find.text('Privacy'), findsOneWidget);
  });
}
