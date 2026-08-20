import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/widgets/time_wheel_picker.dart';

/// Opens the picker from a throwaway page and reports what it returned.
Future<void> _openPicker(
  WidgetTester tester, {
  String? confirmLabel,
  required void Function(TimeOfDay?) onResult,
}) async {
  // A phone-shaped surface: the sheet's wheels need more height than the
  // 800x600 the test binding defaults to.
  tester.view.devicePixelRatio = 1.0;
  tester.view.physicalSize = const Size(400, 900);
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () async => onResult(
                await showTimeWheelPicker(
                  context: context,
                  initialTime: const TimeOfDay(hour: 8, minute: 0),
                  title: 'Edit time',
                  confirmLabel: confirmLabel,
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
}

void main() {
  // Midnight and noon are where twelve-hour clocks stop being arithmetic:
  // 0 shows as 12, 12 also shows as 12, and getting either one backwards
  // silently schedules a reminder half a day away from what the user picked.
  group('displayHourFrom24', () {
    test('midnight and noon both show as 12', () {
      expect(displayHourFrom24(0), 12);
      expect(displayHourFrom24(12), 12);
    });

    test('morning hours pass through unchanged', () {
      expect(displayHourFrom24(1), 1);
      expect(displayHourFrom24(8), 8);
      expect(displayHourFrom24(11), 11);
    });

    test('afternoon hours wrap back to 1-11', () {
      expect(displayHourFrom24(13), 1);
      expect(displayHourFrom24(20), 8);
      expect(displayHourFrom24(23), 11);
    });

    test('never returns 0', () {
      for (int h = 0; h < 24; h++) {
        expect(displayHourFrom24(h), inInclusiveRange(1, 12));
      }
    });
  });

  group('hour24From12', () {
    test('12 AM is midnight, 12 PM is noon', () {
      expect(hour24From12(displayHour: 12, isPm: false), 0);
      expect(hour24From12(displayHour: 12, isPm: true), 12);
    });

    test('morning hours pass through unchanged', () {
      expect(hour24From12(displayHour: 1, isPm: false), 1);
      expect(hour24From12(displayHour: 8, isPm: false), 8);
      expect(hour24From12(displayHour: 11, isPm: false), 11);
    });

    test('afternoon hours shift by twelve', () {
      expect(hour24From12(displayHour: 1, isPm: true), 13);
      expect(hour24From12(displayHour: 8, isPm: true), 20);
      expect(hour24From12(displayHour: 11, isPm: true), 23);
    });
  });

  test('every hour of the day survives a round trip', () {
    // Displaying an hour then reading it back must land on the same hour,
    // which is exactly what happens each time the AM/PM wheel is spun.
    for (int hour = 0; hour < 24; hour++) {
      final int roundTripped = hour24From12(
        displayHour: displayHourFrom24(hour),
        isPm: hour >= 12,
      );
      expect(roundTripped, hour, reason: 'hour $hour did not round-trip');
    }
  });

  test('flipping the period moves exactly twelve hours, both ways', () {
    for (int hour = 0; hour < 24; hour++) {
      final int flipped = hour24From12(
        displayHour: displayHourFrom24(hour),
        // The opposite of where this hour currently sits.
        isPm: hour < 12,
      );
      expect(
        flipped,
        (hour + 12) % 24,
        reason: 'flipping the period on hour $hour',
      );
    }
  });

  testWidgets('without a label the button still reads OK', (
    WidgetTester tester,
  ) async {
    // The daily-text reminder only edits a time it already owns, so the
    // neutral platform label stays right there.
    await _openPicker(tester, onResult: (_) {});
    expect(find.text('OK'), findsOneWidget);
  });

  testWidgets('a confirm label says what the button will do', (
    WidgetTester tester,
  ) async {
    await _openPicker(
      tester,
      confirmLabel: 'Add this reminder',
      onResult: (_) {},
    );
    expect(find.text('Add this reminder'), findsOneWidget);
    expect(
      find.text('OK'),
      findsNothing,
      reason: 'the caller-supplied label replaces OK, it does not join it',
    );
  });

  testWidgets('confirming returns the time, cancelling returns null', (
    WidgetTester tester,
  ) async {
    TimeOfDay? result;
    bool called = false;
    await _openPicker(
      tester,
      confirmLabel: 'Add this reminder',
      onResult: (TimeOfDay? t) {
        result = t;
        called = true;
      },
    );

    await tester.tap(find.text('Add this reminder'));
    await tester.pumpAndSettle();
    expect(called, isTrue);
    expect(result, const TimeOfDay(hour: 8, minute: 0));

    called = false;
    result = const TimeOfDay(hour: 1, minute: 1);
    await _openPicker(
      tester,
      confirmLabel: 'Add this reminder',
      onResult: (TimeOfDay? t) {
        result = t;
        called = true;
      },
    );
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(called, isTrue);
    expect(result, isNull, reason: 'backing out must not add anything');
  });
}
