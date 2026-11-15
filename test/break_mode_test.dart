import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/local_db_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'support/db_test_harness.dart';

Break breakOf(
  String startDay,
  String endDay, {
  BreakTier tier = BreakTier.small,
}) => Break(id: 1, tier: tier, startDay: startDay, endDay: endDay);

void main() {
  useTestDatabase();

  group('isDayInBreaks', () {
    final breaks = <Break>[breakOf('2026-08-10', '2026-08-12')];

    test('start and end days are included', () {
      expect(isDayInBreaks(breaks, '2026-08-10'), isTrue);
      expect(isDayInBreaks(breaks, '2026-08-12'), isTrue);
      expect(isDayInBreaks(breaks, '2026-08-11'), isTrue);
    });

    test('days outside the range are not covered', () {
      expect(isDayInBreaks(breaks, '2026-08-09'), isFalse);
      expect(isDayInBreaks(breaks, '2026-08-13'), isFalse);
    });

    test('no breaks covers nothing', () {
      expect(isDayInBreaks(const <Break>[], '2026-08-11'), isFalse);
    });
  });

  group('break tiers', () {
    test('durations and yearly caps are pinned', () {
      expect(BreakTier.mini.durationDays, 1);
      expect(BreakTier.small.durationDays, 3);
      expect(BreakTier.medium.durationDays, 7);
      expect(BreakTier.big.durationDays, 14);
      // Bigger break = fewer times per year, so breaks stay a breather.
      expect(BreakTier.mini.yearlyCap, 12);
      expect(BreakTier.small.yearlyCap, 6);
      expect(BreakTier.medium.yearlyCap, 3);
      expect(BreakTier.big.yearlyCap, 1);
    });
  });

  group('nextBreakAllowedOn', () {
    final DateTime today = DateTime(2026, 8, 20);

    test('no breaks yet means allowed immediately', () {
      expect(nextBreakAllowedOn(const <Break>[], today), isNull);
    });

    test('a small break ending yesterday blocks for a week', () {
      final breaks = <Break>[
        breakOf('2026-08-18', '2026-08-19', tier: BreakTier.small),
      ];
      expect(nextBreakAllowedOn(breaks, today), DateTime(2026, 8, 26));
    });

    test('a big break blocks for its own length (14 days)', () {
      final breaks = <Break>[
        breakOf('2026-08-01', '2026-08-14', tier: BreakTier.big),
      ];
      expect(nextBreakAllowedOn(breaks, today), DateTime(2026, 8, 28));
    });

    test('an old break whose cooldown has passed allows a new one', () {
      final breaks = <Break>[
        breakOf('2026-07-01', '2026-07-02', tier: BreakTier.mini),
      ];
      expect(nextBreakAllowedOn(breaks, today), isNull);
    });

    test('the latest break decides, not the first', () {
      final breaks = <Break>[
        breakOf('2026-08-18', '2026-08-19', tier: BreakTier.mini),
        breakOf('2026-07-01', '2026-07-05', tier: BreakTier.medium),
      ];
      expect(nextBreakAllowedOn(breaks, today), DateTime(2026, 8, 26));
    });
  });

  group('break storage', () {
    test('startBreak covers today through today+duration-1', () async {
      final LocalDbService db = LocalDbService();
      await db.startBreak(BreakTier.small);
      final Break? active = await db.getActiveBreak();
      expect(active, isNotNull);
      expect(active!.tier, BreakTier.small);
      final DateTime today = DateTime.now();
      expect(
        active.startDay,
        dayKeyOf(DateTime(today.year, today.month, today.day)),
      );
      expect(
        active.endDay,
        dayKeyOf(DateTime(today.year, today.month, today.day + 2)),
      );
    });

    test('the break reason is stored and read back', () async {
      final LocalDbService db = LocalDbService();
      await db.startBreak(BreakTier.mini, reason: '  exams week  ');
      final Break? active = await db.getActiveBreak();
      expect(active!.reason, 'exams week'); // trimmed
      expect((await db.getAllBreaks()).single.reason, 'exams week');
    });

    test('a second break cannot start while one is active', () async {
      final LocalDbService db = LocalDbService();
      expect(await db.canStartBreak(BreakTier.mini), isTrue);
      await db.startBreak(BreakTier.mini);
      expect(await db.canStartBreak(BreakTier.small), isFalse);
    });

    test('cancelling ends the break but still counts the usage', () async {
      final LocalDbService db = LocalDbService();
      await db.startBreak(BreakTier.big);
      expect(await db.breakUsageThisYear(BreakTier.big), 1);
      await db.cancelActiveBreak();
      expect(await db.getActiveBreak(), isNull);
      // The row is kept, so the yearly cap still sees the use…
      expect(await db.breakUsageThisYear(BreakTier.big), 1);
      // …and the cooldown blocks a new break right after, even under the cap.
      expect(await db.canStartBreak(BreakTier.small), isFalse);
      expect(await db.nextBreakAllowedDay(), isNotNull);
    });

    test('the yearly cap blocks a tier once exhausted', () async {
      final LocalDbService db = LocalDbService();
      await db.initialize();

      final dynamic raw = await databaseFactoryFfi.openDatabase(
        await testDatabasePath(),
      );
      final String year = DateTime.now().year.toString();
      // The big tier's cap is 1, so a single consumed break exhausts it.
      await raw.insert('breaks', <String, Object?>{
        'tier': 'big',
        'startDay': '$year-01-01',
        'endDay': '$year-01-14',
      });
      expect(await db.breakUsageThisYear(BreakTier.big), 1);
      expect(await db.canStartBreak(BreakTier.big), isFalse);
      expect(await db.canStartBreak(BreakTier.small), isTrue);
    });
  });

  group('streak reconciliation with breaks', () {
    Future<void> setChain(LocalDbService db, DateTime day) async {
      final dynamic raw = await databaseFactoryFfi.openDatabase(
        await testDatabasePath(),
      );
      await raw.update(
        'settings',
        <String, Object>{'value': dayKeyOf(day)},
        where: 'key = ?',
        whereArgs: <Object>['streak_chain'],
      );
    }

    Future<void> insertBreak(
      DateTime start,
      DateTime end, {
      BreakTier tier = BreakTier.medium,
    }) async {
      final dynamic raw = await databaseFactoryFfi.openDatabase(
        await testDatabasePath(),
      );
      await raw.insert('breaks', <String, Object?>{
        'tier': tier.name,
        'startDay': dayKeyOf(start),
        'endDay': dayKeyOf(end),
      });
    }

    test('a break excuses missed days without spending freezes', () async {
      final LocalDbService db = LocalDbService();
      await db.markChapterRead(book: 'Genesis', chapter: 1);
      final DateTime today = DateTime.now();
      await setChain(db, DateTime(today.year, today.month, today.day - 10));
      await insertBreak(
        DateTime(today.year, today.month, today.day - 9),
        DateTime(today.year, today.month, today.day - 1),
      );

      final StreakState state = await db.getStreakState();
      expect(state.count, 1);
      expect(state.freezes, 4);
      expect(state.justLost, isFalse);
    });

    test('without a break the same gap loses the streak', () async {
      final LocalDbService db = LocalDbService();
      await db.markChapterRead(book: 'Genesis', chapter: 1);
      final DateTime today = DateTime.now();
      await setChain(db, DateTime(today.year, today.month, today.day - 10));

      final StreakState state = await db.getStreakState();
      expect(state.count, 0);
      expect(state.justLost, isTrue);
    });

    test('days outside the break still consume freezes', () async {
      final LocalDbService db = LocalDbService();
      await db.markChapterRead(book: 'Genesis', chapter: 1);
      final DateTime today = DateTime.now();

      await setChain(db, DateTime(today.year, today.month, today.day - 10));
      await insertBreak(
        DateTime(today.year, today.month, today.day - 9),
        DateTime(today.year, today.month, today.day - 5),
      );

      final StreakState state = await db.getStreakState();
      expect(state.count, 1);
      expect(state.freezes, 0); // the 4 freezes covered the rest
      expect(state.justLost, isFalse);
      expect(await db.getFrozenDays(), hasLength(4));
    });
  });
}
