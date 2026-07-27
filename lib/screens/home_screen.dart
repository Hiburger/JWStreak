import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../services/deep_link_service.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../theme/theme_preference.dart';
import '../widgets/freeze_earned_dialog.dart';
import '../widgets/guided_tour.dart';
import '../widgets/message_dialog.dart';
import '../widgets/tap_easter_egg.dart';
import 'achievements_screen.dart';
import 'bible_browser_screen.dart';
import 'checkpoint_screen.dart';
import 'notes_library_screen.dart';
import 'quiz_screen.dart';
import 'notes_screen.dart';
import 'reminder_setup_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.skipBootstrap = false,
    this.currentThemePreference = ThemePreference.system,
    this.onThemePreferenceChanged,
    this.useDynamicColor = false,
    this.onUseDynamicColorChanged,
    this.currentLocaleCode,
    this.onLocaleChanged,
  });

  final bool skipBootstrap;
  final ThemePreference currentThemePreference;
  final Future<void> Function(ThemePreference value)? onThemePreferenceChanged;
  final bool useDynamicColor;
  final Future<void> Function(bool value)? onUseDynamicColorChanged;

  /// null means "follow system language".
  final String? currentLocaleCode;
  final Future<void> Function(String? code)? onLocaleChanged;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalDbService _dbService = LocalDbService();
  final NotificationService _notificationService = NotificationService();
  final DeepLinkService _deepLinkService = DeepLinkService();

  List<Reminder> _reminders = const <Reminder>[];
  DateTime? _lastReadAt;
  StreakState _streakState = const StreakState(
    count: 0,
    freezes: 0,
    activeToday: false,
    justLost: false,
  );
  int get _streak => _streakState.count;
  int _totalReadings = 0;
  List<DateTime> _recentReadingDays = const <DateTime>[];
  Set<String> _frozenDays = const <String>{};
  Set<String> _readKeys = const <String>{};
  Set<String> _completedQuiz = const <String>{};
  int _totalStars = 0;
  bool _isLoading = true;

  // Targets for the guided tour. Adding a step is just: declare a key here,
  // attach it below, and add one entry to _tourSteps().
  final GlobalKey _tourStreakKey = GlobalKey();
  final GlobalKey _tourReadingKey = GlobalKey();
  final GlobalKey _tourBrowseKey = GlobalKey();
  final GlobalKey _tourProgressKey = GlobalKey();
  final GlobalKey _tourQuickActionsKey = GlobalKey();
  final GlobalKey _tourAchievementsKey = GlobalKey();
  final GlobalKey _tourNotesKey = GlobalKey();
  final GlobalKey _tourSettingsKey = GlobalKey();
  bool _isTourRunning = false;

  @override
  void initState() {
    super.initState();
    if (widget.skipBootstrap) {
      _isLoading = false;
      return;
    }
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      await _dbService.initialize();
      await _notificationService.initialize(
        onTap: _handleNotificationTap,
        onError: _handleBackgroundError,
      );
      await _notificationService.handleAppLaunchNotification();
      await _refreshDashboard();
      await _ensureExactAlarmPermission();
      await _maybeShowGuidedTour();
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showError(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Steps of the home-screen walkthrough, in the order they're shown.
  List<TourStep> _tourSteps(AppLocalizations l10n) => <TourStep>[
    // Corner radii match each target's own decoration (see _StreakHero,
    // _ContinueReadingCard/_AllReadCard, _BrowseBibleTile, _ProgressCard,
    // _QuickActionTile) so the highlight traces the actual shape instead of
    // a generic box.
    TourStep(
      targetKey: _tourStreakKey,
      title: l10n.tourStreakTitle,
      body: l10n.tourStreakBody,
      cornerRadius: 28,
    ),
    TourStep(
      targetKey: _tourReadingKey,
      title: l10n.tourReadingTitle,
      body: l10n.tourReadingBody,
      cornerRadius: 18,
    ),
    TourStep(
      targetKey: _tourBrowseKey,
      title: l10n.tourBrowseTitle,
      body: l10n.tourBrowseBody,
      cornerRadius: 16,
    ),
    TourStep(
      targetKey: _tourProgressKey,
      title: l10n.tourProgressTitle,
      body: l10n.tourProgressBody,
      cornerRadius: 16,
    ),
    TourStep(
      targetKey: _tourQuickActionsKey,
      title: l10n.tourQuickActionsTitle,
      body: l10n.tourQuickActionsBody,
      cornerRadius: 14,
    ),
    TourStep(
      targetKey: _tourAchievementsKey,
      title: l10n.tourAchievementsTitle,
      body: l10n.tourAchievementsBody,
      shape: TourHighlightShape.circle,
    ),
    TourStep(
      targetKey: _tourNotesKey,
      title: l10n.tourNotesTitle,
      body: l10n.tourNotesBody,
      shape: TourHighlightShape.circle,
    ),
    TourStep(
      targetKey: _tourSettingsKey,
      title: l10n.tourSettingsTitle,
      body: l10n.tourSettingsBody,
      shape: TourHighlightShape.circle,
    ),
  ];

  /// Runs the walkthrough once, right after onboarding. The settings screen
  /// can clear the flag to let the user replay it.
  Future<void> _maybeShowGuidedTour() async {
    if (_isTourRunning || await _dbService.isGuidedTourDone() || !mounted) {
      return;
    }
    _isTourRunning = true;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    try {
      await showGuidedTour(
        context,
        steps: _tourSteps(l10n),
        labels: TourLabels(
          skip: l10n.tourSkip,
          next: l10n.tourNext,
          done: l10n.tourDone,
        ),
      );
      await _dbService.setGuidedTourDone();
    } finally {
      _isTourRunning = false;
    }
  }

  Future<void> _refreshDashboard() async {
    final List<Reminder> reminders = await _dbService.getReminders();
    final DateTime? lastReadAt = await _dbService.getLastReadingAt();
    final StreakState streakState = await _dbService.getStreakState();
    final int totalReadings = await _dbService.getTotalReadings();
    final List<DateTime> recentReadingDays = await _dbService
        .getRecentReadingDays(limit: 14);
    final Set<String> readKeys = await _dbService.getReadChapterKeys();
    final Set<String> completedQuiz = await _dbService.getCompletedQuizIds();
    final Map<String, int> starsByBook = await _dbService
        .getEarnedStarsByBook();
    final int totalStars = starsByBook.values.fold<int>(
      0,
      (int a, int b) => a + b,
    );
    final Set<String> frozenDays = await _dbService.getFrozenDays();
    await _dbService.syncAchievements();

    if (!mounted) {
      return;
    }

    // Keep the OS schedule in sync with the stored reminders.
    final AppLocalizations notifL10n = AppLocalizations.of(context)!;
    await _notificationService.cancelAllReminders();
    for (final Reminder reminder in reminders) {
      await _notificationService.scheduleReminder(
        id: reminder.id,
        time: TimeOfDay(hour: reminder.hour, minute: reminder.minute),
        title: notifL10n.notifReminderTitle,
        body: notifL10n.notifReminderBody,
      );
    }

    // Evening warning if the streak is still inactive today; cancelled as
    // soon as the user is active again.
    if (streakState.count > 0 && !streakState.activeToday) {
      await _notificationService.scheduleStreakRiskCheck(
        title: notifL10n.notifStreakRiskTitle,
        body: notifL10n.notifStreakRiskBody,
      );
    } else {
      await _notificationService.cancelStreakRiskCheck();
    }

    if (!mounted) {
      return;
    }
    setState(() {
      _reminders = reminders;
      _lastReadAt = lastReadAt;
      _streakState = streakState;
      _totalReadings = totalReadings;
      _recentReadingDays = recentReadingDays;
      _frozenDays = frozenDays;
      _readKeys = readKeys;
      _completedQuiz = completedQuiz;
      _totalStars = totalStars;
      _isLoading = false;
    });

    // Gentle message the first time the user comes back after losing the streak.
    if (streakState.justLost && mounted) {
      await _dbService.acknowledgeStreakLoss();
      if (mounted) {
        await showMessageDialog(
          context,
          message: AppLocalizations.of(context)!.homeStreakLostMessage,
        );
      }
    }
  }

  Future<void> _runAction(Future<void> Function() action) async {
    try {
      await action();
      await _refreshDashboard();
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  Future<void> _configureReminder() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => ReminderSetupScreen(dbService: _dbService),
      ),
    );
    if (!mounted) {
      return;
    }
    // The screen edits reminders directly in the DB; re-read + reschedule.
    await _refreshDashboard();
    await _ensureExactAlarmPermission();
  }

  /// On Android 12+ exact alarms may be denied, which lets the system delay
  /// reminders (Doze). Prompt the user to grant the permission so the reminder
  /// fires at the configured time, then reschedule in exact mode.
  Future<void> _ensureExactAlarmPermission() async {
    final bool canExact = await _notificationService.canScheduleExactAlarms();
    if (canExact || !mounted) {
      return;
    }

    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool openSettings =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            title: Text(l10n.homeExactAlarmDialogTitle),
            content: Text(l10n.homeExactAlarmDialogContent),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.homeExactAlarmDialogLater),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.homeExactAlarmDialogOpenSettings),
              ),
            ],
          ),
        ) ??
        false;

    if (!openSettings || !mounted) {
      return;
    }

    await _notificationService.requestExactAlarmPermission();
    // Reschedule so the reminder uses exact mode if it was just granted.
    if (mounted) {
      await _refreshDashboard();
    }
  }

  Future<void> _handleNotificationTap(ReminderPayload payload) async {
    await _deepLinkService.openReference(
      book: payload.book,
      chapter: payload.chapter,
      languageCode: Localizations.localeOf(context).languageCode,
    );
  }

  void _handleBackgroundError(Object error, StackTrace stackTrace) {
    if (!mounted) {
      return;
    }
    _showError(error);
  }

  Future<void> _markChapterRead(String book, int chapter) async {
    // No confirmation toast needed: the dashboard (next chapter, progress
    // bars, streak) refreshes immediately and already shows the change.
    await _runAction(() async {
      await _dbService.markChapterRead(book: book, chapter: chapter);
    });
  }

  Future<void> _openChapter(String book, int chapter) async {
    final String languageCode = Localizations.localeOf(context).languageCode;
    await _runAction(() async {
      await _deepLinkService.openReference(
        book: book,
        chapter: chapter,
        languageCode: languageCode,
      );
    });
  }

  Future<void> _openBibleBrowser() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => BibleBrowserScreen(dbService: _dbService),
      ),
    );
    await _refreshDashboard();
  }

  /// First chapter (canonical order) that hasn't been read yet, or null when
  /// the whole Bible is done.
  _ChapterRef? _nextUnread() {
    for (final BibleBook book in kBibleBooks) {
      for (int c = 1; c <= book.chapters; c++) {
        if (!_readKeys.contains(bibleChapterKey(book.id, c))) {
          return _ChapterRef(book, c);
        }
      }
    }
    return null;
  }

  bool _checkpointUnlocked(BibleBook book, Checkpoint cp) {
    for (int c = 1; c <= cp.afterChapter; c++) {
      if (!_readKeys.contains(bibleChapterKey(book.id, c))) {
        return false;
      }
    }
    return true;
  }

  /// Earliest unlocked checkpoint whose quiz hasn't been taken yet.
  /// Reflection-only checkpoints (no quiz) never trigger this banner — it's
  /// specifically the "new quiz unlocked" notice.
  Checkpoint? _pendingQuizCheckpoint() {
    final String languageCode = Localizations.localeOf(context).languageCode;
    for (final BibleBook book in kBibleBooks) {
      for (final Checkpoint cp in checkpointsForBook(
        book,
        languageCode: languageCode,
      )) {
        if (!cp.hasQuiz) {
          continue;
        }
        if (_checkpointUnlocked(book, cp) && !_completedQuiz.contains(cp.id)) {
          return cp;
        }
      }
    }
    return null;
  }

  Future<void> _openCheckpoint(Checkpoint cp) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => CheckpointScreen(dbService: _dbService, checkpoint: cp),
      ),
    );
    await _refreshDashboard();
  }

  /// Review quiz to earn back one streak freeze (mix of everything read so
  /// far). Requires ≥60% correct to award the freeze.
  Future<void> _openReviewQuiz() async {
    final List<QuizQuestion> questions = buildReviewQuiz(
      _readKeys,
      count: 5,
      languageCode: Localizations.localeOf(context).languageCode,
    );
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (questions.length < 3) {
      showMessageDialog(context, message: l10n.homeReviewQuizLocked);
      return;
    }
    bool earned = false;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          title: l10n.homeReviewQuizTitle,
          questions: questions,
          onCompleted: (int score, int total) async {
            if (score * 100 >= total * 60) {
              await _dbService.addStreakFreeze();
              earned = true;
            }
          },
        ),
      ),
    );
    await _refreshDashboard();
    if (!mounted) {
      return;
    }
    if (earned) {
      await showFreezeEarnedDialog(context, message: l10n.homeReviewQuizEarned);
    } else {
      await showMessageDialog(context, message: l10n.homeReviewQuizFailed);
    }
  }

  Future<void> _openDailyTextLink() async {
    final String languageCode = Localizations.localeOf(context).languageCode;
    await _runAction(() async {
      await _deepLinkService.openDailyText(languageCode: languageCode);
    });
  }

  Future<void> _openNotesEditor() async {
    // No noteId: opens the editor on a brand-new note linked to Genesis 1.
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesScreen(dbService: _dbService),
      ),
    );
    if (changed == true) {
      await _refreshDashboard();
    }
  }

  Future<void> _openAchievements() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => AchievementsScreen(dbService: _dbService),
      ),
    );
  }

  Future<void> _openNotesLibrary() async {
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesLibraryScreen(dbService: _dbService),
      ),
    );
    if (changed == true) {
      await _refreshDashboard();
    }
  }

  Future<void> _openSettings() async {
    final Future<void> Function(ThemePreference value)?
    onThemePreferenceChanged = widget.onThemePreferenceChanged;
    if (onThemePreferenceChanged == null) {
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => SettingsScreen(
          currentThemePreference: widget.currentThemePreference,
          onThemePreferenceChanged: onThemePreferenceChanged,
          useDynamicColor: widget.useDynamicColor,
          onUseDynamicColorChanged: widget.onUseDynamicColorChanged,
          currentLocaleCode: widget.currentLocaleCode,
          onLocaleChanged: widget.onLocaleChanged,
          notificationService: _notificationService,
        ),
      ),
    );
    if (!mounted) {
      return;
    }
    // Settings can clear the tour flag ("replay the guided tour"), so re-check
    // it once we're back on the home screen the tour actually points at.
    await _maybeShowGuidedTour();
  }

  void _showError(Object error) {
    showMessageDialog(
      context,
      message: AppLocalizations.of(context)!.homeGenericError(error.toString()),
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final bool readToday = _streakState.activeToday;
    final bool streakAtRisk = _streak > 0 && !_streakState.activeToday;
    final String reminderLabel = _reminders.isEmpty
        ? l10n.homeReminderConfigure
        : _reminders.length == 1
        ? l10n.homeReminderAt(_reminders.first.label)
        : l10n.homeRemindersActive(_reminders.length);
    final _ChapterRef? nextChapter = _nextUnread();
    final int chaptersRead = _readKeys.length;
    final Checkpoint? pendingCheckpoint = _pendingQuizCheckpoint();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JW Streak',
          style: const TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
        actions: <Widget>[
          IconButton(
            key: _tourAchievementsKey,
            onPressed: _openAchievements,
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: l10n.homeAchievementsTooltip,
          ),
          IconButton(
            key: _tourNotesKey,
            onPressed: _openNotesLibrary,
            icon: const Icon(Icons.library_books_outlined),
            tooltip: l10n.homeNotesLibraryTooltip,
          ),
          IconButton(
            key: _tourSettingsKey,
            onPressed: _openSettings,
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n.homeSettingsTooltip,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
        children: <Widget>[
          _StreakHero(
            key: _tourStreakKey,
            streak: _streak,
            freezes: _streakState.freezes,
            readToday: readToday,
            reminderLabel: reminderLabel,
            onConfigureReminder: _configureReminder,
          ),
          if (streakAtRisk) ...<Widget>[
            const SizedBox(height: 12),
            _StreakAtRiskBanner(
              freezes: _streakState.freezes,
              onEarnFreeze: _openReviewQuiz,
            ),
          ],
          const SizedBox(height: 28),
          _SectionCard(
            title: l10n.homeSectionReadingTitle,
            subtitle: l10n.homeSectionReadingSubtitle,
            children: <Widget>[
              if (nextChapter != null)
                _ContinueReadingCard(
                  key: _tourReadingKey,
                  reference:
                      '${localizedBookName(context, nextChapter.book)} ${nextChapter.chapter}',
                  onOpen: () =>
                      _openChapter(nextChapter.book.id, nextChapter.chapter),
                  onMarkRead: () => _markChapterRead(
                    nextChapter.book.id,
                    nextChapter.chapter,
                  ),
                )
              else
                _AllReadCard(key: _tourReadingKey),
              if (pendingCheckpoint != null)
                _CheckpointBanner(
                  checkpoint: pendingCheckpoint,
                  onTap: () => _openCheckpoint(pendingCheckpoint),
                ),
              _BrowseBibleTile(key: _tourBrowseKey, onTap: _openBibleBrowser),
            ],
          ),
          const SizedBox(height: 20),
          _SectionCard(
            title: l10n.homeSectionProgressTitle,
            children: <Widget>[
              _ProgressCard(
                key: _tourProgressKey,
                streak: _streak,
                totalReadings: _totalReadings,
                totalStars: _totalStars,
                lastReadAt: _lastReadAt,
                recentReadingDays: _recentReadingDays,
                frozenDays: _frozenDays,
                chaptersRead: chaptersRead,
                totalChapters: kTotalBibleChapters,
              ),
            ],
          ),
          const SizedBox(height: 28),
          _SectionHeader(title: l10n.homeSectionQuickActions),
          const SizedBox(height: 12),
          _QuickActions(
            key: _tourQuickActionsKey,
            onOpenDailyText: _openDailyTextLink,
            onWriteNote: _openNotesEditor,
            onReadNotes: _openNotesLibrary,
          ),
        ],
      ),
    );
  }
}

