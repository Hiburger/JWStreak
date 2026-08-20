import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/local_db_service.dart';

/// Reported by a reader who changes time zone often and felt the streak and
/// the reminders weren't keeping up. The streak half is decided entirely by
/// [nextStreakCount], so the flights can be replayed here as plain dates.
void main() {
  group('an ordinary reader', () {
    test('first ever activity starts the streak at 1', () {
      expect(
        nextStreakCount(
          chainKey: null,
          today: DateTime(2026, 8, 20),
          currentCount: 0,
        ),
        1,
      );
    });

    test('a second consecutive day extends it', () {
      expect(
        nextStreakCount(
          chainKey: '2026-08-19',
          today: DateTime(2026, 8, 20),
          currentCount: 12,
        ),
        13,
      );
    });

    test('reading twice in one day changes nothing', () {
      expect(
        nextStreakCount(
          chainKey: '2026-08-20',
          today: DateTime(2026, 8, 20),
          currentCount: 12,
        ),
        isNull,
      );
    });

    test('a real gap restarts the streak', () {
      expect(
        nextStreakCount(
          chainKey: '2026-08-15',
          today: DateTime(2026, 8, 20),
          currentCount: 40,
        ),
        1,
      );
    });
  });

  group('a reader who travels', () {
    test('flying west over a date boundary does not reset the streak', () {
      // Read in Tokyo on the 20th, land in Los Angeles where it is still the
      // 19th, and read again. The chain is a day *ahead* of today. Before the
      // fix the difference came out as -1, missed the "exactly one day"
      // branch and reset a 40-day streak to 1.
      expect(
        nextStreakCount(
          chainKey: '2026-08-20',
          today: DateTime(2026, 8, 19),
          currentCount: 40,
        ),
        isNull,
        reason: 'the streak must be held, never reset, by a backwards date',
      );
    });

    test('crossing the date line several days back still holds', () {
      expect(
        nextStreakCount(
          chainKey: '2026-08-20',
          today: DateTime(2026, 8, 17),
          currentCount: 40,
        ),
        isNull,
      );
    });

    test('the streak resumes once the local date catches up', () {
      // Same traveller, now on the 21st in Los Angeles: a normal day again.
      expect(
        nextStreakCount(
          chainKey: '2026-08-20',
          today: DateTime(2026, 8, 21),
          currentCount: 40,
        ),
        41,
      );
    });

    test('flying east one day forward is an ordinary next day', () {
      expect(
        nextStreakCount(
          chainKey: '2026-08-19',
          today: DateTime(2026, 8, 20),
          currentCount: 7,
        ),
        8,
      );
    });

    test('a time of day on the chain date is ignored, only the day counts', () {
      // Chain keys are yyyy-MM-dd, but be explicit that an hour difference
      // can never tip the comparison over a day boundary.
      expect(
        nextStreakCount(
          chainKey: '2026-08-19',
          today: DateTime(2026, 8, 20, 23, 59),
          currentCount: 3,
        ),
        4,
      );
    });
  });
}
