import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/bible_data.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/quiz/quiz_data.dart';
import 'package:jwstreak/screens/checkpoint_screen.dart';
import 'package:jwstreak/services/local_db_service.dart';

import 'support/db_test_harness.dart';

const double _kScreenHeight = 800;
const double _kScreenWidth = 400;
const double _kKeyboardHeight = 340;
const double _kKeyboardTop = _kScreenHeight - _kKeyboardHeight;

Finder _saveButton() => find.byWidgetPredicate((Widget w) => w is FilledButton);

void _useScreen(WidgetTester tester, {double keyboardHeight = 0}) {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(_kScreenWidth, _kScreenHeight);
  tester.view.viewInsets = FakeViewPadding(bottom: keyboardHeight);
  addTearDown(tester.view.reset);
}

Future<void> _pumpReflection(
  WidgetTester tester,
  Checkpoint checkpoint, {
  double keyboardHeight = 0,
}) async {
  _useScreen(tester, keyboardHeight: keyboardHeight);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ReflectionScreen(
        dbService: LocalDbService(),
        checkpoint: checkpoint,
      ),
    ),
  );

  for (int attempt = 0; attempt < 40; attempt++) {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 25)),
    );
    await tester.pump();
    if (_saveButton().evaluate().isNotEmpty) {
      return;
    }
  }
  fail('the reflection form never finished loading');
}

void main() {
  useTestDatabase();

  late Checkpoint checkpoint;

  setUp(() {
    final BibleBook genesis = kBibleBooks.firstWhere(
      (BibleBook b) => b.id == 'Genesis',
    );
    checkpoint = checkpointsForBook(genesis).first;
  });

  testWidgets('the Save button stays above the keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpReflection(tester, checkpoint, keyboardHeight: _kKeyboardHeight);

    expect(_saveButton(), findsOneWidget);
    expect(
      tester.getRect(_saveButton()).bottom,
      lessThanOrEqualTo(_kKeyboardTop),
      reason:
          'Save must sit above the keyboard, which starts at $_kKeyboardTop',
    );
  });

  testWidgets('the Save button still sits at the bottom with no keyboard', (
    WidgetTester tester,
  ) async {
    await _pumpReflection(tester, checkpoint);

    // It must not have floated up into the middle of the page now that it
    // lives inside the body rather than in bottomNavigationBar.
    expect(
      tester.getRect(_saveButton()).bottom,
      greaterThan(_kScreenHeight - 60),
    );
  });

  testWidgets('the text field is not covered by the keyboard either', (
    WidgetTester tester,
  ) async {
    await _pumpReflection(tester, checkpoint, keyboardHeight: _kKeyboardHeight);

    expect(tester.getRect(find.byType(TextField)).top, lessThan(_kKeyboardTop));
  });
}
