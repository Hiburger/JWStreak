import 'package:flutter/material.dart';

import '../achievements_data.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/responsive_body.dart';

/// One accent per category rather than per individual achievement — 21
/// distinct colors would stop reading as "grouped" and start reading as
/// random. Reuses the same palette onboarding and the home screen's quick
/// actions already use, so a color means the same thing everywhere it shows
/// up instead of every screen inventing its own.
OnboardingAccent _accentFor(AchievementCategory category) => switch (category) {
  AchievementCategory.reading => kAccentBlue,
  AchievementCategory.quizzes => kAccentAmber,
  AchievementCategory.streak => kAccentOrange,
  AchievementCategory.other => kAccentPurple,
};

/// Localized title/description for one achievement id. Kept separate from
/// [kAchievementDefs] since that list is plain data (no BuildContext).
(String, String) _achievementText(AppLocalizations l10n, String id) {
  switch (id) {
    case 'first_chapter':
      return (
        l10n.achievementFirstChapterTitle,
        l10n.achievementFirstChapterDesc,
      );
    case 'chapters_10':
      return (l10n.achievementChapters10Title, l10n.achievementChapters10Desc);
    case 'chapters_50':
      return (l10n.achievementChapters50Title, l10n.achievementChapters50Desc);
    case 'chapters_150':
      return (
        l10n.achievementChapters150Title,
        l10n.achievementChapters150Desc,
      );
    case 'genesis_complete':
      return (l10n.achievementGenesisTitle, l10n.achievementGenesisDesc);
    case 'whole_bible':
      return (l10n.achievementWholeBibleTitle, l10n.achievementWholeBibleDesc);
    case 'explorer_5books':
      return (l10n.achievementExplorerTitle, l10n.achievementExplorerDesc);
    case 'first_quiz':
      return (l10n.achievementFirstQuizTitle, l10n.achievementFirstQuizDesc);
    case 'quizzes_5':
      return (l10n.achievementQuizzes5Title, l10n.achievementQuizzes5Desc);
    case 'quizzes_25':
      return (l10n.achievementQuizzes25Title, l10n.achievementQuizzes25Desc);
    case 'quizzes_40':
      return (l10n.achievementQuizzes40Title, l10n.achievementQuizzes40Desc);
    case 'perfect_quiz':
      return (
        l10n.achievementPerfectQuizTitle,
        l10n.achievementPerfectQuizDesc,
      );
    case 'stars_20':
      return (l10n.achievementStars20Title, l10n.achievementStars20Desc);
    case 'stars_40':
      return (l10n.achievementStars40Title, l10n.achievementStars40Desc);
    case 'streak_7':
      return (l10n.achievementStreak7Title, l10n.achievementStreak7Desc);
    case 'streak_30':
      return (l10n.achievementStreak30Title, l10n.achievementStreak30Desc);
    case 'streak_180':
      return (l10n.achievementStreak180Title, l10n.achievementStreak180Desc);
    case 'first_note':
      return (l10n.achievementFirstNoteTitle, l10n.achievementFirstNoteDesc);
    case 'notes_10':
      return (l10n.achievementNotes10Title, l10n.achievementNotes10Desc);
    case 'reminder_set':
      return (l10n.achievementReminderTitle, l10n.achievementReminderDesc);
    case 'easter_eggs_all':
      return (l10n.achievementEasterEggsTitle, l10n.achievementEasterEggsDesc);
    default:
      return ('', '');
  }
}

