import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/notification_service.dart';
import '../../widgets/onboarding_accent.dart';
import 'settings_common.dart';

/// Whether reminders can actually reach the reader. Named "Notifications"
/// rather than "Permissions", and worded the same way: someone opens this
/// page because a reminder didn't arrive, so it leads with the answer to
/// that ("all set" / "can't reach you" / "may arrive late") and only then
/// breaks it down into the two switches Android cares about.
class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({
    required this.notificationService,
    super.key,
  });

  final NotificationService notificationService;

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

/// What the page as a whole has to say, worst problem first.
enum _ReminderHealth { checking, blocked, delayed, ready }

class _NotificationSettingsScreenState extends State<NotificationSettingsScreen>
    with WidgetsBindingObserver {
  bool? _notificationsEnabled;
  bool? _exactAlarmsAllowed;

  /// Exact-alarm scheduling (AlarmManager's SCHEDULE_EXACT_ALARM) is an
  /// Android-only concept — iOS has no equivalent permission, so its row and
  /// its effect on the overall status are both skipped there. A getter
  /// rather than a `static final`: the latter would cache the first platform
  /// it ever saw, which a widget test flipping
  /// `debugDefaultTargetPlatformOverride` would then be stuck with.
  bool get _exactAlarmsApply => defaultTargetPlatform == TargetPlatform.android;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Both fixes below hand off to the system settings app, so the answer to
  /// "is it allowed now?" changes while this page is in the background —
  /// without this, coming back would still show the old, stale "not
  /// allowed" and make the fix look like it failed.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _load();
    }
  }

  Future<void> _load() async {
    try {
      final bool notificationsEnabled = await widget.notificationService
          .areNotificationsEnabled();
      final bool exactAlarmsAllowed = await widget.notificationService
          .canScheduleExactAlarms();
      if (!mounted) {
        return;
      }
      setState(() {
        _notificationsEnabled = notificationsEnabled;
        _exactAlarmsAllowed = exactAlarmsAllowed;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      // Leaving the two flags null keeps the page in its neutral "checking"
      // look rather than claiming a permission is missing when all we know
      // is that we failed to ask.
      showSettingsError(context, error);
    }
  }

  /// Android only shows its own notification prompt once per install, so
  /// after an earlier refusal the request resolves silently and nothing
  /// visible happens. Falling through to the system settings page means one
  /// tap does the right thing either way.
  Future<void> _fixNotifications() async {
    try {
      final bool granted = await widget.notificationService
          .requestNotificationPermission();
      if (!mounted) {
        return;
      }
      setState(() => _notificationsEnabled = granted);
      if (!granted) {
        await widget.notificationService.openNotificationSettings();
      }
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  Future<void> _fixExactAlarms() async {
    try {
      final bool granted = await widget.notificationService
          .requestExactAlarmPermission();
      if (!mounted) {
        return;
      }
      setState(() => _exactAlarmsAllowed = granted);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  _ReminderHealth get _health {
    final bool? notifications = _notificationsEnabled;
    final bool? exact = _exactAlarmsAllowed;
    if (notifications == null || exact == null) {
      return _ReminderHealth.checking;
    }
    if (!notifications) {
      return _ReminderHealth.blocked;
    }
    if (_exactAlarmsApply && !exact) {
      return _ReminderHealth.delayed;
    }
    return _ReminderHealth.ready;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);
    final _ReminderHealth health = _health;

    return SettingsPage(
      title: l10n.settingsCatNotifications,
      children: <Widget>[
        _StatusHero(shape: sectionShape, health: health),
        const SizedBox(height: 16),
        Card.filled(
          shape: sectionShape,
          child: Column(
            children: <Widget>[
              _PermissionRow(
                title: l10n.notifPermRowTitle,
                body: l10n.notifPermRowBody,
                actionLabel: l10n.notifActionTurnOn,
                granted: _notificationsEnabled,
                onFix: _fixNotifications,
              ),
              if (_exactAlarmsApply) ...<Widget>[
                Divider(
                  height: 1,
                  indent: 16,
                  endIndent: 16,
                  color: cs.outlineVariant,
                ),
                _PermissionRow(
                  title: l10n.notifExactRowTitle,
                  body: l10n.notifExactRowBody,
                  actionLabel: l10n.notifActionOpen,
                  granted: _exactAlarmsAllowed,
                  onFix: _fixExactAlarms,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),
        // Reminder times themselves live behind the bell on the home screen,
        // not here — without this the page looks like it should contain them.
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: cs.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  l10n.notifRemindersHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// The page's headline answer. Carries its own color so the state is
/// readable before a single word is: amber for "late", the theme's own error
/// tone for "blocked" (matching the warning banner on the reminder screen),
/// teal for fine.
class _StatusHero extends StatelessWidget {
  const _StatusHero({required this.shape, required this.health});

  final RoundedRectangleBorder shape;
  final _ReminderHealth health;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final (
      IconData icon,
      Color bg,
      Color fg,
      String title,
      String? body,
    ) = switch (health) {
      _ReminderHealth.checking => (
        Icons.hourglass_empty_rounded,
        cs.surfaceContainerHighest,
        cs.onSurfaceVariant,
        l10n.settingsChecking,
        null,
      ),
      _ReminderHealth.blocked => (
        Icons.notifications_off_rounded,
        cs.errorContainer,
        cs.onErrorContainer,
        l10n.notifStatusBlockedTitle,
        l10n.notifStatusBlockedBody,
      ),
      _ReminderHealth.delayed => (
        Icons.schedule_rounded,
        kAccentAmber.background(context),
        kAccentAmber.foreground(context),
        l10n.notifStatusDelayedTitle,
        l10n.notifStatusDelayedBody,
      ),
      _ReminderHealth.ready => (
        Icons.notifications_active_rounded,
        kAccentTeal.background(context),
        kAccentTeal.foreground(context),
        l10n.notifStatusReadyTitle,
        l10n.notifStatusReadyBody,
      ),
    };

    return Card.filled(
      shape: shape,
      color: bg,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: <Widget>[
            Icon(icon, size: 36, color: fg),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: fg,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (body != null) ...<Widget>[
                    const SizedBox(height: 4),
                    Text(
                      body,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: fg.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One permission, in the reader's terms: what it does, whether it's on, and
/// a button only when something actually needs doing.
class _PermissionRow extends StatelessWidget {
  const _PermissionRow({
    required this.title,
    required this.body,
    required this.actionLabel,
    required this.granted,
    required this.onFix,
  });

  final String title;
  final String body;
  final String actionLabel;

  /// null while the check is still in flight — shown as neither allowed nor
  /// refused, since a spinner's worth of uncertainty shouldn't render as a
  /// red "not allowed".
  final bool? granted;
  final VoidCallback onFix;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final (IconData icon, Color color, String label) = switch (granted) {
      null => (
        Icons.more_horiz_rounded,
        cs.onSurfaceVariant,
        l10n.settingsChecking,
      ),
      true => (
        Icons.check_circle_rounded,
        kAccentTeal.foreground(context),
        l10n.notifRowAllowed,
      ),
      false => (Icons.cancel_rounded, cs.error, l10n.notifRowNotAllowed),
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      body,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (granted == false) ...<Widget>[
            const SizedBox(height: 12),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.tonal(
                onPressed: onFix,
                child: Text(actionLabel),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
