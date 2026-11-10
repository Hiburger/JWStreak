import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/local_db_service.dart';

void main() {
  final DateTime today = DateTime(2026, 8, 20, 9, 30);
  final DateTime yesterday = DateTime(2026, 8, 19);

  group('dayWasMissed', () {
    test('no activity at all means yesterday was missed', () {
      expect(dayWasMissed(const <DateTime>[], yesterday), isTrue);
    });

    test('activity yesterday means it was not missed', () {
      expect(
        dayWasMissed(<DateTime>[DateTime(2026, 8, 19, 22, 5)], yesterday),
        isFalse,
      );
    });

    test('activity today only still means yesterday was missed', () {
      expect(dayWasMissed(<DateTime>[today], yesterday), isTrue);
    });

    test('the time of day is ignored', () {
      expect(
        dayWasMissed(<DateTime>[DateTime(2026, 8, 19, 0, 1)], yesterday),
        isFalse,
      );
    });

    test('month boundary: activity on the last day of the previous month', () {
      final DateTime firstOfMonth = DateTime(2026, 8, 1, 10, 0);
      final DateTime lastOfJuly = DateTime(2026, 7, 31);
      expect(
        dayWasMissed(<DateTime>[DateTime(2026, 7, 31, 23, 59)], lastOfJuly),
        isFalse,
      );
      expect(dayWasMissed(<DateTime>[firstOfMonth], lastOfJuly), isTrue);
    });
  });

  group('yesterdayOf', () {
    test('plain day rolls back one calendar day', () {
      expect(yesterdayOf(DateTime(2026, 8, 20, 9, 30)), DateTime(2026, 8, 19));
    });

    test('first of the month rolls into the previous month', () {
      expect(yesterdayOf(DateTime(2026, 8, 1, 0, 5)), DateTime(2026, 7, 31));
    });

    test('January 1st rolls into the previous year', () {
      expect(yesterdayOf(DateTime(2026, 1, 1, 23, 59)), DateTime(2025, 12, 31));
    });

    test('DST spring-forward day still lands on the previous calendar day', () {
      // 2026-03-29 is the EU spring-forward day (23h long): subtracting 24
      // absolute hours from its midnight would land on 2026-03-27 23:00.
      expect(yesterdayOf(DateTime(2026, 3, 29, 12, 0)), DateTime(2026, 3, 28));
    });
  });
}
