import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/app_lock_service.dart';

/// Hides [child] behind the device's screen lock while the app lock setting
/// is on.
///
/// Re-locks when the app has been in the background longer than
/// [_backgroundGrace]. That grace period exists because this app's main loop
/// is "tap a chapter, read it in JW Library, come back" — re-authenticating on
/// every single return would make the feature the first thing anyone turns
/// off. Coming back to a phone left alone for a while still asks again.
class AppLockGate extends StatefulWidget {
  const AppLockGate({super.key, required this.child, this.lockService});

  final Widget child;
  final AppLockService? lockService;

  @override
  State<AppLockGate> createState() => AppLockGateState();
}

class AppLockGateState extends State<AppLockGate> with WidgetsBindingObserver {
  static const Duration _backgroundGrace = Duration(minutes: 10);

  late final AppLockService _lockService =
      widget.lockService ?? AppLockService();

  bool _locked = false;
  bool _checking = true;
  // True while the system's own biometric sheet is up. That sheet backgrounds
  // the Flutter activity, so without this flag the resume it causes would be
  // read as "user came back from elsewhere" and start a second prompt.
  bool _authenticating = false;
  DateTime? _leftAt;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _lockIfEnabled();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _lockIfEnabled({bool promptImmediately = true}) async {
    final bool enabled = await _lockService.isEnabled();
    if (!mounted) {
      return;
    }
    setState(() {
      _locked = enabled;
      _checking = false;
    });
    if (enabled && promptImmediately) {
      await _promptUnlock();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_authenticating) {
      return;
    }
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      _leftAt = DateTime.now();
      return;
    }
    if (state != AppLifecycleState.resumed || _locked) {
      return;
    }
    final DateTime? leftAt = _leftAt;
    _leftAt = null;
    if (leftAt == null ||
        DateTime.now().difference(leftAt) < _backgroundGrace) {
      return;
    }
    // Only re-show the lock screen here, without auto-firing the system
    // prompt: the Activity has just this instant come back to the
    // foreground, and asking BiometricPrompt to appear in that exact window
    // is unreliable — it can silently fail to attach. Left to a real tap on
    // the Unlock button (a later frame, unambiguously foregrounded), it
    // shows every time.
    _lockIfEnabled(promptImmediately: false);
  }

  /// Shows the system prompt. Staying locked on failure is deliberate: the
  /// user can retry from the button, and there is no in-app passcode fallback
  /// to fall down to. The whole body runs in a finally so _authenticating
  /// always clears — the button reads "does nothing" forever if any
  /// exception here (not just local_auth's own PlatformException) left it
  /// stuck true.
  Future<void> _promptUnlock() async {
    if (_authenticating || !mounted) {
      return;
    }
    _authenticating = true;
    try {
      final String reason = AppLocalizations.of(context)!.appLockPromptReason;
      final bool ok = await _lockService.authenticate(reason: reason);
      if (!mounted || !ok) {
        return;
      }
      setState(() => _locked = false);
    } finally {
      _authenticating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(body: SizedBox.shrink());
    }
    if (!_locked) {
      return widget.child;
    }
    return _LockScreen(onUnlock: _promptUnlock);
  }
}

class _LockScreen extends StatelessWidget {
  const _LockScreen({required this.onUnlock});

  final Future<void> Function() onUnlock;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cs.primaryContainer,
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 48,
                  color: cs.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 28),
              Text(
                l10n.appLockScreenTitle,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                l10n.appLockScreenBody,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onUnlock,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    l10n.appLockUnlockButton,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