class _ChapterRef {
  const _ChapterRef(this.book, this.chapter);

  final BibleBook book;
  final int chapter;
}

class _StreakHero extends StatelessWidget {
  const _StreakHero({
    super.key,
    required this.streak,
    required this.freezes,
    required this.readToday,
    required this.reminderLabel,
    required this.onConfigureReminder,
  });

  final int streak;
  final int freezes;
  final bool readToday;
  final String reminderLabel;
  final VoidCallback onConfigureReminder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final DateTime now = DateTime.now();
    final String greeting = _greetingFor(now, l10n);
    final IconData greetingIcon = _iconFor(now.hour);
    final String streakLine = streak == 0
        ? l10n.homeStreakStartToday
        : l10n.homeStreakDayCount(streak);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cs.primaryContainer, cs.tertiaryContainer],
        ),
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          greetingIcon,
                          size: 18,
                          color: cs.onPrimaryContainer.withValues(alpha: 0.85),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          greeting,
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: cs.onPrimaryContainer.withValues(
                              alpha: 0.85,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      streakLine,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: cs.onPrimaryContainer,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: <Widget>[
                        _StatusPill(readToday: readToday),
                        const SizedBox(width: 8),
                        _FreezePill(freezes: freezes),
                      ],
                    ),
                  ],
                ),
              ),
              _StreakFireEasterEgg(streak: streak),
            ],
          ),
          const SizedBox(height: 18),
          _HeroReminderButton(label: reminderLabel, onTap: onConfigureReminder),
        ],
      ),
    );
  }

  // Greeting variants per time-of-day bucket. Picking with the day-of-year
  // keeps the same greeting all day (no flicker on rebuild) while still
  // varying from one day to the next.
  static String _greetingFor(DateTime now, AppLocalizations l10n) {
    final int hour = now.hour;
    final List<String> options;
    if (hour < 5) {
      options = <String>[l10n.homeGreetingNight1, l10n.homeGreetingNight2];
    } else if (hour < 12) {
      options = <String>[
        l10n.homeGreetingMorning1,
        l10n.homeGreetingMorning2,
        l10n.homeGreetingMorning3,
      ];
    } else if (hour < 14) {
      options = <String>[l10n.homeGreetingMidday1, l10n.homeGreetingMidday2];
    } else if (hour < 18) {
      options = <String>[
        l10n.homeGreetingAfternoon1,
        l10n.homeGreetingAfternoon2,
      ];
    } else if (hour < 22) {
      options = <String>[l10n.homeGreetingEvening1, l10n.homeGreetingEvening2];
    } else {
      options = <String>[l10n.homeGreetingNight1, l10n.homeGreetingNight2];
    }
    final int dayOfYear = int.parse(DateFormat('D').format(now));
    return options[dayOfYear % options.length];
  }

  static IconData _iconFor(int hour) {
    return hour >= 6 && hour < 19
        ? Icons.wb_sunny_rounded
        : Icons.dark_mode_rounded;
  }
}

