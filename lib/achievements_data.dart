import 'package:flutter/material.dart';

/// Snapshot of the stats achievements are evaluated against. Built once per
/// dashboard refresh from data already gathered elsewhere (readings, quiz
/// results, streak, notes, reminders) — no achievement-specific DB reads.
class AchievementStats {
  const AchievementStats({
    required this.chaptersRead,
    required this.distinctBooksRead,
    required this.genesisComplete,
    required this.wholeBibleComplete,
    required this.completedQuizzes,
    required this.hasPerfectQuiz,
    required this.totalStars,
    required this.currentStreak,
    required this.notesCount,
    required this.hasReminder,
    required this.easterEggsFound,
  });

  final int chaptersRead;
  final int distinctBooksRead;
  final bool genesisComplete;
  final bool wholeBibleComplete;
  final int completedQuizzes;
  final bool hasPerfectQuiz;
  final int totalStars;
  final int currentStreak;
  final int notesCount;
  final bool hasReminder;

  /// How many of [kEasterEggIds] the user has triggered at least once.
  final int easterEggsFound;
}

/// Every secret the app currently has, in one place so the "found them all"
/// achievement's goal can never drift out of sync with reality. Add a new
/// egg's id here the moment it's wired up (see `LocalDbService.markEasterEggFound`).
const List<String> kEasterEggIds = <String>['heart', 'flame', 'version'];

enum AchievementCategory { reading, quizzes, streak, other }

/// Static definition of one achievement: how it's unlocked and, for
/// numeric goals, how to render its progress (e.g. "23 / 50").
class AchievementDef {
  const AchievementDef({
    required this.id,
    required this.icon,
    required this.category,
    required this.isMet,
    this.goal,
    this.progress,
    this.starReward = 0,
  });

  /// Stable id, persisted in the DB once unlocked so it stays unlocked even
  /// if the underlying stat later regresses (e.g. the streak resets).
  final String id;
  final IconData icon;
  final AchievementCategory category;
  final bool Function(AchievementStats stats) isMet;

  /// Target value for a numeric progress fraction; null for a plain
  /// boolean (all-or-nothing) achievement.
  final int? goal;
  final int Function(AchievementStats stats)? progress;

  /// Bonus stars added to the home screen's total the moment this unlocks,
  /// scaled to how hard it is to earn. Zero for `stars_20`/`stars_40`
  /// specifically: those two unlock *by* reaching a star total, so having
  /// them also grant stars would let unlocking one nudge you toward the
  /// other for free rather than through actual quiz play.
  final int starReward;
}

// Not `const`: the easter-eggs achievement's goal reads kEasterEggIds.length,
// and List.length isn't a const-evaluable expression in Dart.
final List<AchievementDef> kAchievementDefs = <AchievementDef>[
  AchievementDef(
    id: 'first_chapter',
    starReward: 1,
    icon: Icons.auto_stories_outlined,
    category: AchievementCategory.reading,
    isMet: _firstChapter,
  ),
  AchievementDef(
    id: 'chapters_10',
    starReward: 2,
    icon: Icons.menu_book_outlined,
    category: AchievementCategory.reading,
    isMet: _chapters10,
    goal: 10,
    progress: _chaptersReadProgress,
  ),
  AchievementDef(
    id: 'chapters_50',
    starReward: 3,
    icon: Icons.local_library_outlined,
    category: AchievementCategory.reading,
    isMet: _chapters50,
    goal: 50,
    progress: _chaptersReadProgress,
  ),
  AchievementDef(
    id: 'chapters_150',
    starReward: 5,
    icon: Icons.auto_stories_rounded,
    category: AchievementCategory.reading,
    isMet: _chapters150,
    goal: 150,
    progress: _chaptersReadProgress,
  ),
  AchievementDef(
    id: 'genesis_complete',
    starReward: 3,
    icon: Icons.terrain_outlined,
    category: AchievementCategory.reading,
    isMet: _genesisComplete,
  ),
  AchievementDef(
    id: 'whole_bible',
    starReward: 10,
    icon: Icons.public,
    category: AchievementCategory.reading,
    isMet: _wholeBibleComplete,
  ),
  AchievementDef(
    id: 'explorer_5books',
    starReward: 2,
    icon: Icons.travel_explore_rounded,
    category: AchievementCategory.reading,
    isMet: _explorer5Books,
    goal: 5,
    progress: _distinctBooksProgress,
  ),
  AchievementDef(
    id: 'first_quiz',
    starReward: 1,
    icon: Icons.quiz_outlined,
    category: AchievementCategory.quizzes,
    isMet: _firstQuiz,
  ),
  AchievementDef(
    id: 'quizzes_5',
    starReward: 2,
    icon: Icons.school_outlined,
    category: AchievementCategory.quizzes,
    isMet: _quizzes5,
    goal: 5,
    progress: _completedQuizzesProgress,
  ),
  AchievementDef(
    id: 'quizzes_25',
    starReward: 3,
    icon: Icons.psychology_outlined,
    category: AchievementCategory.quizzes,
    isMet: _quizzes25,
    goal: 25,
    progress: _completedQuizzesProgress,
  ),
  AchievementDef(
    id: 'quizzes_40',
    starReward: 5,
    icon: Icons.military_tech_outlined,
    category: AchievementCategory.quizzes,
    isMet: _quizzes40,
    goal: 40,
    progress: _completedQuizzesProgress,
  ),
  AchievementDef(
    id: 'perfect_quiz',
    starReward: 2,
    icon: Icons.workspace_premium_outlined,
    category: AchievementCategory.quizzes,
    isMet: _perfectQuiz,
  ),
  AchievementDef(
    id: 'stars_20',
    icon: Icons.star_rounded,
    category: AchievementCategory.quizzes,
    isMet: _stars20,
    goal: 20,
    progress: _totalStarsProgress,
  ),
  AchievementDef(
    id: 'stars_40',
    icon: Icons.auto_awesome_rounded,
    category: AchievementCategory.quizzes,
    isMet: _stars40,
    goal: 40,
    progress: _totalStarsProgress,
  ),
  AchievementDef(
    id: 'streak_7',
    starReward: 2,
    icon: Icons.local_fire_department_rounded,
    category: AchievementCategory.streak,
    isMet: _streak7,
    goal: 7,
    progress: _currentStreakProgress,
  ),
  AchievementDef(
    id: 'streak_30',
    starReward: 4,
    icon: Icons.whatshot_rounded,
    category: AchievementCategory.streak,
    isMet: _streak30,
    goal: 30,
    progress: _currentStreakProgress,
  ),
  AchievementDef(
    id: 'streak_180',
    starReward: 10,
    icon: Icons.local_fire_department_rounded,
    category: AchievementCategory.streak,
    isMet: _streak180,
    goal: 180,
    progress: _currentStreakProgress,
  ),
  AchievementDef(
    id: 'first_note',
    starReward: 1,
    icon: Icons.edit_note_outlined,
    category: AchievementCategory.other,
    isMet: _firstNote,
  ),
  AchievementDef(
    id: 'notes_10',
    starReward: 2,
    icon: Icons.library_books_outlined,
    category: AchievementCategory.other,
    isMet: _notes10,
    goal: 10,
    progress: _notesCountProgress,
  ),
  AchievementDef(
    id: 'reminder_set',
    starReward: 1,
    icon: Icons.notifications_active_outlined,
    category: AchievementCategory.other,
    isMet: _reminderSet,
  ),
  AchievementDef(
    id: 'easter_eggs_all',
    starReward: 3,
    icon: Icons.auto_fix_high_rounded,
    category: AchievementCategory.other,
    isMet: _easterEggsAll,
    goal: kEasterEggIds.length,
    progress: _easterEggsProgress,
  ),
];

