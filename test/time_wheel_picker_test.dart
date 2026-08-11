import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/widgets/time_wheel_picker.dart';

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
}