class _FreezePill extends StatelessWidget {
  const _FreezePill({required this.freezes});

  final int freezes;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.onPrimaryContainer.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.whatshot_rounded, size: 16, color: cs.onPrimaryContainer),
          const SizedBox(width: 6),
          Text(
            '$freezes',
            style: TextStyle(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.readToday});

  final bool readToday;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final IconData icon = readToday ? Icons.check_circle : Icons.schedule;
    final String text = readToday ? l10n.homeReadToday : l10n.homeToReadToday;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: cs.onPrimaryContainer.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 16, color: cs.onPrimaryContainer),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: cs.onPrimaryContainer,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroReminderButton extends StatelessWidget {
  const _HeroReminderButton({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.onPrimaryContainer.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.notifications_active_outlined,
                size: 20,
                color: cs.onPrimaryContainer,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: cs.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 20,
                color: cs.onPrimaryContainer.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Wraps [_StreakFireBadge] with the tap-easter-egg gesture: tickling the
/// flame makes it pop off a little burst of sparks instead of yet another
/// notification.
class _StreakFireEasterEgg extends StatefulWidget {
  const _StreakFireEasterEgg({required this.streak});

  final int streak;

  @override
  State<_StreakFireEasterEgg> createState() => _StreakFireEasterEggState();
}

class _StreakFireEasterEggState extends State<_StreakFireEasterEgg> {
  // Purely a display prank — never touches the real stored streak. Resets
  // to normal on the next app launch since it's just in-memory State.
  bool _pranked = false;

  @override
  Widget build(BuildContext context) {
    final int displayedStreak = _pranked
        ? (widget.streak <= 0 ? -100 : 0)
        : widget.streak;
    return TapEasterEgg(
      onTriggered: () {
        LocalDbService().markEasterEggFound('flame');
        setState(() => _pranked = true);
      },
      child: _StreakFireBadge(streak: displayedStreak),
    );
  }
}

class _StreakFireBadge extends StatefulWidget {
  const _StreakFireBadge({required this.streak});

  final int streak;

  @override
  State<_StreakFireBadge> createState() => _StreakFireBadgeState();
}

class _StreakFireBadgeState extends State<_StreakFireBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // A single, continuously-looping (non-reversing) controller. Driving
    // several sine waves of different frequencies off one linear value gives
    // an organic, non-mechanical flicker instead of a ping-pong tween.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 8, top: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 108,
            height: 108,
            // Isolates this perpetually-animating subtree so it doesn't
            // force repaints of the rest of the (potentially long) home
            // screen list around it.
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _controller,
                // The flame's shader + icon never actually change — only the
                // Transform wrapping them does — so it's passed as `child`
                // instead of being rebuilt on every one of the ~60 ticks/sec.
                child: ShaderMask(
                  shaderCallback: (Rect rect) {
                    return const LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: <Color>[
                        Colors.deepOrange,
                        Colors.orange,
                        Colors.amber,
                      ],
                    ).createShader(rect);
                  },
                  child: const Icon(
                    Icons.local_fire_department_rounded,
                    size: 92,
                    color: Colors.white,
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  final double t = _controller.value * 2 * math.pi;
                  // Frequencies must be integer multiples of the base loop so
                  // every sine wave lands back exactly where it started when
                  // the controller wraps from 1.0 to 0.0 — otherwise the loop
                  // restart shows a visible jump.
                  final double glow = 0.5 + 0.5 * math.sin(t * 2);
                  final double scale =
                      1.0 +
                      0.05 * math.sin(t * 3) +
                      0.02 * math.sin(t * 5 + 0.6);
                  final double skew = 0.05 * math.sin(t * 2 + 1.0);
                  final double bob = 1.5 * math.sin(t * 3 + 0.5);

                  return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      // Soft glow behind the flame.
                      Container(
                        width: 80 + 18 * glow,
                        height: 80 + 18 * glow,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: <Color>[
                              Colors.deepOrange.withValues(alpha: 0.35 * glow),
                              Colors.deepOrange.withValues(alpha: 0),
                            ],
                          ),
                        ),
                      ),
                      // Single flame, warm gradient from base to tip.
                      Transform.translate(
                        offset: Offset(0, bob),
                        child: Transform(
                          alignment: Alignment.bottomCenter,
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateZ(skew)
                            ..scaleByDouble(scale, scale, 1, 1),
                          child: child,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 4),
          Transform.translate(
            // Pull the number ~3mm closer to the flame above it.
            offset: const Offset(0, -19),
            child: Text(
              widget.streak.toString(),
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w800,
          letterSpacing: -0.3,
        ),
      ),
    );
  }
}

