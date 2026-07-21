import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';

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

  List<_TimePreset> _presets(AppLocalizations l10n) => <_TimePreset>[
    _TimePreset(label: l10n.reminderPresetMorning, icon: Icons.wb_twilight_rounded, hour: 8, minute: 0),
    _TimePreset(label: l10n.reminderPresetNoon, icon: Icons.wb_sunny_rounded, hour: 12, minute: 30),
    _TimePreset(label: l10n.reminderPresetEvening, icon: Icons.nightlight_round, hour: 20, minute: 0),
  ];

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderAlreadyExists)),
      );
      return;
    }
    final Reminder added = await widget.dbService.addReminder(
      hour: _picked.hour,
      minute: _picked.minute,
    );
    await _notifications.scheduleReminder(id: added.id, time: _picked);
    await _load();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.reminderAdded(added.label))),
      );
    }
  }

  Future<void> _deleteReminder(Reminder reminder) async {
    await widget.dbService.deleteReminder(reminder.id);
    await _notifications.cancelReminder(reminder.id);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<_TimePreset> presets = _presets(l10n);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.reminderTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              children: <Widget>[
                _TimeHero(time: _picked, onTap: _pickTime),
                const SizedBox(height: 24),
                _SectionHeader(title: l10n.reminderSuggestions),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    for (int i = 0; i < presets.length; i++) ...<Widget>[
                      Expanded(
                        child: _PresetChip(
                          preset: presets[i],
                          selected: _picked.hour == presets[i].hour &&
                              _picked.minute == presets[i].minute,
                          onTap: () => setState(
                            () => _picked = TimeOfDay(
                              hour: presets[i].hour,
                              minute: presets[i].minute,
                            ),
                          ),
                        ),
                      ),
                      if (i != presets.length - 1) const SizedBox(width: 10),
                    ],
                  ],
                ),
                const SizedBox(height: 16),
                if (_reminders.length >= _maxReminders)
                  _LimitNote(max: _maxReminders)
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
                _SectionHeader(title: l10n.reminderMine),
                const SizedBox(height: 12),
                if (_reminders.isEmpty)
                  _EmptyReminders()
                else
                  ..._reminders.map(
                    (Reminder r) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _ReminderRow(
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

class _EmptyReminders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.notifications_off_outlined,
            size: 44,
            color: cs.onSurfaceVariant,
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalizations.of(context)!.reminderEmpty,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _LimitNote extends StatelessWidget {
  const _LimitNote({required this.max});

  final int max;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.info_outline_rounded, color: cs.onTertiaryContainer),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.reminderLimitReached(max),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onTertiaryContainer,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({required this.reminder, required this.onDelete});

  final Reminder reminder;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Material(
      color: cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.notifications_active_outlined,
                color: cs.onPrimaryContainer,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                reminder.label,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              tooltip: AppLocalizations.of(context)!.reminderDeleteTooltip,
              icon: Icon(Icons.delete_outline, color: cs.error),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

class _TimePreset {
  const _TimePreset({
    required this.label,
    required this.icon,
    required this.hour,
    required this.minute,
  });

  final String label;
  final IconData icon;
  final int hour;
  final int minute;
}

class _TimeHero extends StatelessWidget {
  const _TimeHero({required this.time, required this.onTap});

  final TimeOfDay time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cs.primaryContainer, cs.tertiaryContainer],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.schedule_rounded,
                color: cs.onPrimaryContainer.withValues(alpha: 0.85),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.reminderNewTime,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: cs.onPrimaryContainer.withValues(alpha: 0.85),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            time.format(context),
            style: GoogleFonts.plusJakartaSans(
              fontSize: 56,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
              color: cs.onPrimaryContainer,
              height: 1,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onTap,
              icon: const Icon(Icons.edit_rounded, size: 22),
              label: Text(
                AppLocalizations.of(context)!.reminderEditTime,
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                backgroundColor: cs.onPrimaryContainer,
                foregroundColor: cs.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
    required this.preset,
    required this.selected,
    required this.onTap,
  });

  final _TimePreset preset;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final Color bg = selected ? cs.secondaryContainer : cs.surfaceContainerHigh;
    final Color fg = selected ? cs.onSecondaryContainer : cs.onSurfaceVariant;
    return Material(
      color: bg,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: selected ? cs.secondary : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Column(
            children: <Widget>[
              Icon(preset.icon, color: fg, size: 22),
              const SizedBox(height: 6),
              Text(
                preset.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: fg,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${preset.hour.toString().padLeft(2, '0')}:'
                '${preset.minute.toString().padLeft(2, '0')}',
                style: theme.textTheme.bodySmall?.copyWith(color: fg),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}
