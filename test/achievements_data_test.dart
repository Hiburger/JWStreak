import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/achievements_data.dart';

void main() {
  test('every achievement id is unique', () {
    final List<String> ids = kAchievementDefs
        .map((AchievementDef d) => d.id)
        .toList(growable: false);
    expect(ids.toSet().length, ids.length, reason: 'duplicate achievement id');
  });

  test('numeric-goal achievements have a matching progress function', () {
    for (final AchievementDef def in kAchievementDefs) {
      if (def.goal != null) {
        expect(
          def.progress,
          isNotNull,
          reason: '${def.id} has a goal but no progress function',
        );
      }
    }
  });

  test('the easter-eggs achievement goal tracks kEasterEggIds', () {
    final AchievementDef def = kAchievementDefs.firstWhere(
      (AchievementDef d) => d.id == 'easter_eggs_all',
    );
    expect(def.goal, kEasterEggIds.length);
  });

  test(
    'an all-zero stats snapshot meets nothing except boolean-false checks',
    () {
      const AchievementStats empty = AchievementStats(
        chaptersRead: 0,
        distinctBooksRead: 0,
        genesisComplete: false,
        wholeBibleComplete: false,
        completedQuizzes: 0,
        hasPerfectQuiz: false,
        totalStars: 0,
        currentStreak: 0,
        notesCount: 0,
        hasReminder: false,
        easterEggsFound: 0,
      );
      for (final AchievementDef def in kAchievementDefs) {
        expect(
          def.isMet(empty),
          isFalse,
          reason: '${def.id} met by empty stats',
        );
      }
    },
  );

  test('a maxed-out stats snapshot meets every achievement', () {
    final AchievementStats maxed = AchievementStats(
      chaptersRead: 100000,
      distinctBooksRead: 66,
      genesisComplete: true,
      wholeBibleComplete: true,
      completedQuizzes: 1000,
      hasPerfectQuiz: true,
      totalStars: 100000,
      currentStreak: 100000,
      notesCount: 1000,
      hasReminder: true,
      easterEggsFound: kEasterEggIds.length,
    );
    for (final AchievementDef def in kAchievementDefs) {
      expect(
        def.isMet(maxed),
        isTrue,
        reason: '${def.id} not met by maxed stats',
      );
    }
  });
}