/// Groups a titled section's content inside one clean, bordered Material 3
/// container, so related cards read as a single block instead of loose items
/// floating in the page.
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          if (subtitle != null) ...<Widget>[
            const SizedBox(height: 2),
            Text(
              subtitle!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
          const SizedBox(height: 14),
          for (int i = 0; i < children.length; i++) ...<Widget>[
            children[i],
            if (i != children.length - 1) const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

class _ContinueReadingCard extends StatelessWidget {
  const _ContinueReadingCard({
    super.key,
    required this.reference,
    required this.onOpen,
    required this.onMarkRead,
  });

  final String reference;
  final VoidCallback onOpen;
  final VoidCallback onMarkRead;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Material(
      color: cs.secondaryContainer.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.auto_stories_outlined,
                      color: cs.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.homeToRead,
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          reference,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: onOpen,
                      icon: const Icon(Icons.menu_book_outlined, size: 18),
                      label: Text(l10n.homeOpenButton),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: onMarkRead,
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: Text(l10n.homeMarkReadButton),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllReadCard extends StatelessWidget {
  const _AllReadCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: cs.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(Icons.emoji_events_outlined, color: cs.onPrimaryContainer),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.homeAllRead,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: cs.onPrimaryContainer,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakAtRiskBanner extends StatelessWidget {
  const _StreakAtRiskBanner({
    required this.freezes,
    required this.onEarnFreeze,
  });

  final int freezes;
  final VoidCallback onEarnFreeze;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String freezeLabel = freezes == 0
        ? l10n.homeFreezesNone
        : l10n.homeFreezesRemaining(freezes);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.warning_amber_rounded, color: cs.onErrorContainer),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.homeStreakAtRiskTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onErrorContainer,
                      ),
                    ),
                    Text(
                      l10n.homeStreakAtRiskSubtitle(freezeLabel),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onErrorContainer.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (freezes == 0) ...<Widget>[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonalIcon(
                onPressed: onEarnFreeze,
                icon: const Icon(Icons.whatshot_rounded, size: 18),
                label: Text(l10n.homeEarnFreezeButton),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Announces a freshly-unlocked quiz. Wrapped in a slowly rotating gradient
/// ring + pulsing glow so it stands out as something new to try.
class _CheckpointBanner extends StatefulWidget {
  const _CheckpointBanner({required this.checkpoint, required this.onTap});

  final Checkpoint checkpoint;
  final VoidCallback onTap;

  @override
  State<_CheckpointBanner> createState() => _CheckpointBannerState();
}

class _CheckpointBannerState extends State<_CheckpointBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final Widget card = Card.filled(
      margin: EdgeInsets.zero,
      color: cs.tertiaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.tertiary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: cs.onTertiary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      l10n.homeNewQuizUnlocked,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onTertiaryContainer,
                      ),
                    ),
                    Text(
                      localizedCheckpointTitle(context, widget.checkpoint),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onTertiaryContainer.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onTertiaryContainer),
            ],
          ),
        ),
      ),
    );

    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final double angle = _controller.value * 2 * math.pi;
          final double pulse =
              0.5 + 0.5 * math.sin(_controller.value * 2 * math.pi);
          return Container(
            padding: const EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: SweepGradient(
                transform: GradientRotation(angle),
                colors: const <Color>[
                  Colors.amber,
                  Color(0xFFFFD54F), // light amber
                  Colors.orangeAccent,
                  Colors.amber,
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.amber.withValues(alpha: 0.35 + 0.3 * pulse),
                  blurRadius: 14 + 10 * pulse,
                  spreadRadius: 1 + 2 * pulse,
                ),
              ],
            ),
            child: child,
          );
        },
        child: card,
      ),
    );
  }
}

