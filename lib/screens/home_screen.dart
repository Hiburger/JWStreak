import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../achievements_data.dart';
import '../app_constants.dart';
import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../quiz/quiz_facts.dart';
import '../services/deep_link_service.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../services/reading_session_service.dart';
import '../reading_plan.dart';
import '../theme/app_icons.dart';
import '../widgets/matchstick_icon.dart';
import '../widgets/marquee_text.dart';
import '../theme/app_skin.dart';
import '../theme/theme_preference.dart';
import '../widgets/freeze_earned_dialog.dart';
import '../widgets/guided_tour.dart';
import '../widgets/message_dialog.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/responsive_body.dart';
import '../widgets/tap_easter_egg.dart';
import 'achievements_screen.dart';
import 'bible_browser_screen.dart';
import 'checkpoint_screen.dart';
import 'notes_library_screen.dart';
import 'quiz_screen.dart';
import 'notes_screen.dart';
import 'reminder_setup_screen.dart';
import 'settings_screen.dart';
import 'streak_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.skipBootstrap = false,
    this.currentThemePreference = ThemePreference.system,
    this.onThemePreferenceChanged,
    this.currentAppSkin = AppSkin.classic,
    this.onAppSkinChanged,
    this.useDynamicColor = false,
    this.onUseDynamicColorChanged,
    this.currentLocaleCode,
    this.onLocaleChanged,
  });

  final bool skipBootstrap;
  final ThemePreference currentThemePreference;
  final Future<void> Function(ThemePreference value)? onThemePreferenceChanged;
  final AppSkin currentAppSkin;
  final Future<void> Function(AppSkin value)? onAppSkinChanged;
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
  final ReadingSessionService _readingSession = ReadingSessionService();

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

  /// Which order chapters come in, and where in it the reader said they'd
  /// pick up. Both feed [_nextUnread] — the reading card is the only place
  /// the plan is visible, since everything else works off chapter keys.
  ReadingPlan _readingPlan = ReadingPlan.canonical;
  String? _planStartKey;

  /// [_readKeys] plus everything before the resume point.
  ///
  /// Kept separate because the two answer different questions. _readKeys is
  /// what was genuinely read here, and is the only thing streaks, totals,
  /// quiz checkpoints and achievements are allowed to see. This one is how
  /// much of the Bible the reader has covered, which is what the progress
  /// bar means and what deciding the next chapter needs.
  Set<String> _coveredKeys = const <String>{};
  Set<String> _completedQuiz = const <String>{};
  int _totalStars = 0;
  bool _isLoading = true;

  // Derived from _readKeys / _completedQuiz, which only change in
  // _refreshDashboard — so they're computed there, once, rather than in
  // build(). Both walk all 66 books (and _pendingQuizCheckpoint additionally
  // rebuilds every book's checkpoint list), which is far too much to redo on
  // every rebuild: a scroll, a theme change or a tour step would each pay
  // for it again.
  _ChapterRef? _nextChapter;
  Checkpoint? _pendingCheckpoint;

  /// Set the moment "Open" is tapped for the chapter on the reading card, so
  /// "Mark as read" can stay disabled until the user has actually gone to
  /// read it at least once. Compared against [_nextChapter] rather than kept
  /// as a bare bool: once that chapter changes (marked read, or a fresh
  /// unread one loads), the comparison naturally fails again without any
  /// extra reset logic.
  String? _openedChapterKey;

  /// Whether an achievement unlocked since the achievements screen was last
  /// actually opened — what puts the small dot on the trophy icon.
  bool _hasNewAchievement = false;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _pendingCheckpoint holds quiz content in the current language, so it
    // has to be rebuilt when the locale changes — this widget survives that
    // change (it's keyed) and would otherwise keep showing the old language.
    _recomputeDerived();
  }

  /// Recomputes the two expensive, data-derived values behind the "continue
  /// reading" card and the "new quiz unlocked" banner. Called when the data
  /// changes (_refreshDashboard) or the locale does (didChangeDependencies) —
  /// never from build().
  void _recomputeDerived() {
    _nextChapter = _nextUnread();
    _pendingCheckpoint = _pendingQuizCheckpoint();
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
    // These 11 reads don't depend on each other — was one round-trip after
    // another, now all in flight at once.
    final List<dynamic> fetched = await Future.wait<dynamic>(<Future<dynamic>>[
      _dbService.getReminders(),
      _dbService.getLastReadingAt(),
      _dbService.getStreakState(),
      _dbService.getTotalReadings(),
      // Enough to fill the six-week grid on the streak detail screen —
      // anything less and days the user actually read would render as
      // missed simply because they fell off the end of this query.
      _dbService.getRecentReadingDays(limit: 42),
      _dbService.getReadChapterKeys(),
      _dbService.getCompletedQuizIds(),
      _dbService.getEarnedStarsByBook(),
      _dbService.getFrozenDays(),
      _dbService.getReadingPlan(),
      _dbService.getPlanStartKey(),
    ]);
    final List<Reminder> reminders = fetched[0] as List<Reminder>;
    final DateTime? lastReadAt = fetched[1] as DateTime?;
    final StreakState streakState = fetched[2] as StreakState;
    final int totalReadings = fetched[3] as int;
    final List<DateTime> recentReadingDays = fetched[4] as List<DateTime>;
    final Set<String> readKeys = fetched[5] as Set<String>;
    final ReadingPlan readingPlan = fetched[9] as ReadingPlan;
    final String? planStartKey = fetched[10] as String?;
    final Set<String> completedQuiz = fetched[6] as Set<String>;
    final Map<String, int> starsByBook = fetched[7] as Map<String, int>;
    final int totalStars = starsByBook.values.fold<int>(
      0,
      (int a, int b) => a + b,
    );
    final Set<String> frozenDays = fetched[8] as Set<String>;
    // Achievement stats independently re-read several of the same things
    // (readKeys, starsByBook, streakState, reminders) — hand over what's
    // already sitting right here instead of paying for a second copy of
    // each query.
    final AchievementStats achievementStats = await _dbService
        .getAchievementStats(
          readKeys: readKeys,
          starsByBook: starsByBook,
          streakState: streakState,
          reminders: reminders,
        );
    final Set<String> unlockedAchievementIds = await _dbService
        .syncAchievements(stats: achievementStats);
    // Additive on top of quiz stars, not folded into achievementStats: that
    // keeps the stars_20/stars_40 achievements evaluated against quiz play
    // alone, while what's shown on the home screen is everything earned.
    final int displayedStars =
        totalStars + achievementBonusStars(unlockedAchievementIds);
    final int achievementsSeenCount = await _dbService
        .getAchievementsSeenCount();
    final bool hasNewAchievement =
        unlockedAchievementIds.length > achievementsSeenCount;

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
      _readingPlan = readingPlan;
      _planStartKey = planStartKey;
      _coveredKeys = planStartKey == null
          ? readKeys
          : <String>{...readKeys, ...chaptersBeforeStart(planStartKey)};
      _completedQuiz = completedQuiz;
      _totalStars = displayedStars;
      _hasNewAchievement = hasNewAchievement;
      _isLoading = false;
      _recomputeDerived();
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

  /// Opens a chapter in JW Library (or on jw.org) and puts up the ongoing
  /// reading-session notification, which stays until the user comes back.
  ///
  /// Deliberately doesn't touch [_openedChapterKey] itself — that only
  /// flips once the user is actually back (see [_promptMarkRead]). Enabling
  /// it here, the instant Open is tapped, meant the button visibly changed
  /// right on this screen in the sliver of time before the OS finished
  /// switching to JW Library, which read as a glitch rather than a feature.
  Future<void> _launchChapter(String book, int chapter) async {
    final String languageCode = Localizations.localeOf(context).languageCode;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String reference = displayReference(context, book, chapter);
    await _readingSession.start(
      book: book,
      chapter: chapter,
      title: l10n.readingSessionTitle(reference),
      body: l10n.readingSessionBody,
      onReturn: _promptMarkRead,
    );
    try {
      await _deepLinkService.openReference(
        book: book,
        chapter: chapter,
        languageCode: languageCode,
      );
    } catch (_) {
      // Nothing actually opened, so there's no session to come back from —
      // otherwise the notification would hang around until its timeout.
      await _readingSession.cancel();
      rethrow;
    }
  }

  /// Offers to mark the chapter as read once the user is back from reading it.
  Future<void> _promptMarkRead(ReadingSession session) async {
    if (!mounted) {
      return;
    }
    // This is the actual "they're back" signal — see the note on
    // _launchChapter for why the reading card's "Mark as read" waits for
    // this instead of unlocking the moment Open was tapped.
    setState(() {
      _openedChapterKey = bibleChapterKey(session.book, session.chapter);
    });
    // It may already have been marked while they were away — from the Bible
    // browser, or by tapping "Mark as read" before opening it.
    if (_coveredKeys.contains(bibleChapterKey(session.book, session.chapter))) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String reference = displayReference(
      context,
      session.book,
      session.chapter,
    );
    final bool confirmed =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) => AlertDialog(
            title: Text(l10n.readingSessionDoneTitle(reference)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(l10n.readingSessionDoneBody),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () {
                    // Pops as "not yet" rather than "read": writing a
                    // reflection isn't the same as confirming the chapter
                    // was actually finished, so it shouldn't silently mark it
                    // read on the way there.
                    Navigator.of(dialogContext).pop(false);
                    _openNotesEditor(
                      book: session.book,
                      chapter: session.chapter,
                    );
                  },
                  icon: Icon(AppIcons.of(context).notes, size: 18),
                  label: Text(l10n.homeWriteReflectionButton),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(l10n.readingSessionNotYet),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(l10n.homeMarkReadButton),
              ),
            ],
          ),
        ) ??
        false;
    if (!confirmed || !mounted) {
      return;
    }
    await _markChapterRead(session.book, session.chapter);
  }

  Future<void> _handleNotificationTap(ReminderPayload payload) async {
    await _launchChapter(payload.book, payload.chapter);
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
    await _runAction(() => _launchChapter(book, chapter));
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
  /// The next chapter to offer, in the reader's chosen order.
  ///
  /// Used to walk kBibleBooks directly, which quietly assumed everyone reads
  /// Genesis to Revelation. The sequence now comes from the plan, and the
  /// resume point decides where in it to start looking.
  _ChapterRef? _nextUnread() {
    final PlanChapter? next = nextChapterInPlan(
      plan: _readingPlan,
      readKeys: _coveredKeys,
      startKey: _planStartKey,
    );
    return next == null ? null : _ChapterRef(next.book, next.chapter);
  }

  /// Earliest unlocked checkpoint whose quiz hasn't been taken yet.
  /// Reflection-only checkpoints (no quiz) never trigger this banner — it's
  /// specifically the "new quiz unlocked" notice.
  Checkpoint? _pendingQuizCheckpoint() {
    final String languageCode = Localizations.localeOf(context).languageCode;
    for (final BibleBook book in kBibleBooks) {
      final List<Checkpoint> checkpoints = checkpointsForBook(
        book,
        languageCode: languageCode,
      );
      for (final Checkpoint cp in checkpoints) {
        if (!cp.hasQuiz || _completedQuiz.contains(cp.id)) {
          continue;
        }
        final bool unlocked = isCheckpointAvailable(
          checkpoint: cp,
          checkpointsInBook: checkpoints,
          isChapterCovered: (int c) =>
              _coveredKeys.contains(bibleChapterKey(book.id, c)),
          isQuizDone: (String id) => _completedQuiz.contains(id),
        );
        if (unlocked) {
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
    // A mixed quiz has no checkpoint of its own. Drawing only from quizzes
    // already completed keeps the fact relevant and, more importantly, stops
    // the round-up spoiling a book the reader hasn't got to yet.
    final String? funFact = randomCheckpointFact(
      _completedQuiz,
      languageCode: Localizations.localeOf(context).languageCode,
    );
    bool earned = false;
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          title: l10n.homeReviewQuizTitle,
          questions: questions,
          funFact: funFact,
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

  /// No noteId: opens the editor on a brand-new note. Defaults to today's
  /// chapter (the same one shown on the "continue reading" card) rather than
  /// always Genesis 1 — a note written from the home screen should be about
  /// whatever the user is actually reading, not a hardcoded default. Only
  /// falls back to Genesis 1 when the whole Bible is already read, since
  /// there's no "next chapter" left to attach it to at that point.
  ///
  /// [book]/[chapter] let a caller link the note to a specific reading
  /// instead — the "write a reflection" prompt shown after a reading session
  /// needs that chapter, not whatever is next once it's marked read.
  Future<void> _openNotesEditor({String? book, int? chapter}) async {
    final _ChapterRef? current = _nextChapter;
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesScreen(
          dbService: _dbService,
          book: book ?? current?.book.id ?? kDefaultBook,
          chapter: chapter ?? current?.chapter ?? kDefaultChapter,
        ),
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
    if (!mounted) {
      return;
    }
    // Whatever's unlocked now has been seen — clears the trophy's dot even
    // if nothing else on the dashboard changed.
    final Set<String> unlockedIds = await _dbService
        .getUnlockedAchievementIds();
    await _dbService.saveAchievementsSeenCount(unlockedIds.length);
    await _refreshDashboard();
  }

  Future<void> _openStreakDetail() async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => StreakDetailScreen(
          streak: _streak,
          freezes: _streakState.freezes,
          recentReadingDays: _recentReadingDays,
          frozenDays: _frozenDays,
          lastReadAt: _lastReadAt,
        ),
      ),
    );
  }

  Future<void> _openNotesLibrary() async {
    final _ChapterRef? current = _nextChapter;
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesLibraryScreen(
          dbService: _dbService,
          book: current?.book.id ?? kDefaultBook,
          chapter: current?.chapter ?? kDefaultChapter,
        ),
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
          currentAppSkin: widget.currentAppSkin,
          onAppSkinChanged: widget.onAppSkinChanged,
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
    // Settings loads and saves the reading plan and resume point on its own
    // (they're not lifted into main.dart like the theme/skin/locale are), so
    // without this the dashboard kept showing whatever it had cached from
    // before the trip to Settings — a plan or resume-point change looked
    // like it did nothing until the app was restarted.
    await _refreshDashboard();
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
      return const _HomeScreenSkeleton();
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final bool readToday = _streakState.activeToday;
    final bool streakAtRisk = _streak > 0 && !_streakState.activeToday;
    final String reminderLabel = _reminders.isEmpty
        ? l10n.homeReminderConfigure
        : _reminders.length == 1
        ? l10n.homeReminderAt(_reminders.first.label)
        : l10n.homeRemindersActive(_reminders.length);
    final _ChapterRef? nextChapter = _nextChapter;
    final int chaptersRead = _coveredKeys.length;
    final Checkpoint? pendingCheckpoint = _pendingCheckpoint;

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
            icon: Badge(
              // No label: an empty Badge renders as a small dot rather than
              // a numbered pill — all this needs to say is "something's new".
              isLabelVisible: _hasNewAchievement,
              child: Icon(AppIcons.of(context).trophy),
            ),
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
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
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
            const SizedBox(height: 32),
            _SectionCard(
              title: l10n.homeSectionReadingTitle,
              subtitle: l10n.homeSectionReadingSubtitle,
              children: <Widget>[
                if (nextChapter != null)
                  _ContinueReadingCard(
                    key: _tourReadingKey,
                    reference:
                        '${localizedBookName(context, nextChapter.book)} ${nextChapter.chapter}',
                    canMarkRead:
                        _openedChapterKey ==
                        bibleChapterKey(
                          nextChapter.book.id,
                          nextChapter.chapter,
                        ),
                    onOpen: () =>
                        _openChapter(nextChapter.book.id, nextChapter.chapter),
                    onMarkRead: () => _markChapterRead(
                      nextChapter.book.id,
                      nextChapter.chapter,
                    ),
                    onWriteReflection: () => _openNotesEditor(
                      book: nextChapter.book.id,
                      chapter: nextChapter.chapter,
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
            const SizedBox(height: 24),
            _SectionCard(
              title: l10n.homeSectionProgressTitle,
              children: <Widget>[
                _ProgressCard(
                  key: _tourProgressKey,
                  streak: _streak,
                  totalReadings: _totalReadings,
                  totalStars: _totalStars,
                  chaptersRead: chaptersRead,
                  totalChapters: kTotalBibleChapters,
                  onOpenStreak: _openStreakDetail,
                  // The browser is where "readings" actually live — it marks
                  // every chapter already read.
                  onOpenReadings: _openBibleBrowser,
                  // Stars come from quizzes, and the achievements screen is
                  // where star milestones are tracked.
                  onOpenStars: _openAchievements,
                ),
              ],
            ),
            const SizedBox(height: 32),
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
      ),
    );
  }
}

/// Placeholder shown while [_HomeScreenState._bootstrap] is still running,
/// shaped like the real dashboard (hero, section cards, quick actions) with
/// a light sweeping across it — communicates "this is what's coming and
/// it's already working on it" rather than a blank spinner, and reaching the
/// screen's actual outline this fast is what keeps Android's own splash
/// screen from deciding the app is slow to start (see main.dart).
class _HomeScreenSkeleton extends StatefulWidget {
  const _HomeScreenSkeleton();

  @override
  State<_HomeScreenSkeleton> createState() => _HomeScreenSkeletonState();
}

class _HomeScreenSkeletonState extends State<_HomeScreenSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'JW Streak',
          style: TextStyle(
            fontFamily: 'PlusJakartaSans',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
        ),
      ),
      // Same width cap as the loaded home screen below: without it the
      // placeholder blocks span a tablet edge to edge, then visibly snap
      // inwards the moment the real content replaces them.
      body: ResponsiveBody(
        child: AnimatedBuilder(
          animation: _controller,
          // The shapes never change, only the shimmer sweeping over them —
          // built once and reused every tick instead of rebuilt ~60 times/sec.
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              _SkeletonBlock(height: 176, radius: 28),
              const SizedBox(height: 32),
              _SkeletonBlock(height: 214, radius: 24),
              const SizedBox(height: 24),
              _SkeletonBlock(height: 236, radius: 24),
              const SizedBox(height: 32),
              _SkeletonBlock(height: 20, width: 150, radius: 6),
              const SizedBox(height: 12),
              _SkeletonBlock(height: 74, radius: 16),
              const SizedBox(height: 10),
              _SkeletonBlock(height: 74, radius: 16),
              const SizedBox(height: 10),
              _SkeletonBlock(height: 74, radius: 16),
            ],
          ),
          builder: (BuildContext context, Widget? child) {
            return ShaderMask(
              blendMode: BlendMode.srcATop,
              shaderCallback: (Rect bounds) => LinearGradient(
                begin: const Alignment(-1, 0),
                end: const Alignment(1, 0),
                colors: <Color>[
                  cs.surfaceContainerHighest,
                  cs.surfaceContainerHigh,
                  cs.surfaceContainerHighest,
                ],
                stops: const <double>[0.35, 0.5, 0.65],
                transform: _SlidingGradientTransform(
                  slidePercent: _controller.value * 2 - 1,
                ),
              ).createShader(bounds),
              child: child,
            );
          },
        ),
      ),
    );
  }
}

