import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/services/app_lock_service.dart';
import 'package:jwstreak/services/local_db_service.dart';
import 'package:local_auth/local_auth.dart';

import 'support/db_test_harness.dart';

/// Stands in for the platform's authentication, which a host test has none
/// of. [supported] is the whole point: it models a phone with no screen lock
/// configured. Only isDeviceSupported is overridden — that is the single call
/// isEnabled makes, and stubbing the rest would just be scaffolding.
class _FakeLocalAuth extends LocalAuthentication {
  _FakeLocalAuth({required this.supported});

  final bool supported;

  @override
  Future<bool> isDeviceSupported() async => supported;
}

void main() {
  useTestDatabase();

  test(
    'the lock stays on where the device can actually authenticate',
    () async {
      await LocalDbService().saveAppLockEnabled(true);
      final AppLockService service = AppLockService(
        auth: _FakeLocalAuth(supported: true),
      );

      expect(await service.isEnabled(), isTrue);
    },
  );

  test(
    'a device that cannot authenticate never reports itself locked',
    () async {
      // The lock screen's only control is the credential prompt, which always
      // fails here. Reporting "locked" would strand the reader outside their
      // own data with no route back to the setting that turns it off.
      await LocalDbService().saveAppLockEnabled(true);
      final AppLockService service = AppLockService(
        auth: _FakeLocalAuth(supported: false),
      );

      expect(await service.isEnabled(), isFalse);
    },
  );

  test('the stored preference survives, so the lock comes back', () async {
    // Suppressing the lock must not quietly turn the setting off: once the
    // reader sets up a screen lock again, their choice should still stand.
    await LocalDbService().saveAppLockEnabled(true);
    await AppLockService(auth: _FakeLocalAuth(supported: false)).isEnabled();

    expect(await LocalDbService().getAppLockEnabled(), isTrue);
    expect(
      await AppLockService(auth: _FakeLocalAuth(supported: true)).isEnabled(),
      isTrue,
    );
  });

  test(
    'restoring a backup taken on a locked phone cannot strand the reader',
    () async {
      // The migration case end to end: app_lock_enabled travels in the backup,
      // and the new phone has no screen lock set up yet.
      final LocalDbService db = LocalDbService();
      await db.saveAppLockEnabled(true);
      final List<Map<String, Object?>> settings = await db.readBackupTable(
        'settings',
      );
      expect(
        settings.any(
          (Map<String, Object?> row) => row['key'] == 'app_lock_enabled',
        ),
        isTrue,
        reason: 'the setting must actually be in the backup for this to matter',
      );

      await db.replaceAllData(<String, List<Map<String, Object?>>>{
        'settings': settings,
      });

      expect(
        await AppLockService(
          auth: _FakeLocalAuth(supported: false),
        ).isEnabled(),
        isFalse,
      );
    },
  );
}
