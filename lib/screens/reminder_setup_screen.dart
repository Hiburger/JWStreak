import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/message_dialog.dart';
import '../widgets/reminder_picker.dart';
import '../widgets/time_wheel_picker.dart';
import '../widgets/responsive_body.dart';

/// Manage daily reading reminders. The user can keep several reminders at
/// different times; each one fires a local Android notification every day.
class ReminderSetupScreen extends StatefulWidget {
  const ReminderSetupScreen({required this.dbService, super.key});

  final LocalDbService dbService;

  @override
  State<ReminderSetupScreen> createState() => _ReminderSetupScreenState();
}

class _ReminderSetupScreenState extends State<ReminderSetupScreen>
    with WidgetsBindingObserver {
  final NotificationService _notifications = NotificationService();

  static const int _maxReminders = 5;

  TimeOfDay _picked = const TimeOfDay(hour: 8, minute: 0);
  List<Reminder> _reminders = const <Reminder>[];
  bool _isLoading = true;
  bool _notificationsReady = false;

  // A reminder added while this is false would never actually ring, so
  // _addReminder refuses to persist it instead — same rule the onboarding
  // screen already applies to a first-ever reminder.
  bool _notificationsEnabled = true;

  // Android 12+ can silently deny exact-timing for scheduled alarms; without
  // surfacing that here, a reminder added on this screen looks identical
  // whether it'll actually fire on time or drift by however long Doze feels
  // like that day.
  bool _exactAlarmsAllowed = true;

  // Set right before sending the user to a system settings screen, so we
  // know to re-check permission status once they come back to the app.
  bool _awaitingSettingsReturn = false;

  // The daily-text reminder: a single optional extra, kept separate from the
  // book-reading reminders list above since it points at jw.org rather than
  // a chapter.
  bool _dailyTextEnabled = false;
  TimeOfDay _dailyTextTime = const TimeOfDay(hour: 8, minute: 0);

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

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state != AppLifecycleState.resumed || !_awaitingSettingsReturn) {
      return;
    }
    _awaitingSettingsReturn = false;
    final bool notificationsEnabled = await _notifications
        .areNotificationsEnabled();
    final bool exactAlarmsAllowed = await _notifications
        .canScheduleExactAlarms();
    if (mounted) {
      setState(() {
        _notificationsEnabled = notificationsEnabled;
        _exactAlarmsAllowed = exactAlarmsAllowed;
      });
    }
  }

  Future<void> _load() async {
    final List<Reminder> reminders = await widget.dbService.getReminders();
    final DailyTextReminderSettings dailyText = await widget.dbService
        .getDailyTextReminder();
    final bool notificationsEnabled = await _notifications
        .areNotificationsEnabled();
    final bool exactAlarmsAllowed = await _notifications
        .canScheduleExactAlarms();
    if (mounted) {
      setState(() {
        _reminders = reminders;
        _dailyTextEnabled = dailyText.enabled;
        _dailyTextTime = TimeOfDay(
          hour: dailyText.hour,
          minute: dailyText.minute,
        );
        _notificationsEnabled = notificationsEnabled;
        _exactAlarmsAllowed = exactAlarmsAllowed;
        _isLoading = false;
      });
    }
  }

  /// Initializes notifications the first time this screen tries to schedule
  /// one — also what triggers the Android notification-permission prompt, on
  /// a device that never went through the onboarding reminder step.
  Future<void> _ensureNotificationsReady() async {
    if (_notificationsReady) {
      return;
    }
    await _notifications.initialize(onTap: (_) async {}, onError: (_, _) {});
    _notificationsReady = true;
  }

  /// Android only shows its own permission dialog once per install; past
  /// that point granting it requires the system settings screen.
  Future<void> _requestNotificationPermission() async {
    final bool granted = await _notifications.requestNotificationPermission();
    if (!mounted) {
      return;
    }
    if (granted) {
      setState(() => _notificationsEnabled = true);
      return;
    }
    _awaitingSettingsReturn = true;
    await _notifications.openNotificationSettings();
  }

  Future<void> _requestExactAlarms() async {
    _awaitingSettingsReturn = true;
    final bool granted = await _notifications.requestExactAlarmPermission();
    if (mounted) {
      setState(() => _exactAlarmsAllowed = granted);
    }
  }

  Future<void> _saveDailyTextReminder() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    await widget.dbService.saveDailyTextReminder(
      enabled: _dailyTextEnabled,
      hour: _dailyTextTime.hour,
      minute: _dailyTextTime.minute,
    );
    if (!_dailyTextEnabled) {
      await _notifications.cancelDailyTextReminder();
      return;
    }
    await _notifications.scheduleDailyTextReminder(
      time: _dailyTextTime,
      title: l10n.notifDailyTextTitle,
      body: l10n.notifDailyTextBody,
    );
  }

  Future<void> _toggleDailyText(bool value) async {
    setState(() => _dailyTextEnabled = value);
    await _saveDailyTextReminder();
  }

  Future<void> _pickDailyTextTime() async {
    final TimeOfDay? picked = await showTimeWheelPicker(
      context: context,
      initialTime: _dailyTextTime,
      title: AppLocalizations.of(context)!.reminderEditTime,
    );
    if (picked == null) {
      return;
    }
    setState(() => _dailyTextTime = picked);
    await _saveDailyTextReminder();
  }

  Future<void> _pickTime() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    // At the limit nothing can be added, so don't promise it: the button
    // falls back to "OK" and the picker just edits the shown time.
    final bool canAdd = _reminders.length < _maxReminders;
    final TimeOfDay? picked = await showTimeWheelPicker(
      context: context,
      initialTime: _picked,
      title: l10n.reminderEditTime,
      confirmLabel: canAdd ? l10n.reminderAddButton : null,
    );
    if (picked == null || !mounted) {
      return;
    }
    setState(() => _picked = picked);
    // Confirming the sheet is the reader saying "this one" — going back to
    // the page to press a second button was a step that did nothing except
    // repeat the decision they had just made.
    if (canAdd) {
      await _addReminder(picked);
    }
  }

  /// Turns a suggested time on, or off again if it is already set.
  ///
  /// The whole interaction now: no staging step, and the chip's highlight is
  /// the state itself, so what shows as on is exactly what will ring.
  Future<void> _togglePreset(ReminderTimePreset preset) async {
    for (final Reminder r in _reminders) {
      if (r.hour == preset.hour && r.minute == preset.minute) {
        await _deleteReminder(r);
        return;
      }
    }
    await _addReminder(TimeOfDay(hour: preset.hour, minute: preset.minute));
  }

  bool _alreadyExists(int hour, int minute) =>
      _reminders.any((Reminder r) => r.hour == hour && r.minute == minute);

  Future<void> _addReminder(TimeOfDay time) async {
    if (_reminders.length >= _maxReminders) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (_alreadyExists(time.hour, time.minute)) {
      showMessageDialog(context, message: l10n.reminderAlreadyExists);
      return;
    }
    try {
      await _ensureNotificationsReady();
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
      return;
    }
    // Without this, a reminder that can never ring would still get saved and
    // look identical to one that will — check right before persisting rather
    // than trusting whatever _notificationsEnabled last held, since it can go
    // stale between an initial _load() and this tap.
    final bool enabled = await _notifications.areNotificationsEnabled();
    if (!mounted) {
      return;
    }
    if (!enabled) {
      setState(() => _notificationsEnabled = false);
      return;
    }
    final Reminder added = await widget.dbService.addReminder(
      hour: time.hour,
      minute: time.minute,
    );
    await _notifications.scheduleReminder(
      id: added.id,
      time: time,
      title: l10n.notifReminderTitle,
      body: l10n.notifReminderBody,
    );
    if (mounted) {
      setState(() => _notificationsEnabled = true);
    }
    await _load();
  }

  void _showError(Object error) {
    showMessageDialog(
      context,
      message: AppLocalizations.of(context)!.settingsError(error.toString()),
      isError: true,
    );
  }

  Future<void> _deleteReminder(Reminder reminder) async {
    await widget.dbService.deleteReminder(reminder.id);
    await _notifications.cancelReminder(reminder.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<ReminderTimePreset> presets = reminderPresets(l10n);
    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.reminderTitle),
      ),
      body: ResponsiveBody(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                children: <Widget>[
                  ReminderTimeHero(time: _picked, onTap: _pickTime),
                  const SizedBox(height: 24),
                  ReminderSectionHeader(title: l10n.reminderSuggestions),
                  const SizedBox(height: 12),
                  ReminderPresetRow(
                    presets: presets,
                    isActive: (ReminderTimePreset p) =>
                        _alreadyExists(p.hour, p.minute),
                    canAdd: _reminders.length < _maxReminders,
                    onToggle: _togglePreset,
                  ),
                  if (!_notificationsEnabled) ...<Widget>[
                    const SizedBox(height: 16),
                    _NotificationPermissionWarning(
                      onEnable: _requestNotificationPermission,
                    ),
                  ],
                  if (_notificationsEnabled &&
                      !_exactAlarmsAllowed) ...<Widget>[
                    const SizedBox(height: 16),
                    _ExactAlarmWarning(onEnable: _requestExactAlarms),
                  ],
                  // No "add" button any more: a suggestion chip sets its own
                  // reminder and the picker commits the custom time, so the
                  // only thing left to say here is when nothing more fits.
                  if (_reminders.length >= _maxReminders) ...<Widget>[
                    const SizedBox(height: 16),
                    ReminderLimitNote(max: _maxReminders),
                  ],
                  const SizedBox(height: 28),
                  ReminderSectionHeader(title: l10n.reminderMine),
                  const SizedBox(height: 12),
                  if (_reminders.isEmpty)
                    const ReminderEmptyState()
                  else
                    ..._reminders.map(
                      (Reminder r) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: ReminderRow(
                          reminder: r,
                          onDelete: () => _deleteReminder(r),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  _DailyTextReminderTile(
                    enabled: _dailyTextEnabled,
                    time: _dailyTextTime,
                    onChanged: _toggleDailyText,
                    onPickTime: _pickDailyTextTime,
                  ),
                ],
              ),
      ),
    );
  }
}