/// Slides a [LinearGradient] horizontally by [slidePercent] of the shaded
/// bounds' width — the same technique the `shimmer` package uses, without
/// pulling in the dependency for one effect.
class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {ui.TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

class _SkeletonBlock extends StatelessWidget {
  const _SkeletonBlock({
    required this.height,
    this.width,
    required this.radius,
  });

  final double height;
  final double? width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
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
        border: Border.all(color: cs.outlineVariant.withValues(alpha: 0.6)),
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
                        Expanded(
                          // A plain Text here just ellipsizes when a longer
                          // greeting variant, in some language, at some
                          // system font size, doesn't fit — quietly cutting
                          // off the one thing this line exists to say.
                          // MarqueeText only starts scrolling when that
                          // actually happens; otherwise it behaves exactly
                          // like the Text it replaced.
                          child: MarqueeText(
                            text: greeting,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: cs.onPrimaryContainer.withValues(
                                alpha: 0.85,
                              ),
                              fontWeight: FontWeight.w600,
                            ),
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
                        // Flexible rather than a fixed size: "To read today"
                        // is long enough that on a narrow phone it plus the
                        // freeze pill next to it can overflow the card's
                        // width — this lets the status pill's own text
                        // ellipsize instead.
                        Flexible(child: _StatusPill(readToday: readToday)),
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
          MatchstickIcon(size: 16, color: cs.onPrimaryContainer),
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
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: cs.onPrimaryContainer,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
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
    final int displayedStreak = _pranked ? -100 : widget.streak;
    return _StreakBadge(
      streak: displayedStreak,
      onIconTapEasterEgg: () {
        LocalDbService().markEasterEggFound('flame');
        setState(() => _pranked = true);
      },
    );
  }
}

/// The big number at the top right of the home hero.
///
/// A burning streak gets a flickering flame; a streak of zero gets a
/// snowflake instead — a dead flame reads as "broken", a frozen one reads as
/// "waiting to be lit again", which is the truer message when someone has
/// just lost their run. Also covers the negative numbers the flame easter egg
/// can produce.
class _StreakBadge extends StatefulWidget {
  const _StreakBadge({required this.streak, required this.onIconTapEasterEgg});

