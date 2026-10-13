import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

late tz.Location _paris;

tz.TZDateTime _at(int y, int m, int d, int h, [int min = 0]) =>
    tz.TZDateTime(_paris, y, m, d, h, min);

void main() {
  setUpAll(() {
    tz_data.initializeTimeZones();
    _paris = tz.getLocation('Europe/Paris');
  });

  group('a reader who has not read yet today', () {
    test('a reminder later today fires today', () {
      expect(
        nextReminderInstance(
          now: _at(2026, 8, 20, 7, 0),
          time: const TimeOfDay(hour: 8, minute: 0),
        ),
        _at(2026, 8, 20, 8, 0),
      );
    });

    test('a reminder already past today fires tomorrow', () {
      expect(
        nextReminderInstance(
          now: _at(2026, 8, 20, 9, 0),
          time: const TimeOfDay(hour: 8, minute: 0),
        ),
        _at(2026, 8, 21, 8, 0),
      );
    });
  });

  group('a reader who has already read today', () {
    test('today’s remaining reminder is skipped', () {
      // The whole point: read at 08:00, do not get told at 20:00 to go and
      // keep the streak that is already kept.
      expect(
        nextReminderInstance(
          now: _at(2026, 8, 20, 9, 0),
          time: const TimeOfDay(hour: 20, minute: 0),
          skipToday: true,
        ),
        _at(2026, 8, 21, 20, 0),
      );
    });

    test('a reminder already past today is not pushed two days out', () {
      // Its next firing was tomorrow anyway; skipping "today" must not skip
      // tomorrow as well.
      expect(
        nextReminderInstance(
          now: _at(2026, 8, 20, 9, 0),
          time: const TimeOfDay(hour: 8, minute: 0),
          skipToday: true,
        ),
        _at(2026, 8, 21, 8, 0),
      );
    });

    test('the daily time itself never drifts', () {
      final tz.TZDateTime next = nextReminderInstance(
        now: _at(2026, 8, 20, 7, 0),
        time: const TimeOfDay(hour: 8, minute: 30),
        skipToday: true,
      );
      expect(next.hour, 8);
      expect(next.minute, 30);
    });
  });

  group('across a daylight-saving change', () {
    // Europe/Paris springs forward at 02:00 on 29 March 2026.
    test('an 08:00 reminder is still 08:00 the next morning', () {
      final tz.TZDateTime next = nextReminderInstance(
        now: _at(2026, 3, 28, 9, 0),
        time: const TimeOfDay(hour: 8, minute: 0),
        skipToday: true,
      );
      expect(next.day, 29);
      expect(
        next.hour,
        8,
        reason:
            'adding 24 hours instead of a calendar day would land at 09:00 '
            'and stay shifted, because each reschedule builds on the last',
      );
    });

    test('and still 08:00 when the clocks go back', () {
      // Paris falls back at 03:00 on 25 October 2026.
      final tz.TZDateTime next = nextReminderInstance(
        now: _at(2026, 10, 24, 9, 0),
        time: const TimeOfDay(hour: 8, minute: 0),
        skipToday: true,
      );
      expect(next.day, 25);
      expect(next.hour, 8);
    });

    test('skipping today keeps the time across the change too', () {
      // Covers the skip-today branch specifically: here today's 08:00 is
      // still ahead, so it is the skip that moves the reminder over the
      // transition rather than the already-passed path.
      final tz.TZDateTime next = nextReminderInstance(
        now: _at(2026, 3, 28, 7, 0),
        time: const TimeOfDay(hour: 8, minute: 0),
        skipToday: true,
      );
      expect(next.day, 29);
      expect(next.hour, 8);
    });

    test('month and year ends roll over correctly', () {
      expect(
        nextReminderInstance(
          now: _at(2026, 12, 31, 9, 0),
          time: const TimeOfDay(hour: 8, minute: 0),
          skipToday: true,
        ),
        _at(2027, 1, 1, 8, 0),
      );
    });
  });

  group('the skipped-day companion one-shot', () {
    test('is the day after the skipped occurrence, at the same time', () {
      expect(
        followingDayInstance(_at(2026, 8, 21, 20, 0)),
        _at(2026, 8, 22, 20, 0),
      );
    });

    test('rolls over a month end', () {
      expect(
        followingDayInstance(_at(2026, 8, 31, 20, 0)),
        _at(2026, 9, 1, 20, 0),
      );
    });

    test('lands on the next day even across a daylight-saving change', () {
      // Paris leaves summer time on 2026-10-25, at 03:00: the 25th is 25
      // hours long. Built from the calendar rather than by adding 24 hours,
      // the companion is still the 26th at the same wall-clock time.
      final tz.TZDateTime companion = followingDayInstance(
        _at(2026, 10, 25, 8, 0),
      );
      expect(companion.month, 10);
      expect(companion.day, 26);
      expect(companion.hour, 8);
    });
  });
}
