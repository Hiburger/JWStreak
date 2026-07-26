import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../widgets/message_dialog.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/onboarding_progress.dart';
import '../widgets/reminder_picker.dart';

/// Final onboarding page: helps the user set up their first daily reminder(s)
/// right away. Reuses the reminder picker widgets from the settings screen, but
/// wraps them with onboarding-specific guidance and a finish/skip flow.
class ReminderOnboardingScreen extends StatefulWidget {
  const ReminderOnboardingScreen({
    required this.dbService,
    required this.onDone,
    required this.onBack,
    required this.stepCount,
    required this.stepIndex,
    this.hideActionButton = false,
    super.key,
  });

  final LocalDbService dbService;
  final Future<void> Function() onDone;
  final VoidCallback onBack;
  final int stepCount;
  final int stepIndex;

  /// True while the user is manually dragging the onboarding PageView — the
  /// button fades out so it doesn't compete with the swipe gesture.
  final bool hideActionButton;

  @override
  State<ReminderOnboardingScreen> createState() =>
      _ReminderOnboardingScreenState();
}

class _ReminderOnboardingScreenState extends State<ReminderOnboardingScreen>
    with WidgetsBindingObserver {
  final NotificationService _notifications = NotificationService();

  static const int _maxReminders = 5;

  TimeOfDay _picked = const TimeOfDay(hour: 8, minute: 0);
  List<Reminder> _reminders = const <Reminder>[];
  bool _isLoading = true;
  bool _notificationsReady = false;
  // null = not checked yet (no reminder added this session). false = the user
  // declined the OS permission prompt, so the reminder they just saved won't
  // actually ring.
  bool? _notificationsEnabled;
  // Set right before sending the user to the system settings screen, so we
  // know to re-check permission status once they come back to the app.
  bool _awaitingSettingsReturn = false;

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
    final bool enabled = await _notifications.areNotificationsEnabled();
    if (mounted) {
      setState(() => _notificationsEnabled = enabled);
    }
  }

  Future<void> _load() async {
    final List<Reminder> reminders = await widget.dbService.getReminders();
    if (mounted) {
      setState(() {
        _reminders = reminders;
        _isLoading = false;
      });
    }
  }

  /// Initializes notifications the first time the user adds a reminder — this
  /// is also what triggers the Android notification-permission prompt, at the
  /// moment it makes sense (they just chose to be reminded).
  Future<void> _ensureNotificationsReady() async {
    if (_notificationsReady) {
      return;
    }
    await _notifications.initialize(onTap: (_) async {}, onError: (_, _) {});
    _notificationsReady = true;
  }

  bool _alreadyExists(int hour, int minute) =>
      _reminders.any((Reminder r) => r.hour == hour && r.minute == minute);

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _picked,
    );
    if (picked != null) {
      setState(() => _picked = picked);
    }
  }

  Future<void> _addReminder() async {
    if (_reminders.length >= _maxReminders) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (_alreadyExists(_picked.hour, _picked.minute)) {
      showMessageDialog(context, message: l10n.reminderAlreadyExists);
      return;
    }
    await _ensureNotificationsReady();
    // The permission prompt (if any) already happened inside
    // _ensureNotificationsReady; without it, a saved reminder would just sit
    // there and never actually ring, so don't persist it — show the warning
    // (with a way to grant the permission) instead.
    final bool enabled = await _notifications.areNotificationsEnabled();
    if (!mounted) {
      return;
    }
    if (!enabled) {
      setState(() => _notificationsEnabled = false);
      return;
    }
    final Reminder added = await widget.dbService.addReminder(
      hour: _picked.hour,
      minute: _picked.minute,
    );
    await _notifications.scheduleReminder(
      id: added.id,
      time: _picked,
      title: l10n.notifReminderTitle,
      body: l10n.notifReminderBody,
    );
    if (mounted) {
      setState(() => _notificationsEnabled = true);
    }
    await _load();
  }

  /// Android only shows its own permission dialog once per install; by the
  /// time this warning is visible, that one-shot prompt has already been
  /// shown and declined, so calling requestNotificationPermission again
  /// silently does nothing. The only way left to grant it is the system
  /// settings screen — send the user there and re-check when they come back.
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

  Future<void> _deleteReminder(Reminder reminder) async {
    await widget.dbService.deleteReminder(reminder.id);
    await _notifications.cancelReminder(reminder.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<ReminderTimePreset> presets = reminderPresets(l10n);
    final bool hasReminders = _reminders.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: IconButton(
                      onPressed: widget.onBack,
                      icon: const Icon(Icons.arrow_back_rounded),
                      tooltip: l10n.onbBack,
                    ),
                  ),
                  Expanded(
                    child: LayoutBuilder(
                      builder:
                          (BuildContext context, BoxConstraints constraints) {
                            return SingleChildScrollView(
                              physics: const ClampingScrollPhysics(),
                              padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: constraints.maxHeight - 20,
                                ),
                                child: Column(
                                  mainAxisAlignment: hasReminders
                                      ? MainAxisAlignment.start
                                      : MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      l10n.onbReminderTitle,
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                            fontWeight: FontWeight.w800,
                                          ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      l10n.onbReminderIntro,
                                      style: theme.textTheme.bodyLarge
                                          ?.copyWith(
                                            color: cs.onSurfaceVariant,
                                            height: 1.35,
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    _TipCard(text: l10n.onbReminderTip),
                                    const SizedBox(height: 20),
                                    ReminderTimeHero(
                                      time: _picked,
                                      onTap: _pickTime,
                                    ),
                                    const SizedBox(height: 20),
                                    ReminderSectionHeader(
                                      title: l10n.reminderSuggestions,
                                    ),
                                    const SizedBox(height: 12),
                                    ReminderPresetRow(
                                      presets: presets,
                                      picked: _picked,
                                      onPick: (ReminderTimePreset p) =>
                                          setState(
                                            () => _picked = TimeOfDay(
                                              hour: p.hour,
                                              minute: p.minute,
                                            ),
                                          ),
                                    ),
                                    const SizedBox(height: 16),
                                    if (_reminders.length >= _maxReminders)
                                      ReminderLimitNote(max: _maxReminders)
                                    else
                                      FilledButton.icon(
                                        onPressed: _addReminder,
                                        icon: const Icon(
                                          Icons.add_alarm_rounded,
                                          size: 22,
                                        ),
                                        label: Text(
                                          l10n.reminderAddButton,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        style: FilledButton.styleFrom(
                                          minimumSize: const Size.fromHeight(
                                            56,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (_notificationsEnabled ==
                                        false) ...<Widget>[
                                      const SizedBox(height: 16),
                                      _NotificationPermissionWarning(
                                        onEnable:
                                            _requestNotificationPermission,
                                      ),
                                    ],
                                    if (hasReminders) ...<Widget>[
                                      const SizedBox(height: 28),
                                      ReminderSectionHeader(
                                        title: l10n.reminderMine,
                                      ),
                                      const SizedBox(height: 12),
                                      ..._reminders.map(
                                        (Reminder r) => Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          child: ReminderRow(
                                            reminder: r,
                                            onDelete: () => _deleteReminder(r),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
                    child: Column(
                      children: <Widget>[
                        OnboardingProgress(
                          count: widget.stepCount,
                          index: widget.stepIndex,
                        ),
                        const SizedBox(height: 16),
                        AnimatedOpacity(
                          opacity: widget.hideActionButton ? 0 : 1,
                          duration: const Duration(milliseconds: 150),
                          child: IgnorePointer(
                            ignoring: widget.hideActionButton,
                            child: SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: widget.onDone,
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                                child: Text(
                                  hasReminders
                                      ? l10n.onbReminderFinish
                                      : l10n.onbReminderSkip,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

/// Warns that a just-saved reminder won't actually ring because the user
/// declined (or the OS otherwise blocked) the notification permission
/// prompt, with a button to ask for it again.
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
              style: theme.textTheme.bodyMedium?.copyWith(
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

class _TipCard extends StatelessWidget {
  const _TipCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kAccentAmber.background(context),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.lightbulb_outline_rounded,
            color: kAccentAmber.foreground(context),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: kAccentAmber.foreground(context),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