  final int streak;

  /// Fired by the shared tap-8-times gesture, scoped to just the icon below
  /// (see build()) — the shake it plays should not also jostle the number.
  final VoidCallback onIconTapEasterEgg;

  @override
  State<_StreakBadge> createState() => _StreakBadgeState();
}

class _StreakBadgeState extends State<_StreakBadge>
    with SingleTickerProviderStateMixin {
  // Frost turns much more slowly than fire flickers.
  static const Duration _fireLoop = Duration(milliseconds: 4200);
  static const Duration _frostLoop = Duration(milliseconds: 9000);
  // The flame keeps flickering forever (that's what makes it read as
  // "alive"), but a snowflake spinning on and on starts to feel like it's
  // stuck rather than decorative — a handful of slow turns reads as a
  // deliberate flourish, then it settles.
  static const int _frostSpins = 4;

  late final AnimationController _controller;

  bool get _frozen => widget.streak <= 0;

  @override
  void initState() {
    super.initState();
    // A single, continuously-looping (non-reversing) controller. Driving
    // several sine waves of different frequencies off one linear value gives
    // an organic, non-mechanical motion instead of a ping-pong tween.
    _controller = AnimationController(
      vsync: this,
      duration: _frozen ? _frostLoop : _fireLoop,
    );
    _repeat();
  }

  void _repeat() {
    if (_frozen) {
      _controller.repeat(count: _frostSpins);
    } else {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(_StreakBadge oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Crossing zero (first read of the day, or the easter egg firing) swaps
    // which animation is playing, so the loop length has to follow.
    final Duration wanted = _frozen ? _frostLoop : _fireLoop;
    if (_controller.duration != wanted) {
      _controller.duration = wanted;
      _repeat();
    }
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
          // Scoped to just the icon: the tap-8-times shake should jostle the
          // flame/snowflake, not the streak number sitting below it.
          TapEasterEgg(
            onTriggered: widget.onIconTapEasterEgg,
            child: SizedBox(
              width: 108,
              height: 108,
              // Isolates this perpetually-animating subtree so it doesn't
              // force repaints of the rest of the (potentially long) home
              // screen list around it.
              child: RepaintBoundary(
                child: AnimatedBuilder(
                  animation: _controller,
                  // The shader + icon never actually change — only the
                  // Transform wrapping them does — so it's passed as `child`
                  // instead of being rebuilt on every one of the ~60 ticks/sec.
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      final Color activeColor = AppIcons.of(
                        context,
                      ).activeColor;
                      return LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        // A 3-stop ramp lightening toward white, generated
                        // from the skin's own activeColor rather than a
                        // fixed orange/amber pair — otherwise a wave or a
                        // sparkle would still get painted like fire.
                        colors: _frozen
                            ? const <Color>[
                                Color(0xFF2196F3), // blue
                                Color(0xFF4FC3F7), // light blue
                                Color(0xFFB3E5FC), // near-white ice
                              ]
                            : <Color>[
                                activeColor,
                                Color.lerp(activeColor, Colors.white, 0.35)!,
                                Color.lerp(activeColor, Colors.white, 0.65)!,
                              ],
                      ).createShader(rect);
                    },
                    child: Icon(
                      _frozen
                          ? AppIcons.of(context).frozen
                          : AppIcons.of(context).flame,
                      size: _frozen ? 78 : 92,
                      color: Colors.white,
                    ),
                  ),
                  builder: (BuildContext context, Widget? child) {
                    final double t = _controller.value * 2 * math.pi;
                    return _frozen
                        ? _buildFrost(t, child!)
                        : _buildActive(context, t, child!);
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Transform.translate(
            // Pull the number ~3mm closer to the icon above it.
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

  /// The glow halo is shared by every skin — only its color and the icon's
  /// own motion (see [AppIcons.activeMotion]) actually vary. Frequencies in
  /// the glow pulse are integer multiples of the base loop so it lands back
  /// exactly where it started when the controller wraps from 1.0 to 0.0 —
  /// otherwise the loop restart shows a visible jump.
  Widget _buildActive(BuildContext context, double t, Widget icon) {
    final Color activeColor = AppIcons.of(context).activeColor;
    final double glow = 0.5 + 0.5 * math.sin(t * 2);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 80 + 18 * glow,
          height: 80 + 18 * glow,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                activeColor.withValues(alpha: 0.35 * glow),
                activeColor.withValues(alpha: 0),
              ],
            ),
          ),
        ),
        AppIcons.of(context).activeMotion(t, icon),
      ],
    );
  }

  /// Frost: one slow, complete turn per loop (seamless by construction) with
  /// a shallow breath. Deliberately calmer than the flame — nothing here
  /// should look like it's struggling to stay alive.
  Widget _buildFrost(double t, Widget icon) {
    final double shimmer = 0.5 + 0.5 * math.sin(t * 2);
    final double scale = 1.0 + 0.03 * math.sin(t * 2);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 74 + 14 * shimmer,
          height: 74 + 14 * shimmer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: <Color>[
                const Color(0xFF4FC3F7).withValues(alpha: 0.30 * shimmer),
                const Color(0xFF4FC3F7).withValues(alpha: 0),
              ],
            ),
          ),
        ),
        Transform.rotate(
          angle: t,
          child: Transform.scale(scale: scale, child: icon),
        ),
      ],
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
      padding: const EdgeInsets.all(14),
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
            if (i != children.length - 1) const SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class _ContinueReadingCard extends StatefulWidget {
  const _ContinueReadingCard({
    super.key,
    required this.reference,
    required this.canMarkRead,
    required this.onOpen,
    required this.onMarkRead,
    required this.onWriteReflection,
  });

  final String reference;

  /// Whether "Open" has been tapped for this exact chapter yet — until it
  /// has, "Mark as read" stays disabled rather than letting someone tick a
  /// chapter off without having actually gone to read it.
  final bool canMarkRead;
  final VoidCallback onOpen;
  final VoidCallback onMarkRead;
  final VoidCallback onWriteReflection;

  @override
  State<_ContinueReadingCard> createState() => _ContinueReadingCardState();
}