String _sectionTitle(AppLocalizations l10n, AchievementCategory category) {
  switch (category) {
    case AchievementCategory.reading:
      return l10n.achievementsSectionReading;
    case AchievementCategory.quizzes:
      return l10n.achievementsSectionQuizzes;
    case AchievementCategory.streak:
      return l10n.achievementsSectionStreak;
    case AchievementCategory.other:
      return l10n.achievementsSectionOther;
  }
}

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({required this.dbService, super.key});

  final LocalDbService dbService;

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  bool _isLoading = true;
  AchievementStats? _stats;
  Set<String> _unlockedIds = const <String>{};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    // Was computing the full stats twice back to back: once inside
    // syncAchievements (to check what's newly met) and again right after
    // for display. Compute it once and hand the same object to both.
    final AchievementStats stats = await widget.dbService.getAchievementStats();
    final Set<String> unlockedIds = await widget.dbService.syncAchievements(
      stats: stats,
    );
    if (!mounted) {
      return;
    }
    setState(() {
      _unlockedIds = unlockedIds;
      _stats = stats;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    if (_isLoading || _stats == null) {
      return Scaffold(
        appBar: AppBar(
          leading: const CircularBackButton(),
          title: Text(l10n.achievementsTitle),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final AchievementStats stats = _stats!;
    final int unlockedCount = kAchievementDefs
        .where((AchievementDef def) => _unlockedIds.contains(def.id))
        .length;
    final int bonusStars = achievementBonusStars(_unlockedIds);

    final Map<AchievementCategory, List<AchievementDef>> byCategory =
        <AchievementCategory, List<AchievementDef>>{};
    for (final AchievementDef def in kAchievementDefs) {
      (byCategory[def.category] ??= <AchievementDef>[]).add(def);
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.achievementsTitle),
      ),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                // Matches the home screen's streak hero card instead of a flat
                // (previously light-blue-reading) container color.
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[cs.primaryContainer, cs.tertiaryContainer],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.emoji_events_rounded,
                    color: cs.onPrimaryContainer,
                    size: 32,
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.achievementsUnlockedCount(
                            unlockedCount,
                            kAchievementDefs.length,
                          ),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: cs.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            value: kAchievementDefs.isEmpty
                                ? 0
                                : unlockedCount / kAchievementDefs.length,
                            minHeight: 8,
                            backgroundColor: cs.onPrimaryContainer.withValues(
                              alpha: 0.15,
                            ),
                          ),
                        ),
                        if (bonusStars > 0) ...<Widget>[
                          const SizedBox(height: 8),
                          Row(
                            children: <Widget>[
                              // Plain amber read as washed-out against this
                              // card's pastel gradient — onPrimaryContainer
                              // is the same tone as the text next to it, so
                              // it's guaranteed to actually stand out here.
                              Icon(
                                Icons.star_rounded,
                                color: cs.onPrimaryContainer,
                                size: 22,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                // The leading "+" is what marks this as a
                                // bonus rather than a restatement of the
                                // home screen's own star total.
                                '+$bonusStars '
                                '${bonusStars != 1 ? l10n.homeStatStarsPlural : l10n.homeStatStarSingular}',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: cs.onPrimaryContainer,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            for (final AchievementCategory category
                in AchievementCategory.values)
              if (byCategory[category]
                  case final List<AchievementDef> defs?) ...<Widget>[
                const SizedBox(height: 24),
                Text(
                  _sectionTitle(l10n, category),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                for (final AchievementDef def in defs)
                  _AchievementTile(
                    def: def,
                    stats: stats,
                    unlocked: _unlockedIds.contains(def.id),
                  ),
              ],
          ],
        ),
      ),
    );
  }
}

class _AchievementTile extends StatelessWidget {
  const _AchievementTile({
    required this.def,
    required this.stats,
    required this.unlocked,
  });

  final AchievementDef def;
  final AchievementStats stats;
  final bool unlocked;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final (String title, String description) = _achievementText(l10n, def.id);

    final int? goal = def.goal;
    final int? progress = def.progress?.call(stats);

    final OnboardingAccent accent = _accentFor(def.category);
    // Locked stays the neutral grey/padlock treatment — the category color
    // is part of what unlocking actually earns, same as the star-reward
    // badge dimming until then.
    final Color iconBackground = unlocked
        ? accent.background(context)
        : cs.surfaceContainerHighest;
    final Color iconForeground = unlocked
        ? accent.foreground(context)
        : cs.onSurfaceVariant;

    return Card.filled(
      margin: const EdgeInsets.only(bottom: 10),
      // Matches the trophy banner above — Material 3's own Card default
      // (12) reads as a different, smaller radius sitting right underneath
      // it.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: unlocked ? cs.surfaceContainerHigh : cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBackground,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: unlocked
                      ? iconForeground.withValues(alpha: 0.25)
                      : cs.outlineVariant,
                ),
              ),
              child: Icon(
                unlocked ? def.icon : Icons.lock_outline,
                color: iconForeground,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: unlocked ? null : cs.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  if (goal != null &&
                      progress != null &&
                      !unlocked) ...<Widget>[
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: (progress / goal).clamp(0, 1).toDouble(),
                        minHeight: 6,
                        backgroundColor: cs.surfaceContainerHighest,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.achievementsProgressFraction(
                        progress.clamp(0, goal),
                        goal,
                      ),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (unlocked)
                  Icon(
                    Icons.check_circle_rounded,
                    color: cs.tertiary,
                    size: 22,
                  ),
                if (def.starReward > 0) ...<Widget>[
                  if (unlocked) const SizedBox(height: 6),
                  _StarRewardBadge(
                    count: def.starReward,
                    // Muted while locked: a preview of what's coming, not a
                    // claim that it's already been earned.
                    active: unlocked,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Small "+N ⭐" pill next to an achievement, previewing (locked) or
/// confirming (unlocked) the bonus stars that achievement is worth.
class _StarRewardBadge extends StatelessWidget {
  const _StarRewardBadge({required this.count, required this.active});

  final int count;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final Color fg = active ? Colors.amber.shade800 : cs.onSurfaceVariant;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: active
            ? Colors.amber.withValues(alpha: 0.18)
            : cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.star_rounded, color: fg, size: 18),
          const SizedBox(width: 3),
          Text(
            l10n.achievementStarReward(count),
            style: theme.textTheme.titleSmall?.copyWith(
              color: fg,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
