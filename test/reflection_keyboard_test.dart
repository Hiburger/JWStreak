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

Finder _reflectionField() => find.byType(TextField);

void _useScreen(WidgetTester tester, {double keyboardHeight = 0}) {
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(_kScreenWidth, _kScreenHeight);
  tester.view.viewInsets = FakeViewPadding(bottom: keyboardHeight);
  addTearDown(tester.view.reset);
}

Future<void> _pumpCheckpoint(
  WidgetTester tester,
  Checkpoint checkpoint, {
  double keyboardHeight = 0,
}) async {
  _useScreen(tester, keyboardHeight: keyboardHeight);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CheckpointScreen(
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
    if (_reflectionField().evaluate().isNotEmpty) {
      return;
    }
  }
  fail('the checkpoint page never finished loading');
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

  testWidgets('the reflection is written inline on the checkpoint page', (
    WidgetTester tester,
  ) async {
    await _pumpCheckpoint(tester, checkpoint);
    // No editor to push to anymore — the field is the entry, right under
    // the reflection prompt.
    expect(_reflectionField(), findsOneWidget);
  });

  testWidgets('leaving the field saves the answer and confirms it', (
    WidgetTester tester,
  ) async {
    await _pumpCheckpoint(tester, checkpoint);

    await tester.enterText(_reflectionField(), 'I liked this passage');
    FocusManager.instance.primaryFocus?.unfocus();
    // The save runs through the real (ffi) database, so the event loop
    // needs a real tick to finish it before the confirmation appears.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump();

    expect(find.text('Saved'), findsOneWidget);
    // The read goes through the real (ffi) database, so like the save it
    // needs a real-time window to complete — awaiting it straight in the
    // fake-async test body would never resolve.
    final String? stored = await tester.runAsync<String?>(
      () => LocalDbService().getReflection(checkpoint.id),
    );
    expect(stored, 'I liked this passage');
    // The "Saved" flash fades on a real-time timer (it is armed from the
    // save's continuation, which completes outside fake time), so its
    // disappearance isn't assertable here — the two assertions above are
    // the behavior that matters.
  });

  testWidgets('the field is scrolled clear of the keyboard when focused', (
    WidgetTester tester,
  ) async {
    await _pumpCheckpoint(tester, checkpoint, keyboardHeight: _kKeyboardHeight);

    // Focus the field directly rather than tapping it: with the keyboard
    // inset applied before the first frame, the field can start laid out
    // under the keyboard, which makes where the tap lands flaky. What this
    // guards is the aftermath of focusing — the page must scroll the field
    // clear of the keyboard.
    await tester.showKeyboard(_reflectionField());
    // Fixed pumps, not pumpAndSettle: the Start button's glow ring repeats
    // forever, so this page never settles.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    expect(
      tester.getRect(_reflectionField()).bottom,
      lessThanOrEqualTo(_kKeyboardTop),
      reason:
          'the focused field must sit above the keyboard, which starts at '
          '$_kKeyboardTop',
    );
  });
}