class _ContinueReadingCardState extends State<_ContinueReadingCard>
    with SingleTickerProviderStateMixin {
  /// Nudges "Open" when someone taps "Mark as read" too early. Disabling the
  /// button alone gives no feedback at all — the tap just does nothing, which
  /// reads as broken rather than as "read it first".
  late final AnimationController _openNudge = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  @override
  void dispose() {
    _openNudge.dispose();
    super.dispose();
  }

  void _nudgeOpen() => _openNudge.forward(from: 0);

  /// A few quick oscillations that fade out — enough to catch the eye and
  /// point at "Open" without turning into an alarm. Amplitude decays with
  /// the animation so it settles exactly back to 0.
  static double _nudgeOffset(double t) =>
      t == 0 ? 0 : math.sin(t * math.pi * 6) * 6 * (1 - t);

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
      // No card-wide onTap: it used to open the chapter from anywhere on the
      // card, but that put a tappable ancestor behind the "Mark as read"
      // button — when that button is disabled (no tap recognizer of its
      // own), the tap fell through to this ancestor and fired onOpen
      // instead of doing nothing. Three explicit buttons already cover
      // every action the card offers, so the whole-card shortcut isn't
      // worth that failure mode.
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: cs.primaryContainer,
                    // 44/14 is the leading-icon size used by every other
                    // list-item card in the app (achievements, quick
                    // actions) — matches that instead of its own one-off.
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    AppIcons.of(context).reading,
                    color: cs.onPrimaryContainer,
                    size: 22,
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
                        widget.reference,
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
                  // Transform.translate only moves paint, never layout, so
                  // the shake can't disturb the row it sits in.
                  child: AnimatedBuilder(
                    key: const Key('homeOpenNudge'),
                    animation: _openNudge,
                    builder: (BuildContext context, Widget? child) =>
                        Transform.translate(
                          offset: Offset(_nudgeOffset(_openNudge.value), 0),
                          child: child,
                        ),
                    child: FilledButton.icon(
                      onPressed: widget.onOpen,
                      icon: Icon(AppIcons.of(context).book, size: 18),
                      // Some translations ("Segna come letto") don't fit this
                      // half-width slot on one line at full size; scaling
                      // down instead of wrapping keeps it on a single line
                      // without cutting any of it off like ellipsis would.
                      label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(l10n.homeOpenButton, maxLines: 1),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  // A disabled button swallows the tap silently. Catching it
                  // here is what lets the early tap answer back by pointing
                  // at "Open" instead of appearing to do nothing.
                  child: GestureDetector(
                    // Transparent once the button is live: deferToChild with
                    // no callback leaves hit-testing exactly as it was.
                    behavior: widget.canMarkRead
                        ? HitTestBehavior.deferToChild
                        : HitTestBehavior.opaque,
                    onTap: widget.canMarkRead ? null : _nudgeOpen,
                    child: FilledButton.tonalIcon(
                      // Disabled until "Open" has been tapped for this
                      // chapter — otherwise there's nothing stopping a
                      // chapter being ticked off without ever having been
                      // read.
                      onPressed: widget.canMarkRead ? widget.onMarkRead : null,
                      icon: const Icon(Icons.check_circle_outline, size: 18),
                      label: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(l10n.homeMarkReadButton, maxLines: 1),
                      ),
                      // The default tonal secondaryContainer pairing reads too
                      // faint sitting on this card's own light-blue tint;
                      // secondary/onSecondary is the same family but a solid,
                      // higher-contrast step darker. Standard Material
                      // disabled-state opacities (12%/38%) substitute in by
                      // hand since a flat color here isn't state-aware on its
                      // own the way the theme's default would be.
                      style: FilledButton.styleFrom(
                        backgroundColor: widget.canMarkRead
                            ? cs.secondary
                            : cs.onSurface.withValues(alpha: 0.12),
                        foregroundColor: widget.canMarkRead
                            ? cs.onSecondary
                            : cs.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: widget.onWriteReflection,
                icon: Icon(AppIcons.of(context).notes, size: 18),
                label: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(l10n.homeWriteReflectionButton, maxLines: 1),
                ),
              ),
            ),
          ],
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
            Icon(AppIcons.of(context).trophy, color: cs.onPrimaryContainer),
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
                      // bodyMedium, not bodySmall: this is a warning someone
                      // needs to actually read, not a caption — matches the
                      // subtitle size used by every other list-row-with-
                      // description in the app (achievements, reminders).
                      style: theme.textTheme.bodyMedium?.copyWith(
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
                icon: Icon(AppIcons.of(context).flame, size: 18),
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
                  AppIcons.of(context).quiz,
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
    required this.chaptersRead,
    required this.totalChapters,
    required this.onOpenStreak,
    required this.onOpenReadings,
    required this.onOpenStars,
  });

  final int streak;
  final int totalReadings;
  final int totalStars;
  final int chaptersRead;
  final int totalChapters;
  final VoidCallback onOpenStreak;
  final VoidCallback onOpenReadings;
  final VoidCallback onOpenStars;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final double progress = totalChapters == 0
        ? 0
        : chaptersRead / totalChapters;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // IntrinsicHeight: a plain Row doesn't stretch siblings to match each
        // other, only to fill it in the cross axis if told to — so a label
        // that wraps to two lines in one locale ("giorni di serie" in
        // Italian) used to make just that tile taller than the other two
        // instead of all three growing together.
        IntrinsicHeight(
          child: Row(
            // IntrinsicHeight only makes the Row itself as tall as its
            // tallest child — Row's own default (center) then leaves the
            // shorter tiles floating in the middle of that height instead of
            // filling it, which is what actually looked like a size
            // mismatch: the tall tile flush at the top, the other two
            // vertically centered with blank space above and below.
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: _StatTile(
                  // Matches the hero badge above: a live streak is a flame, a
                  // streak of zero is frozen rather than "still on fire at 0".
                  icon: ({required double size, required Color color}) => Icon(
                    streak > 0
                        ? AppIcons.of(context).flame
                        : AppIcons.of(context).frozen,
                    size: size,
                    color: color,
                  ),
                  value: '$streak',
                  label: streak != 1
                      ? l10n.homeStatStreakDaysPlural
                      : l10n.homeStatStreakDaySingular,
                  // A literal fire color rather than cs.tertiary: this app's
                  // seed color generates a muted mauve tertiary, nowhere
                  // near the orange/red a flame needs to read at a glance.
                  // deepOrange also matches the flame gradient used on the
                  // easter-egg icon above, so the two stay in the same
                  // family instead of picking a fresh color.
                  color: streak > 0 ? Colors.deepOrange : Colors.lightBlue,
                  onTap: onOpenStreak,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: ({required double size, required Color color}) =>
                      Icon(AppIcons.of(context).book, size: size, color: color),
                  value: '$totalReadings',
                  label: totalReadings != 1
                      ? l10n.homeStatReadingsPlural
                      : l10n.homeStatReadingSingular,
                  color: cs.primary,
                  onTap: onOpenReadings,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatTile(
                  icon: ({required double size, required Color color}) =>
                      AppIcons.of(context).reward(size: size, color: color),
                  value: '$totalStars',
                  label: AppIcons.of(
                    context,
                  ).rewardNoun(context, plural: totalStars != 1),
                  color: AppIcons.of(context).rewardColor,
                  onTap: onOpenStars,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _BibleProgressIndicator(
          progress: progress,
          chaptersRead: chaptersRead,
          totalChapters: totalChapters,
        ),
      ],
    );
  }
}

