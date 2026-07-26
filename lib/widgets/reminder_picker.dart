import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';

/// A suggested reminder time (label + icon + hour/minute), used for the quick
/// preset chips.
class ReminderTimePreset {
  const ReminderTimePreset({
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

/// The three default suggestions (morning / noon / evening), shared by the
/// settings reminder screen and the onboarding reminder page.
List<ReminderTimePreset> reminderPresets(AppLocalizations l10n) =>
    <ReminderTimePreset>[
      ReminderTimePreset(
        label: l10n.reminderPresetMorning,
        icon: Icons.wb_twilight_rounded,
        hour: 8,
        minute: 0,
      ),
      ReminderTimePreset(
        label: l10n.reminderPresetNoon,
        icon: Icons.wb_sunny_rounded,
        hour: 12,
        minute: 30,
      ),
      ReminderTimePreset(
        label: l10n.reminderPresetEvening,
        icon: Icons.nightlight_round,
        hour: 20,
        minute: 0,
      ),
    ];

/// Big gradient card showing the currently picked time with a button to open
/// the system time picker.
class ReminderTimeHero extends StatelessWidget {
  const ReminderTimeHero({required this.time, required this.onTap, super.key});

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
            style: TextStyle(
              fontFamily: 'PlusJakartaSans',
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

/// A single tappable preset chip (morning / noon / evening).
class ReminderPresetChip extends StatelessWidget {
  const ReminderPresetChip({
    required this.preset,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final ReminderTimePreset preset;
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

/// A row of the three preset chips, wired to update the picked time.
class ReminderPresetRow extends StatelessWidget {
  const ReminderPresetRow({
    required this.presets,
    required this.picked,
    required this.onPick,
    super.key,
  });

  final List<ReminderTimePreset> presets;
  final TimeOfDay picked;
  final ValueChanged<ReminderTimePreset> onPick;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < presets.length; i++) ...<Widget>[
          Expanded(
            child: ReminderPresetChip(
              preset: presets[i],
              selected: picked.hour == presets[i].hour &&
                  picked.minute == presets[i].minute,
              onTap: () => onPick(presets[i]),
            ),
          ),
          if (i != presets.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

/// A saved reminder row with a delete button.
class ReminderRow extends StatelessWidget {
  const ReminderRow({
    required this.reminder,
    required this.onDelete,
    super.key,
  });

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

/// Empty-state card shown when no reminders are saved yet.
class ReminderEmptyState extends StatelessWidget {
  const ReminderEmptyState({super.key});

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

/// Note shown when the maximum number of reminders has been reached.
class ReminderLimitNote extends StatelessWidget {
  const ReminderLimitNote({required this.max, super.key});

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

/// Section header used above the preset and saved-reminder lists.
class ReminderSectionHeader extends StatelessWidget {
  const ReminderSectionHeader({required this.title, super.key});

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
