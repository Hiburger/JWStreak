import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'local_db_service.dart';

/// Gates the app behind the device's own screen lock (fingerprint, face, or
/// the PIN/pattern/password fallback).
///
/// Nothing is encrypted by this: the notes stay in the same local SQLite file
/// they always were. This only stops someone holding the unlocked phone from
/// casually reading them — which is the threat that actually applies to a
/// device you hand to a friend, not an attacker with the storage in hand.
class AppLockService {
  AppLockService({LocalAuthentication? auth, LocalDbService? dbService})
    : _auth = auth ?? LocalAuthentication(),
      _dbService = dbService ?? LocalDbService();

  final LocalAuthentication _auth;
  final LocalDbService _dbService;

  /// Whether the device can authenticate at all — either with a biometric
  /// sensor or, failing that, with the PIN/pattern/password screen lock.
  /// A device with no screen lock configured returns false, and the setting
  /// must stay unavailable there: enabling it would lock the user out.
  Future<bool> isAvailable() async {
    try {
      return await _auth.isDeviceSupported();
    } on PlatformException {
      return false;
    }
  }

  /// Defaults to "not locked" if the setting can't be read. A database that
  /// won't open is already a broken app; turning that into a permanent
  /// lockout with no way back in would be the worse of the two failures.
  Future<bool> isEnabled() async {
    try {
      return await _dbService.getAppLockEnabled();
    } catch (_) {
      return false;
    }
  }

  Future<void> setEnabled(bool value) => _dbService.saveAppLockEnabled(value);

  /// Prompts for the device credential. Returns true only on a confirmed
  /// success; every failure path (cancelled, no hardware, too many attempts)
  /// returns false, so a caller can treat it as "stay locked" without having
  /// to know which of the platform's many error codes came back.
  Future<bool> authenticate({required String reason}) async {
    try {
      return await _auth.authenticate(
        localizedReason: reason,
        // Keeps the prompt alive if the system briefly backgrounds the app
        // (a notification shade pull, an incoming call banner) instead of
        // failing the attempt outright.
        persistAcrossBackgrounding: true,
      );
    } on PlatformException {
      return false;
    }
  }
}