/// Warns that a reminder can't actually ring because the notification
/// permission isn't granted — mirrors the onboarding screen's own warning
/// (same copy, same layout), since this screen can be reached long after
/// onboarding, e.g. from settings, without ever going through that check.
class _NotificationPermissionWarning extends StatelessWidget {
  const _NotificationPermissionWarning({required this.onEnable});

  final VoidCallback onEnable;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: cs.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.onbReminderPermissionMissing,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: cs.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onEnable,
            style: TextButton.styleFrom(foregroundColor: cs.onErrorContainer),
            child: Text(l10n.onbReminderPermissionEnable),
          ),
        ],
      ),
    );
  }
}

/// Warns that Android may delay reminders (Doze) because the exact-alarm
/// permission isn't granted — the same condition the home screen's one-time
/// startup dialog checks, surfaced here too since that dialog is easy to
/// dismiss with "Later" and never see again.
class _ExactAlarmWarning extends StatelessWidget {
  const _ExactAlarmWarning({required this.onEnable});

  final VoidCallback onEnable;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.warning_amber_rounded, color: cs.onErrorContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.settingsExactAlarmsOff,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: cs.onErrorContainer,
              ),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onEnable,
            style: TextButton.styleFrom(foregroundColor: cs.onErrorContainer),
            child: Text(l10n.homeExactAlarmDialogOpenSettings),
          ),
        ],
      ),
    );
  }
}

/// A single, deliberately quiet row — this is a nice-to-have next to the
/// book-reading reminders above, not a second feature competing for
/// attention. One switch, and a time picker that only appears once enabled.
class _DailyTextReminderTile extends StatelessWidget {
  const _DailyTextReminderTile({
    required this.enabled,
    required this.time,
    required this.onChanged,
    required this.onPickTime,
  });

  final bool enabled;
  final TimeOfDay time;
  final ValueChanged<bool> onChanged;
  final VoidCallback onPickTime;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: SwitchListTile(
        dense: true,
        // Tapping the time isn't part of the switch gesture, so it's a
        // small separate control shown only once the reminder is on.
        secondary: enabled
            ? TextButton(
                onPressed: onPickTime,
                child: Text(time.format(context)),
              )
            : Icon(Icons.auto_stories_outlined, color: cs.onSurfaceVariant),
        title: Text(
          l10n.reminderDailyTextTitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          l10n.reminderDailyTextSubtitle,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        value: enabled,
        onChanged: onChanged,
      ),
    );
  }
}