// Deliberately no progress bar / chapter count here — that's already shown
// by _BibleProgressIndicator in the Progress section below, so repeating it
// here would just be a duplicate of the same numbers.
class _BrowseBibleTile extends StatelessWidget {
  const _BrowseBibleTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: cs.tertiaryContainer.withValues(alpha: 0.55),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.travel_explore_rounded,
                color: cs.onTertiaryContainer,
                size: 24,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  l10n.homeBrowseBible,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: cs.onTertiaryContainer,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onTertiaryContainer),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    super.key,
    required this.streak,
    required this.totalReadings,
    required this.totalStars,
    required this.lastReadAt,
    required this.recentReadingDays,
    required this.frozenDays,
    required this.chaptersRead,
    required this.totalChapters,
  });

  final int streak;
  final int totalReadings;
  final int totalStars;
  final DateTime? lastReadAt;
  final List<DateTime> recentReadingDays;
  final Set<String> frozenDays;
  final int chaptersRead;
  final int totalChapters;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final double progress = totalChapters == 0
        ? 0
        : chaptersRead / totalChapters;
    final int percent = (progress * 100).round();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _StatTile(
                icon: Icons.local_fire_department_rounded,
                value: '$streak',
                label: streak > 1
                    ? l10n.homeStatStreakDaysPlural
                    : l10n.homeStatStreakDaySingular,
                color: cs.tertiary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatTile(
                icon: Icons.menu_book_rounded,
                value: '$totalReadings',
                label: totalReadings > 1
                    ? l10n.homeStatReadingsPlural
                    : l10n.homeStatReadingSingular,
                color: cs.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatTile(
                icon: Icons.star_rounded,
                value: '$totalStars',
                label: totalStars > 1
                    ? l10n.homeStatStarsPlural
                    : l10n.homeStatStarSingular,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _BibleProgressIndicator(
          percent: percent,
          progress: progress,
          chaptersRead: chaptersRead,
          totalChapters: totalChapters,
        ),
        const SizedBox(height: 16),
        _MiniReadingCalendar(
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
      ],
    );
  }
}

