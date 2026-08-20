import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/app_constants.dart';
import 'package:jwstreak/screens/home_screen.dart';

DateTime _at(int hour, [int minute = 0]) => DateTime(2026, 8, 20, hour, minute);

void main() {
  group('the streak-at-risk card waits for the evening', () {
    test('stays hidden all morning even with nothing read yet', () {
      for (final int hour in <int>[0, 6, 9, 12, 15, 18]) {
        expect(
          shouldWarnStreakAtRisk(
            streak: 12,
            activeToday: false,
            now: _at(hour),
          ),
          isFalse,
          reason: 'should not be warning at ${hour}h',
        );
      }
    });

    test('appears once the threshold hour arrives', () {
      expect(
        shouldWarnStreakAtRisk(
          streak: 12,
          activeToday: false,
          now: _at(kStreakRiskHour - 1, 59),
        ),
        isFalse,
      );
      expect(
        shouldWarnStreakAtRisk(
          streak: 12,
          activeToday: false,
          now: _at(kStreakRiskHour),
        ),
        isTrue,
      );
    });

    test('stays up through the rest of the night', () {
      expect(
        shouldWarnStreakAtRisk(
          streak: 12,
          activeToday: false,
          now: _at(23, 59),
        ),
        isTrue,
      );
    });

    test('never appears once the day is done, however late it is', () {
      expect(
        shouldWarnStreakAtRisk(streak: 12, activeToday: true, now: _at(23, 59)),
        isFalse,
      );
    });

    test('nothing to lose means nothing to warn about', () {
      // A reader with no streak sees the encouraging card instead; this one
      // is specifically about a run that is about to break.
      expect(
        shouldWarnStreakAtRisk(streak: 0, activeToday: false, now: _at(23)),
        isFalse,
      );
    });
  });

  test('the card and the evening notification share one hour', () {
    // If these ever drift, the reader gets a notification saying the day is
    // running out while the home screen still looks calm.
    expect(kStreakRiskHour, inInclusiveRange(0, 23));
    expect(
      shouldWarnStreakAtRisk(
        streak: 1,
        activeToday: false,
        now: _at(kStreakRiskHour),
      ),
      isTrue,
    );
  });
}
