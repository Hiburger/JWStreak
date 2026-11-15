import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/matchstick_icon.dart';
import '../widgets/message_dialog.dart';
import '../widgets/responsive_body.dart';
import 'break_log_screen.dart';

/// Detail view behind the home screen's streak stat tile

class StreakDetailScreen extends StatefulWidget {
  const StreakDetailScreen({
    required this.dbService,
    required this.streak,
    required this.freezes,
    required this.recentReadingDays,
    required this.frozenDays,
    super.key,
  });

  final LocalDbService dbService;
  final int streak;
  final int freezes;
  final List<DateTime> recentReadingDays;
  final Set<String> frozenDays;

  @override
  State<StreakDetailScreen> createState() => _StreakDetailScreenState();
}

class _StreakDetailScreenState extends State<StreakDetailScreen> {
  Break? _activeBreak;
  List<Break> _breaks = const <Break>[];
  Map<BreakTier, int> _usage = <BreakTier, int>{};
  bool _loadingBreaks = true;

  TextEditingController? _reasonController;

  @override
  void initState() {
    super.initState();
    _loadBreaks();
  }

  @override
  void dispose() {
    _reasonController?.dispose();
    super.dispose();
  }

  Future<void> _loadBreaks() async {
    final Break? active = await widget.dbService.getActiveBreak();
    final List<Break> all = await widget.dbService.getAllBreaks();
    final Map<BreakTier, int> usage = <BreakTier, int>{};
    for (final BreakTier tier in BreakTier.values) {
      usage[tier] = await widget.dbService.breakUsageThisYear(tier);
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _activeBreak = active;
      _breaks = all;
      _usage = usage;
      _loadingBreaks = false;
    });
  }

  /// Day keys covered by any break, clipped to the calendar's 6-week window.
  Set<String> get _breakDayKeys {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);
    final DateTime windowStart = DateTime(
      today.year,
      today.month,
      today.day - 42,
    );
    final Set<String> keys = <String>{};
    for (final Break b in _breaks) {
      final DateTime start = DateTime.parse(b.startDay);
      final DateTime end = DateTime.parse(b.endDay);
      for (
        DateTime d = start;
        !d.isAfter(end);
        d = DateTime(d.year, d.month, d.day + 1)
      ) {
        if (!d.isBefore(windowStart)) {
          keys.add(dayKeyOf(d));
        }
      }
    }
    return keys;
  }

  Future<void> _startBreak(BreakTier tier, {String reason = ''}) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (_activeBreak != null) {
      showMessageDialog(context, message: l10n.streakBreakWhileActive);
      return;
    }
    await widget.dbService.startBreak(tier, reason: reason);
    await _loadBreaks();
    // No confirmation toast: the active-break card appearing is the
    // confirmation, and a floating bar would clash with the screen.
  }

  Future<void> _cancelBreak() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool? ok = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: Text(l10n.streakBreakEndConfirmTitle),
        content: Text(l10n.streakBreakEndConfirmBody),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(l10n.notesLibraryCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(l10n.streakBreakEnd),
          ),
        ],
      ),
    );
    if (ok != true) {
      return;
    }
    await widget.dbService.cancelActiveBreak();
    await _loadBreaks();
  }

  Future<void> _pickBreakTier() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final DateTime? nextAllowed = await widget.dbService.nextBreakAllowedDay();
    if (!mounted) {
      return;
    }
    _reasonController ??= TextEditingController();
    final TextEditingController reasonController = _reasonController!;
    final BreakTier? picked = await showModalBottomSheet<BreakTier>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        final ThemeData theme = Theme.of(sheetContext);
        return SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 4),
                child: Text(
                  l10n.streakBreakSheetTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Text(
                  l10n.streakBreakSheetBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              if (nextAllowed != null)
                ListTile(
                  enabled: false,
                  leading: const Icon(Icons.timer_outlined),
                  title: Text(
                    l10n.streakBreakCooldown(
                      DateFormat('dd/MM/yyyy').format(nextAllowed),
                    ),
                  ),
                )
              else ...<Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                  child: TextField(
                    controller: reasonController,
                    maxLength: 80,
                    decoration: InputDecoration(
                      hintText: l10n.streakBreakReasonHint,
                      isDense: true,
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: BreakTier.values.length,
                    separatorBuilder: (_, _) => Divider(
                      height: 1,
                      color: theme.colorScheme.outlineVariant,
                    ),
                    itemBuilder: (BuildContext _, int index) {
                      final BreakTier tier = BreakTier.values[index];
                      final int left = tier.yearlyCap - (_usage[tier] ?? 0);
                      final String name = switch (tier) {
                        BreakTier.mini => l10n.streakBreakMini,
                        BreakTier.small => l10n.streakBreakSmall,
                        BreakTier.medium => l10n.streakBreakMedium,
                        BreakTier.big => l10n.streakBreakBig,
                      };
                      return ListTile(
                        enabled: left > 0,
                        title: Text(
                          '$name (${l10n.streakBreakTierDays(tier.durationDays)})',
                        ),
                        subtitle: Text(
                          left > 0
                              ? l10n.streakBreakLeft(left)
                              : l10n.streakBreakExhausted,
                        ),
                        trailing: left > 0
                            ? const Icon(Icons.chevron_right_rounded)
                            : null,
                        onTap: left > 0
                            ? () => Navigator.of(sheetContext).pop(tier)
                            : null,
                      );
                    },
                  ),
                ),
              ],
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
    final String reason = reasonController.text;
    reasonController.clear();
    if (picked != null) {
      await _startBreak(picked, reason: reason);
    }
  }

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

      // JWS UI Design Sys. applied to this screen too, following what has been done for the first page of onboarding
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              cs.surface,
              cs.primaryContainer.withValues(alpha: 0.35),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ResponsiveBody(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                    children: <Widget>[
                      if (!_loadingBreaks)
                        _StreakHero(
                          streak: widget.streak,
                          freezes: widget.freezes,
                          activeBreak: _activeBreak,
                          onEndBreak: _cancelBreak,
                        )
                      else
                        _StreakHero(
                          streak: widget.streak,
                          freezes: widget.freezes,
                        ),
                      const SizedBox(height: 12),
                      _ReadingCalendar(
                        readDays: widget.recentReadingDays,
                        frozenDays: widget.frozenDays,
                        breakDays: _breakDayKeys,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        l10n.streakInfoTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _RuleRow(
                        icon: const Icon(Icons.local_fire_department_rounded),
                        title: l10n.streakInfoRow1Title,
                        text: l10n.streakInfoRow1Text,
                      ),
                      _RuleRow(
                        icon: Builder(
                          builder: (BuildContext ctx) => MatchstickIcon(
                            size: 22,
                            color: Theme.of(
                              ctx,
                            ).colorScheme.onSecondaryContainer,
                          ),
                        ),
                        title: l10n.streakInfoRow2Title,
                        text: l10n.streakInfoRow2Text,
                      ),
                      _RuleRow(
                        icon: const Icon(Icons.quiz_outlined),
                        title: l10n.streakInfoRow3Title,
                        text: l10n.streakInfoRow3Text,
                      ),
                      _RuleRow(
                        icon: const Icon(Icons.pause_circle_outline_rounded),
                        title: l10n.streakInfoRow5Title,
                        text: l10n.streakInfoRow5Text,
                      ),
                      if (!_loadingBreaks) ...<Widget>[
                        if (_activeBreak == null)
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Center(
                              child: FilledButton.icon(
                                onPressed: _pickBreakTier,
                                style: FilledButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 32,
                                    vertical: 14,
                                  ),
                                  shape: const StadiumBorder(),
                                ),
                                icon: const Icon(
                                  Icons.pause_circle_outline_rounded,
                                  size: 20,
                                ),
                                label: Text(
                                  l10n.streakBreakTake,
                                  style: const TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        TextButton(
                          onPressed: () => Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (_) => BreakLogScreen(breaks: _breaks),
                            ),
                          ),
                          child: Text(l10n.streakBreakLogButton),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ],
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

const Color _kBreakPurple = Color(0xFFB57FE0);

class _StreakHero extends StatelessWidget {
  const _StreakHero({
    required this.streak,
    required this.freezes,
    this.activeBreak,
    this.onEndBreak,
  });

  final int streak;
  final int freezes;
  final Break? activeBreak;
  final VoidCallback? onEndBreak;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    // Same flame/frozen split as the home screen's hero badge and stat tile:
    // a streak of zero reads as frozen rather than "still on fire at 0".
    final bool alive = streak > 0;
    final Break? b = activeBreak;
    final bool onBreak = b != null;

    String subtitle;
    if (onBreak) {
      final DateTime end = DateTime.parse(b.endDay);
      final DateTime today = DateTime.now();
      // Inclusive of the running day, so a 1-day break taken this morning
      // reads "1 day left" (today) rather than a confusing 0.
      final int daysLeft =
          DateTime(
            end.year,
            end.month,
            end.day,
          ).difference(DateTime(today.year, today.month, today.day)).inDays +
          1;
      subtitle = l10n.streakBreakDaysLeft(daysLeft < 0 ? 0 : daysLeft);
    } else {
      subtitle = freezes > 0
          ? l10n.homeFreezesRemaining(freezes)
          : l10n.homeFreezesNone;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            cs.primaryContainer,
            onBreak ? _kBreakPurple : cs.tertiaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: <Widget>[
          if (!onBreak) ...<Widget>[
            Icon(
              alive
                  ? Icons.local_fire_department_rounded
                  : Icons.ac_unit_rounded,
              size: 48,
              color: alive ? cs.tertiary : Colors.lightBlue,
            ),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  alive
                      ? l10n.homeStreakDayCount(streak)
                      : onBreak
                      ? l10n.streakBreakActiveTitle
                      : l10n.homeStreakStartToday,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: cs.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onPrimaryContainer.withValues(alpha: 0.85),
                  ),
                ),
                if (onBreak && b.reason.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    b.reason,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: cs.onPrimaryContainer.withValues(alpha: 0.75),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onBreak)
            IconButton(
              tooltip: l10n.streakBreakEnd,
              onPressed: onEndBreak,
              style: IconButton.styleFrom(
                backgroundColor: cs.onPrimaryContainer.withValues(alpha: 0.12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(
                Icons.close_rounded,
                color: cs.onPrimaryContainer.withValues(alpha: 0.9),
              ),
            ),
        ],
      ),
    );
  }
}

class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.icon, required this.title, required this.text});

  final Widget icon;
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
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: cs.onSecondaryContainer, size: 20),
                child: icon,
              ),
            ),
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
  const _ReadingCalendar({
    required this.readDays,
    required this.frozenDays,
    required this.breakDays,
  });

  final List<DateTime> readDays;
  final Set<String> frozenDays;
  final Set<String> breakDays;

  @override
  State<_ReadingCalendar> createState() => _ReadingCalendarState();
}