class _BibleProgressIndicator extends StatelessWidget {
  const _BibleProgressIndicator({
    required this.progress,
    required this.chaptersRead,
    required this.totalChapters,
  });

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
                // One decimal place so early progress isn't stuck at "0 %"
                // for dozens of chapters — 1,189 total means each single
                // chapter only moves the rounded integer every ~12 of them.
                // Locale-aware separator: a comma in French, a dot in
                // English, rather than hardcoding either.
                '${NumberFormat('#,##0.0', Localizations.localeOf(context).toString()).format(progress * 100)} %',
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
    required this.onTap,
  });

  final Widget Function({required double size, required Color color}) icon;
  final String value;
  final String label;
  final Color color;

  /// Each stat opens the screen that number comes from. These tiles already
  /// looked tappable (they share the app's card shape), and people kept
  /// trying — so they lead somewhere instead of being flattened to look inert.
  final VoidCallback onTap;

  static const BorderRadius _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Material(
      color: cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: cs.outlineVariant),
      ),
      // Clips the banner below to the card's own rounded corners — without
      // this its top corners would be square and poke past the card's
      // outline.
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // A solid, edge-to-edge color block reads as a much clearer
            // signal for "this tile is about fire/reading/stars" than the
            // small 16%-tinted icon square this replaces — that washed out
            // against the card instead of standing out.
            Container(
              height: 52,
              width: double.infinity,
              color: color,
              alignment: Alignment.center,
              child: icon(size: 26, color: Colors.white),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    label,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // A step up from bodySmall and a touch heavier — same
                    // layout, just easier to read at a glance.
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: cs.onSurfaceVariant,
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
          // Same palette as onboarding (OnboardingAccent) rather than a new
          // one — these three tiles used to share one flat secondaryContainer
          // tint, which read as one indistinct block instead of three
          // separate actions.
          accent: kAccentAmber,
          title: l10n.homeDailyTextTitle,
          subtitle: l10n.homeDailyTextSubtitle,
          onTap: onOpenDailyText,
        ),
        const SizedBox(height: 10),
        _QuickActionTile(
          icon: AppIcons.of(context).notes,
          accent: kAccentTeal,
          title: l10n.homeWriteNoteTitle,
          subtitle: l10n.homeWriteNoteSubtitle,
          onTap: onWriteNote,
        ),
        const SizedBox(height: 10),
        _QuickActionTile(
          icon: Icons.menu_book_outlined,
          accent: kAccentPurple,
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
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final OnboardingAccent accent;
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
      // Explicit radius matching the other leading-icon list card on this
      // screen (_ContinueReadingCard) instead of Card's own implicit default.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: accent.background(context),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: accent.foreground(context).withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(icon, color: accent.foreground(context), size: 22),
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
                      // Matches _AchievementTile's and ReminderRow's subtitle
                      // size — this screen had drifted to one size smaller
                      // for what's structurally the same list-row shape.
                      style: theme.textTheme.bodyMedium?.copyWith(
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