bool _firstChapter(AchievementStats s) => s.chaptersRead >= 1;
bool _chapters10(AchievementStats s) => s.chaptersRead >= 10;
bool _chapters50(AchievementStats s) => s.chaptersRead >= 50;
bool _chapters150(AchievementStats s) => s.chaptersRead >= 150;
bool _genesisComplete(AchievementStats s) => s.genesisComplete;
bool _wholeBibleComplete(AchievementStats s) => s.wholeBibleComplete;
bool _explorer5Books(AchievementStats s) => s.distinctBooksRead >= 5;
bool _firstQuiz(AchievementStats s) => s.completedQuizzes >= 1;
bool _quizzes5(AchievementStats s) => s.completedQuizzes >= 5;
bool _quizzes25(AchievementStats s) => s.completedQuizzes >= 25;
bool _quizzes40(AchievementStats s) => s.completedQuizzes >= 40;
bool _perfectQuiz(AchievementStats s) => s.hasPerfectQuiz;
bool _stars20(AchievementStats s) => s.totalStars >= 20;
bool _stars40(AchievementStats s) => s.totalStars >= 40;
bool _streak7(AchievementStats s) => s.currentStreak >= 7;
bool _streak30(AchievementStats s) => s.currentStreak >= 30;
bool _streak180(AchievementStats s) => s.currentStreak >= 180;
bool _firstNote(AchievementStats s) => s.notesCount >= 1;
bool _notes10(AchievementStats s) => s.notesCount >= 10;
bool _reminderSet(AchievementStats s) => s.hasReminder;
bool _easterEggsAll(AchievementStats s) =>
    s.easterEggsFound >= kEasterEggIds.length;

int _chaptersReadProgress(AchievementStats s) => s.chaptersRead;
int _distinctBooksProgress(AchievementStats s) => s.distinctBooksRead;
int _completedQuizzesProgress(AchievementStats s) => s.completedQuizzes;
int _totalStarsProgress(AchievementStats s) => s.totalStars;
int _currentStreakProgress(AchievementStats s) => s.currentStreak;
int _notesCountProgress(AchievementStats s) => s.notesCount;
int _easterEggsProgress(AchievementStats s) => s.easterEggsFound;

/// Sum of [AchievementDef.starReward] over every id in [unlockedIds]. This is
/// additive on top of quiz-earned stars, not part of [AchievementStats] —
/// keeping it separate means `stars_20`/`stars_40` still evaluate against
/// quiz stars alone, unaffected by however many bonus stars other
/// achievements have already handed out.
int achievementBonusStars(Set<String> unlockedIds) => kAchievementDefs
    .where((AchievementDef def) => unlockedIds.contains(def.id))
    .fold(0, (int sum, AchievementDef def) => sum + def.starReward);

/// Sum of every [AchievementDef.starReward], i.e. the bonus total a user
/// would have if every star-rewarding achievement were unlocked. Lets a
/// "stars earned" display add its max alongside [achievementBonusStars]'s
/// earned, instead of only widening the numerator and never the denominator.
int maxAchievementBonusStars() => kAchievementDefs.fold(
  0,
  (int sum, AchievementDef def) => sum + def.starReward,
);