class _ReadingCalendarState extends State<_ReadingCalendar> {
  // 0 = the two-week window ending on the current week; each step back moves
  // a whole 14-day window, matching the two-row view.
  int _page = 0;

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

    final DateTime currentWeekStart = today.subtract(
      Duration(days: today.weekday - 1),
    );
    final DateTime bottomRowStart = currentWeekStart.subtract(
      Duration(days: _page * 14),
    );
    final DateTime topRowStart = bottomRowStart.subtract(
      const Duration(days: 7),
    );
    final bool canGoOlder = _page * 14 + 14 < _kCalendarWeeksLoaded * 7;
    final bool canGoNewer = _page > 0;

    bool kept(DateTime day) =>
        readDaySet.contains(_key(day)) ||
        widget.frozenDays.contains(_key(day)) ||
        widget.breakDays.contains(_key(day));

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
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            IconButton(
              onPressed: canGoOlder ? () => setState(() => _page += 1) : null,
              icon: const Icon(Icons.chevron_left_rounded),
              tooltip: l10n.homeCalendarPreviousWeek,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                backgroundColor: cs.onSurfaceVariant.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  DateFormat.yMMMM(
                    Localizations.localeOf(context).toString(),
                  ).format(bottomRowStart),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: canGoNewer ? () => setState(() => _page -= 1) : null,
              icon: const Icon(Icons.chevron_right_rounded),
              tooltip: l10n.homeCalendarNextWeek,
              visualDensity: VisualDensity.compact,
              style: IconButton.styleFrom(
                backgroundColor: cs.onSurfaceVariant.withValues(alpha: 0.08),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
        // calendar header + two date rows design
        Container(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
          ),
          child: Column(
            children: <Widget>[
              Row(
                children: _weekdayLabels(l10n)
                    .map(
                      (String label) => Expanded(
                        child: Center(
                          child: Text(
                            label,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: cs.tertiary.withValues(alpha: 0.9),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(growable: false),
              ),
              // A hard line separating the weekday header from the days.
              Divider(
                height: 8,
                thickness: 1,
                color: cs.outlineVariant.withValues(alpha: 0.5),
              ),
              // Swipeable two-week mini calendar
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragEnd: (DragEndDetails details) {
                  final double? velocity = details.primaryVelocity;
                  if (velocity == null) {
                    return;
                  }
                  if (velocity > 200 && canGoOlder) {
                    setState(() => _page += 1);
                  } else if (velocity < -200 && canGoNewer) {
                    setState(() => _page -= 1);
                  }
                },
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.5),
                      child: _weekRow(topRowStart, today, kept, readDaySet),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.5),
                      child: _weekRow(bottomRowStart, today, kept, readDaySet),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _weekRow(
    DateTime rowStart,
    DateTime today,
    bool Function(DateTime) kept,
    Set<String> readDaySet,
  ) {
    return Row(
      children: <Widget>[
        for (int d = 0; d < 7; d++)
          () {
            final DateTime day = rowStart.add(Duration(days: d));
            final bool isKept = kept(day);
            return Expanded(
              child: _DayCell(
                day: day,
                today: today,
                done: readDaySet.contains(_key(day)),
                frozen: widget.frozenDays.contains(_key(day)),
                onBreak: widget.breakDays.contains(_key(day)),
                joinLeft:
                    d > 0 &&
                    isKept &&
                    kept(day.subtract(const Duration(days: 1))),
                joinRight:
                    d < 6 && isKept && kept(day.add(const Duration(days: 1))),
              ),
            );
          }(),
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
    required this.onBreak,
    required this.joinLeft,
    required this.joinRight,
  });

  final DateTime day;
  final DateTime today;
  final bool done;
  final bool frozen;
  final bool onBreak;
  final bool joinLeft;
  final bool joinRight;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final bool isFuture = day.isAfter(today);
    final bool isToday = day == today;
    // A day can be both read and covered by a match/break; read wins.
    final bool isFrozenOnly = frozen && !done;
    final bool isBreakOnly = onBreak && !done && !isFrozenOnly;

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
    } else if (isBreakOnly) {
      fill = cs.tertiaryContainer;
      fg = cs.onTertiaryContainer;
    } else if (isFuture) {
      fg = cs.onSurfaceVariant.withValues(alpha: 0.35);
    } else {
      fg = cs.onSurfaceVariant.withValues(alpha: 0.7);
    }
    if (isToday && !done && !isFrozenOnly && !isBreakOnly) {
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
                        fontWeight:
                            done || isFrozenOnly || isBreakOnly || isToday
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
