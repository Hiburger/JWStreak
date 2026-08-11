import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/notification_service.dart';
import 'settings_common.dart';

/// The permissions reminders depend on. Named "Notifications" rather than
/// "Permissions": the reader is looking for why a reminder didn't arrive,
/// not for a list of Android permission grants.
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

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool? _notificationsEnabled;
  bool? _exactAlarmsAllowed;
  bool _isChecking = true;

  @override
  void initState() {
    super.initState();
    _load();
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
        _isChecking = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isChecking = false;
      });
      showSettingsError(context, error);
    }
  }

  Future<void> _requestPermission() async {
    try {
      final bool granted = await widget.notificationService
          .requestNotificationPermission();
      if (!mounted) {
        return;
      }
      setState(() {
        _notificationsEnabled = granted;
      });
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  Future<void> _requestExactAlarms() async {
    try {
      final bool granted = await widget.notificationService
          .requestExactAlarmPermission();
      if (!mounted) {
        return;
      }
      setState(() {
        _exactAlarmsAllowed = granted;
      });
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);
    final bool notificationsEnabled = _notificationsEnabled ?? false;
    final bool exactAlarmsAllowed = _exactAlarmsAllowed ?? false;

    return SettingsPage(
      title: l10n.settingsCatNotifications,
      children: <Widget>[
        Card.filled(
          shape: sectionShape,
          child: ListTile(
            leading: Icon(
              notificationsEnabled ? Icons.check_circle : Icons.warning_amber,
              size: 32,
              color: notificationsEnabled
                  ? Colors.lightGreen
                  : Colors.redAccent,
            ),
            title: Text(l10n.settingsNotifPermTitle),
            subtitle: Text(
              _isChecking
                  ? l10n.settingsChecking
                  : notificationsEnabled
                  ? l10n.settingsNotifActive
                  : l10n.settingsNotifMissing,
            ),
            trailing: TextButton(
              onPressed: _requestPermission,
              child: Text(l10n.settingsVerify),
            ),
          ),
        ),
        // Exact-alarm scheduling (AlarmManager's SCHEDULE_EXACT_ALARM) is
        // an Android-only concept — iOS has no equivalent permission, so
        // this card would be meaningless clutter there.
        if (defaultTargetPlatform == TargetPlatform.android) ...<Widget>[
          const SizedBox(height: 8),
          Card.filled(
            shape: sectionShape,
            child: ListTile(
              leading: Icon(
                exactAlarmsAllowed ? Icons.check_circle : Icons.warning_amber,
                size: 32,
                color: exactAlarmsAllowed
                    ? Colors.lightGreen
                    : Colors.redAccent,
              ),
              title: Text(l10n.settingsExactAlarms),
              subtitle: Text(
                _isChecking
                    ? l10n.settingsChecking
                    : exactAlarmsAllowed
                    ? l10n.settingsExactAlarmsOn
                    : l10n.settingsExactAlarmsOff,
              ),
              trailing: TextButton(
                onPressed: _requestExactAlarms,
                child: Text(l10n.settingsAllow),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