class _BibleProgressIndicator extends StatelessWidget {
  const _BibleProgressIndicator({
    required this.percent,
    required this.progress,
    required this.chaptersRead,
    required this.totalChapters,
  });

  final int percent;
  final double progress;
  final int chaptersRead;
  final int totalChapters;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: cs.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.travel_explore_rounded,
                  color: cs.onPrimaryContainer,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.homeBibleBrowsed,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '$percent %',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: cs.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: cs.surfaceContainerHighest,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.homeChaptersReadCount(chaptersRead, totalChapters),
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.secondaryContainer.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({
    super.key,
    required this.onOpenDailyText,
    required this.onWriteNote,
    required this.onReadNotes,
  });

  final VoidCallback onOpenDailyText;
  final VoidCallback onWriteNote;
  final VoidCallback onReadNotes;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Column(
      children: <Widget>[
        _QuickActionTile(
          icon: Icons.wb_sunny_outlined,
          title: l10n.homeDailyTextTitle,
          subtitle: l10n.homeDailyTextSubtitle,
          onTap: onOpenDailyText,
        ),
        const SizedBox(height: 10),
        _QuickActionTile(
          icon: Icons.edit_note_outlined,
          title: l10n.homeWriteNoteTitle,
          subtitle: l10n.homeWriteNoteSubtitle,
          onTap: onWriteNote,
        ),
        const SizedBox(height: 10),
        _QuickActionTile(
          icon: Icons.menu_book_outlined,
          title: l10n.homeMyNotesTitle,
          subtitle: l10n.homeMyNotesSubtitle,
          onTap: onReadNotes,
        ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: cs.surfaceContainerHigh,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cs.secondaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: cs.onSecondaryContainer, size: 22),
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
                      ),
                    ),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniReadingCalendar extends StatelessWidget {
  const _MiniReadingCalendar({
    required this.readDays,
    required this.frozenDays,
  });

  final List<DateTime> readDays;
  final Set<String> frozenDays;

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
    final Set<String> readDaySet = readDays
        .map((DateTime day) => DateFormat('yyyy-MM-dd').format(day))
        .toSet();

    // Align to whole weeks (Monday-first): show the current week plus the two
    // previous ones, so columns line up under their weekday label.
    final DateTime weekStart = today.subtract(
      Duration(days: today.weekday - 1),
    );
    final DateTime firstDay = weekStart.subtract(const Duration(days: 14));
    final int activeCount = readDaySet.length;

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
              activeCount > 1
                  ? l10n.homeActiveDaysPlural(activeCount)
                  : l10n.homeActiveDaysSingular(activeCount),
              style: theme.textTheme.labelSmall?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: _weekdayLabels(l10n)
              .map(
                (String label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant.withValues(alpha: 0.55),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
              .toList(growable: false),
        ),
        const SizedBox(height: 4),
        for (int week = 0; week < 3; week++)
          Row(
            children: <Widget>[
              for (int d = 0; d < 7; d++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: _DayCell(
                      day: firstDay.add(Duration(days: week * 7 + d)),
                      today: today,
                      readDaySet: readDaySet,
                      frozenDays: frozenDays,
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  const _DayCell({
    required this.day,
    required this.today,
    required this.readDaySet,
    required this.frozenDays,
  });

  final DateTime day;
  final DateTime today;
  final Set<String> readDaySet;
  final Set<String> frozenDays;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final String dayKey = DateFormat('yyyy-MM-dd').format(day);
    final bool isFuture = day.isAfter(today);
    final bool isToday = day == today;
    final bool done = readDaySet.contains(dayKey);
    final bool frozen = !done && frozenDays.contains(dayKey);

    Color bg;
    Color fg;
    Border border;
    if (done) {
      bg = cs.primary;
      fg = cs.onPrimary;
      border = Border.all(color: cs.primary);
    } else if (frozen) {
      bg = Colors.lightBlue.withValues(alpha: 0.25);
      fg = Colors.lightBlue.shade700;
      border = Border.all(color: Colors.lightBlue.withValues(alpha: 0.6));
    } else if (isFuture) {
      bg = cs.surfaceContainerHighest.withValues(alpha: 0.4);
      fg = cs.onSurfaceVariant.withValues(alpha: 0.4);
      border = Border.all(color: cs.outlineVariant.withValues(alpha: 0.4));
    } else {
      bg = cs.surfaceContainerHighest;
      fg = cs.onSurfaceVariant;
      border = Border.all(color: cs.outlineVariant);
    }
    if (isToday) {
      border = Border.all(color: cs.primary, width: 2);
    }

    return AspectRatio(
      aspectRatio: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: border,
        ),
        alignment: Alignment.center,
        child: done
            ? Icon(Icons.check_rounded, size: 16, color: fg)
            : frozen
            ? Icon(Icons.whatshot_rounded, size: 15, color: fg)
            : Text(
                '${day.day}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: fg,
                  fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
