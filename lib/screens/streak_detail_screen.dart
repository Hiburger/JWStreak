import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/responsive_body.dart';

/// Detail view behind the home screen's streak stat tile: the streak itself,
/// the activity calendar, and a reminder of how matches work.
///
/// The calendar lives here rather than on the home screen — it was the
/// densest block on a screen that is otherwise a set of actions, and putting
/// it behind the number it explains keeps home focused on "what do I do now".
class StreakDetailScreen extends StatelessWidget {
  const StreakDetailScreen({
    required this.streak,
    required this.freezes,
    required this.recentReadingDays,
    required this.frozenDays,
    required this.lastReadAt,
    super.key,
  });

  final int streak;
  final int freezes;
  final List<DateTime> recentReadingDays;
  final Set<String> frozenDays;
  final DateTime? lastReadAt;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.tourStreakTitle),
      ),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: <Widget>[
            _StreakHero(streak: streak, freezes: freezes),
            const SizedBox(height: 20),
            _ReadingCalendar(
              readDays: recentReadingDays,
              frozenDays: frozenDays,
            ),
            if (lastReadAt != null) ...<Widget>[
              const SizedBox(height: 12),
              Text(
                l10n.homeLastReadAt(
                  DateFormat('dd/MM/yyyy HH:mm').format(lastReadAt!),
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 24),
            Text(
              l10n.streakInfoTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),
            _RuleRow(
              icon: Icons.local_fire_department_rounded,
              title: l10n.streakInfoRow1Title,
              text: l10n.streakInfoRow1Text,
            ),
            _RuleRow(
              icon: Icons.ac_unit_rounded,
              title: l10n.streakInfoRow2Title,
              text: l10n.streakInfoRow2Text,
            ),
            _RuleRow(
              icon: Icons.quiz_outlined,
              title: l10n.streakInfoRow3Title,
              text: l10n.streakInfoRow3Text,
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakHero extends StatelessWidget {
  const _StreakHero({required this.streak, required this.freezes});

  final int streak;
  final int freezes;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    // Same flame/frozen split as the home screen's hero badge and stat tile:
    // a streak of zero reads as frozen rather than "still on fire at 0".
    final bool alive = streak > 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cs.primaryContainer, cs.tertiaryContainer],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          Icon(
            alive ? Icons.local_fire_department_rounded : Icons.ac_unit_rounded,
            size: 48,
            color: alive ? cs.tertiary : Colors.lightBlue,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  alive
                      ? l10n.homeStreakDayCount(streak)
                      : l10n.homeStreakStartToday,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  freezes > 0
                      ? l10n.homeFreezesRemaining(freezes)
                      : l10n.homeFreezesNone,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.icon, required this.title, required this.text});

  final IconData icon;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: cs.onSecondaryContainer, size: 20),
          ),
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
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// How many weeks back the calendar can page — matches how much history the
/// caller actually loads (`getRecentReadingDays(limit: 42)`), so the arrow
/// never lands on a week that would render as a false "nothing read" blank.
const int _kCalendarWeeksLoaded = 6;

class _ReadingCalendar extends StatefulWidget {
  const _ReadingCalendar({required this.readDays, required this.frozenDays});

  final List<DateTime> readDays;
  final Set<String> frozenDays;

  @override
  State<_ReadingCalendar> createState() => _ReadingCalendarState();
}

class _ReadingCalendarState extends State<_ReadingCalendar> {
  // 0 = the current week; each step back moves a whole Monday-first week.
  int _weekOffset = 0;

  static List<String> _weekdayLabels(AppLocalizations l10n) => <String>[
    l10n.homeWeekdayMon,
    l10n.homeWeekdayTue,
    l10n.homeWeekdayWed,
    l10n.homeWeekdayThu,
    l10n.homeWeekdayFri,
    l10n.homeWeekdaySat,
    l10n.homeWeekdaySun,
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final Set<String> readDaySet = widget.readDays
        .map((DateTime day) => DateFormat('yyyy-MM-dd').format(day))
        .toSet();

    // Monday of the current week, then walk back _weekOffset whole weeks —
    // one row of 7 days at a time, Duolingo-style, rather than a multi-week
    // grid.
    final DateTime currentWeekStart = today.subtract(
      Duration(days: today.weekday - 1),
    );
    final DateTime weekStart = currentWeekStart.subtract(
      Duration(days: _weekOffset * 7),
    );
    final int activeCount = readDaySet.length;
    final bool canGoOlder = _weekOffset < _kCalendarWeeksLoaded - 1;
    final bool canGoNewer = _weekOffset > 0;

    // A day "kept the streak" whether it was read or covered by a match —
    // both keep the run going, so both join up into the same track.
    bool kept(DateTime day) =>
        readDaySet.contains(_key(day)) || widget.frozenDays.contains(_key(day));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              l10n.homeRecentActivity,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Text(
              activeCount != 1
                  ? l10n.homeActiveDaysPlural(activeCount)
                  : l10n.homeActiveDaysSingular(activeCount),
              style: theme.textTheme.labelMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: canGoOlder
                  ? () => setState(() => _weekOffset += 1)
                  : null,
              icon: const Icon(Icons.chevron_left_rounded),
              tooltip: l10n.homeCalendarPreviousWeek,
              visualDensity: VisualDensity.compact,
            ),
            Expanded(
              child: Center(
                // Labelled by the week's Monday — simplest single answer for
                // a week that can span two months.
                child: Text(
                  DateFormat.yMMMM(
                    Localizations.localeOf(context).toString(),
                  ).format(weekStart),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: canGoNewer
                  ? () => setState(() => _weekOffset -= 1)
                  : null,
              icon: const Icon(Icons.chevron_right_rounded),
              tooltip: l10n.homeCalendarNextWeek,
              visualDensity: VisualDensity.compact,
            ),
          ],
        ),
        Row(
          children: _weekdayLabels(l10n)
              .map(
                (String label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.75),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 4),
        Padding(
          // Vertical only: the cells have to stay flush horizontally or the
          // track joining consecutive days would be broken by gaps.
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: <Widget>[
              for (int d = 0; d < 7; d++)
                () {
                  final DateTime day = weekStart.add(Duration(days: d));
                  final bool isKept = kept(day);
                  return Expanded(
                    child: _DayCell(
                      day: day,
                      today: today,
                      done: readDaySet.contains(_key(day)),
                      frozen: widget.frozenDays.contains(_key(day)),
                      joinLeft:
                          d > 0 &&
                          isKept &&
                          kept(day.subtract(const Duration(days: 1))),
                      joinRight:
                          d < 6 &&
                          isKept &&
                          kept(day.add(const Duration(days: 1))),
                    ),
                  );
                }(),
            ],
          ),
        ),
      ],
    );
  }
}

