import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

String _deviceZone = 'Europe/Paris';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    tz_data.initializeTimeZones();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_timezone'), (
          MethodCall call,
        ) async {
          if (call.method == 'getLocalTimezone') {
            return _deviceZone;
          }
          return null;
        });
  });

  tearDownAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('flutter_timezone'),
          null,
        );
  });

  test('a flight is noticed, and staying put is not', () async {
    final NotificationService notifications = NotificationService();

    _deviceZone = 'Europe/Paris';
    expect(
      await notifications.refreshTimeZone(),
      isFalse,
      reason: 'adopting a zone for the first time is not a change',
    );
    expect(tz.local.name, 'Europe/Paris');

    expect(
      await notifications.refreshTimeZone(),
      isFalse,
      reason: 'asking again from the same place must not reschedule anything',
    );

    // Landed somewhere else
    _deviceZone = 'Asia/Tokyo';
    expect(
      await notifications.refreshTimeZone(),
      isTrue,
      reason: 'a new device zone has to be reported so reminders re-arm',
    );
    expect(
      tz.local.name,
      'Asia/Tokyo',
      reason:
          'the timezone package must actually be pointed at the new zone, '
          'or reminders keep resolving against the old one',
    );

    expect(await notifications.refreshTimeZone(), isFalse);

    // And home again
    _deviceZone = 'Europe/Paris';
    expect(await notifications.refreshTimeZone(), isTrue);
    expect(tz.local.name, 'Europe/Paris');
  });
}
