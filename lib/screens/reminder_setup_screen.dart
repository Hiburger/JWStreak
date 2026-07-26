import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../widgets/message_dialog.dart';
import '../widgets/reminder_picker.dart';

/// Manage daily reading reminders. The user can keep several reminders at
/// different times; each one fires a local Android notification every day.
class ReminderSetupScreen extends StatefulWidget {
  const ReminderSetupScreen({required this.dbService, super.key});

  final LocalDbService dbService;

  @override
  State<ReminderSetupScreen> createState() => _ReminderSetupScreenState();
}

class _ReminderSetupScreenState extends State<ReminderSetupScreen> {
  final NotificationService _notifications = NotificationService();

  static const int _maxReminders = 5;

  TimeOfDay _picked = const TimeOfDay(hour: 8, minute: 0);
  List<Reminder> _reminders = const <Reminder>[];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
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

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _picked,
    );
    if (picked != null) {
      setState(() => _picked = picked);
    }
  }

  bool _alreadyExists(int hour, int minute) => _reminders.any(
    (Reminder r) => r.hour == hour && r.minute == minute,
  );

  Future<void> _addReminder() async {
    if (_reminders.length >= _maxReminders) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (_alreadyExists(_picked.hour, _picked.minute)) {
      showMessageDialog(context, message: l10n.reminderAlreadyExists);
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
    await _load();
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
      appBar: AppBar(title: Text(l10n.reminderTitle)),
      body: _isLoading
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
                  picked: _picked,
                  onPick: (ReminderTimePreset p) => setState(
                    () => _picked = TimeOfDay(hour: p.hour, minute: p.minute),
                  ),
                ),
                const SizedBox(height: 16),
                if (_reminders.length >= _maxReminders)
                  ReminderLimitNote(max: _maxReminders)
                else
                  FilledButton.icon(
                    onPressed: _addReminder,
                    icon: const Icon(Icons.add_alarm_rounded, size: 22),
                    label: Text(
                      l10n.reminderAddButton,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
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
              ],
            ),
    );
  }
}