String _key(DateTime day) => DateFormat('yyyy-MM-dd').format(day);

/// One day in the calendar, drawn as a bead on a track rather than a cell in
/// a grid: consecutive kept days are joined by a bar so a run reads as one
/// continuous streak, and days that were missed carry no chrome at all so the
/// eye only picks up the streak itself.
class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.today,
    required this.done,
    required this.frozen,
    required this.joinLeft,
    required this.joinRight,
  });

  final DateTime day;
  final DateTime today;
  final bool done;
  final bool frozen;
  final bool joinLeft;
  final bool joinRight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final bool isFuture = day.isAfter(today);
    final bool isToday = day == today;
    // A day can be both read and covered by a match; showing it as read wins.
    final bool isFrozenOnly = frozen && !done;

    final Color track = cs.primary.withValues(alpha: 0.30);

    Color? fill;
    Color fg;
    Border? ring;
    if (done) {
      fill = cs.primary;
      fg = cs.onPrimary;
    } else if (isFrozenOnly) {
      fill = Colors.lightBlue.withValues(alpha: 0.85);
      fg = Colors.white;
    } else if (isFuture) {
      fg = cs.onSurfaceVariant.withValues(alpha: 0.35);
    } else {
      fg = cs.onSurfaceVariant.withValues(alpha: 0.7);
    }
    if (isToday && !done && !isFrozenOnly) {
      ring = Border.all(color: cs.primary, width: 2);
    }

    return AspectRatio(
      aspectRatio: 1,
      child: Stack(
        children: <Widget>[
          // The joining track sits behind the bead and runs edge to edge, so
          // neighbouring cells meet with no seam.
          Positioned.fill(
            child: FractionallySizedBox(
              heightFactor: 0.42,
              child: Row(
                // Without stretch these halves collapse to nothing: a Row
                // hands its children loose cross-axis constraints, and a
                // childless ColoredBox takes the smallest size it is allowed
                // — which is zero height, so the track never shows up.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: ColoredBox(
                      color: joinLeft ? track : Colors.transparent,
                    ),
                  ),
                  Expanded(
                    child: ColoredBox(
                      color: joinRight ? track : Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: FractionallySizedBox(
              widthFactor: 0.74,
              heightFactor: 0.74,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: fill,
                  shape: BoxShape.circle,
                  border: ring,
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Text(
                      '${day.day}',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: fg,
                        fontWeight: done || isFrozenOnly || isToday
                            ? FontWeight.w800
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
