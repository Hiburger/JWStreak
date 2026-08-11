import 'package:flutter/material.dart';

import 'bible_data.dart';
import 'l10n/app_localizations.dart';

/// The order in which the app hands out chapters.
///
/// Reading "the whole Bible" is not one route. Someone working through it
/// cover to cover, someone following the story as it happened, and someone
/// who wants a Hebrew and a Greek Scriptures chapter side by side are all
/// reading the same 1,189 chapters in a different sequence — so the sequence
/// is data, and everything that asks "what's next?" reads it from here rather
/// than assuming Genesis-to-Revelation.
enum ReadingPlan {
  /// Genesis to Revelation, the order the books are printed in.
  canonical,

  /// Roughly the order the events happened.
  chronological,

  /// Roughly the order the books were finished being written.
  completion,

  /// Hebrew and Christian Greek Scriptures woven together.
  hebrewGreekMix,

  /// Rotates between law, history, poetry, prophecy, gospels and letters.
  thematic,
}

/// One chapter's slot in a plan.
@immutable
class PlanChapter {
  const PlanChapter(this.book, this.chapter);

  final BibleBook book;
  final int chapter;

  String get key => bibleChapterKey(book.id, chapter);
}

final Map<String, BibleBook> _booksById = <String, BibleBook>{
  for (final BibleBook b in kBibleBooks) b.id: b,
};

/// Roughly when the events a book narrates took place.
///
/// Book-level only. A stricter chronological plan would interleave at the
/// passage level — Job somewhere inside Genesis, individual psalms next to
/// the events in Samuel and Kings — but that needs a per-passage dating table
/// to maintain, and a wrong verse range is worse than an honest approximation
/// at the book boundary. Prophets sit next to the reigns they spoke into.
const List<String> _kChronologicalOrder = <String>[
  'Genesis', 'Job', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy',
  'Joshua', 'Judges', 'Ruth', '1 Samuel', 'Psalms', '2 Samuel',
  'Proverbs', 'Ecclesiastes', 'Song of Solomon', '1 Kings', '1 Chronicles',
  '2 Chronicles', 'Obadiah', 'Jonah', 'Joel', 'Amos', 'Hosea', 'Isaiah',
  'Micah', 'Nahum', 'Zephaniah', 'Habakkuk', 'Jeremiah', '2 Kings',
  'Lamentations', 'Ezekiel', 'Daniel', 'Ezra', 'Haggai', 'Zechariah',
  'Esther', 'Nehemiah', 'Malachi',
  // Greek Scriptures: the life of Jesus, then the spread of the
  // congregation, with each letter sitting near the point in Acts it was
  // written from, and the vision that closes the record last.
  'Matthew', 'Mark', 'Luke', 'John', 'Acts', 'James', '1 Thessalonians',
  '2 Thessalonians', 'Galatians', '1 Corinthians', '2 Corinthians',
  'Romans', 'Ephesians', 'Philippians', 'Colossians', 'Philemon',
  'Hebrews', '1 Timothy', 'Titus', '1 Peter', '2 Peter', '2 Timothy',
  'Jude', '1 John', '2 John', '3 John', 'Revelation',
];

/// Roughly the order the books were completed.
///
/// Follows the writing-completion dates tabulated in the "All Scripture Is
/// Inspired of God and Beneficial" appendix, which is the chronology this
/// app's readers will recognise. Several books share a date there, so ties
/// are broken by canonical order rather than invented precision.
const List<String> _kCompletionOrder = <String>[
  'Genesis',
  'Exodus',
  'Leviticus',
  'Job',
  'Numbers',
  'Deuteronomy',
  'Joshua',
  'Judges',
  'Ruth',
  'Song of Solomon',
  '1 Samuel',
  '2 Samuel',
  'Ecclesiastes',
  'Jonah',
  'Joel',
  'Amos',
  'Hosea',
  'Isaiah',
  'Micah',
  'Proverbs',
  'Zephaniah',
  'Nahum',
  'Habakkuk',
  'Lamentations',
  'Obadiah',
  'Ezekiel',
  '1 Kings',
  '2 Kings',
  'Jeremiah',
  'Daniel',
  'Haggai',
  'Zechariah',
  'Esther',
  '1 Chronicles',
  '2 Chronicles',
  'Ezra',
  'Psalms',
  'Nehemiah',
  'Malachi',
  'Matthew',
  '1 Thessalonians',
  '2 Thessalonians',
  'Galatians',
  '1 Corinthians',
  '2 Corinthians',
  'Romans',
  'Luke',
  'Ephesians',
  'Colossians',
  'Philemon',
  'Philippians',
  'Hebrews',
  'Acts',
  'James',
  'Mark',
  '1 Timothy',
  'Titus',
  '1 Peter',
  '2 Peter',
  '2 Timothy',
  'Jude',
  'Revelation',
  'John',
  '1 John',
  '2 John',
  '3 John',
];

/// The buckets the thematic plan rotates between, in the order a day cycles
/// through them. Each bucket keeps its own canonical order internally.
const Map<String, List<String>> _kThemeGroups = <String, List<String>>{
  'law': <String>['Genesis', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy'],
  'history': <String>[
    'Joshua',
    'Judges',
    'Ruth',
    '1 Samuel',
    '2 Samuel',
    '1 Kings',
    '2 Kings',
    '1 Chronicles',
    '2 Chronicles',
    'Ezra',
    'Nehemiah',
    'Esther',
    'Acts',
  ],
  'poetry': <String>[
    'Job',
    'Psalms',
    'Proverbs',
    'Ecclesiastes',
    'Song of Solomon',
  ],
  'prophecy': <String>[
    'Isaiah',
    'Jeremiah',
    'Lamentations',
    'Ezekiel',
    'Daniel',
    'Hosea',
    'Joel',
    'Amos',
    'Obadiah',
    'Jonah',
    'Micah',
    'Nahum',
    'Habakkuk',
    'Zephaniah',
    'Haggai',
    'Zechariah',
    'Malachi',
    'Revelation',
  ],
  'gospels': <String>['Matthew', 'Mark', 'Luke', 'John'],
  'letters': <String>[
    'Romans',
    '1 Corinthians',
    '2 Corinthians',
    'Galatians',
    'Ephesians',
    'Philippians',
    'Colossians',
    '1 Thessalonians',
    '2 Thessalonians',
    '1 Timothy',
    '2 Timothy',
    'Titus',
    'Philemon',
    'Hebrews',
    'James',
    '1 Peter',
    '2 Peter',
    '1 John',
    '2 John',
    '3 John',
    'Jude',
  ],
};

List<PlanChapter> _expand(List<String> bookIds) {
  final List<PlanChapter> out = <PlanChapter>[];
  for (final String id in bookIds) {
    final BibleBook book = _booksById[id]!;
    for (int c = 1; c <= book.chapters; c++) {
      out.add(PlanChapter(book, c));
    }
  }
  return out;
}

/// Interleaves several sequences so they all run out at roughly the same
/// point, rather than in strict rotation.
///
/// Strict alternation looks fairer but isn't: the Greek Scriptures are 260
/// chapters against the Hebrew Scriptures' 929, so one-for-one would finish
/// the Greek Scriptures a third of the way in and leave 669 chapters with no
/// mix left in them at all — the exact thing someone picking a mixed plan is
/// trying to avoid. Spacing each stream across the whole run instead keeps
/// every stream alive from the first day to the last.
List<PlanChapter> _weave(List<List<PlanChapter>> streams) {
  final List<({double at, int stream, PlanChapter chapter})> slots =
      <({double at, int stream, PlanChapter chapter})>[];
  for (int s = 0; s < streams.length; s++) {
    final List<PlanChapter> stream = streams[s];
    for (int i = 0; i < stream.length; i++) {
      slots.add((
        // Midpoints rather than i / length, so a short stream's items land
        // inside the run instead of bunching against its start.
        at: (i + 0.5) / stream.length,
        stream: s,
        chapter: stream[i],
      ));
    }
  }
  slots.sort((
    ({double at, int stream, PlanChapter chapter}) a,
    ({double at, int stream, PlanChapter chapter}) b,
  ) {
    final int byTime = a.at.compareTo(b.at);
    // Ties resolve by stream order so the rotation stays predictable
    // (law before history before poetry…) instead of depending on sort
    // stability.
    return byTime != 0 ? byTime : a.stream.compareTo(b.stream);
  });
  return <PlanChapter>[
    for (final ({double at, int stream, PlanChapter chapter}) slot in slots)
      slot.chapter,
  ];
}

// 1,189 PlanChapters per plan, and the settings and onboarding pickers ask
// for sequences while building lists — worth keeping rather than rebuilding
// on every frame.
final Map<ReadingPlan, List<PlanChapter>> _sequenceCache =
    <ReadingPlan, List<PlanChapter>>{};

/// Every chapter of the Bible, in this plan's order. Each plan contains all
/// 1,189 chapters exactly once; only the order differs.
List<PlanChapter> chaptersForPlan(ReadingPlan plan) =>
    _sequenceCache[plan] ??= _buildSequence(plan);

List<PlanChapter> _buildSequence(ReadingPlan plan) {
  switch (plan) {
    case ReadingPlan.canonical:
      return _expand(<String>[for (final BibleBook b in kBibleBooks) b.id]);
    case ReadingPlan.chronological:
      return _expand(_kChronologicalOrder);
    case ReadingPlan.completion:
      return _expand(_kCompletionOrder);
    case ReadingPlan.hebrewGreekMix:
      return _weave(<List<PlanChapter>>[
        _expand(<String>[
          for (final BibleBook b in kBibleBooks)
            if (b.oldTestament) b.id,
        ]),
        _expand(<String>[
          for (final BibleBook b in kBibleBooks)
            if (!b.oldTestament) b.id,
        ]),
      ]);
    case ReadingPlan.thematic:
      return _weave(<List<PlanChapter>>[
        for (final List<String> group in _kThemeGroups.values) _expand(group),
      ]);
  }
}

final Map<String, Set<String>> _beforeStartCache = <String, Set<String>>{};

/// Every chapter printed before [startKey].
///
/// A reader who says "I stopped at Exodus 5" has covered the ground up to
/// there, and the progress bar and book grid should show it. These chapters
/// are kept apart from the ones actually marked in the app: they colour the
/// coverage in, but they never feed streaks, totals, quiz checkpoints or
/// achievements, because nobody earned those here.
///
/// Resolved in printed order rather than the selected plan's, on purpose.
/// "Up to Exodus 5" is a claim about the Bible as it's bound, which is how
/// people track where they got to. Running it through the chosen order would
/// mark Job as covered for anyone reading chronologically — Job sits between
/// Genesis and Exodus there — crediting a book they never claimed.
Set<String> chaptersBeforeStart(String? startKey) {
  if (startKey == null || startKey.isEmpty) {
    return const <String>{};
  }
  return _beforeStartCache[startKey] ??= _computeBeforeStart(startKey);
}

Set<String> _computeBeforeStart(String startKey) {
  final Set<String> out = <String>{};
  for (final BibleBook book in kBibleBooks) {
    for (int c = 1; c <= book.chapters; c++) {
      final String key = bibleChapterKey(book.id, c);
      if (key == startKey) {
        return out;
      }
      out.add(key);
    }
  }
  // An unrecognised key (a book renamed in a later version, say) must not
  // silently claim the entire Bible as covered.
  return const <String>{};
}

/// The next chapter the reader hasn't marked off, starting from where they
/// said they'd resume and wrapping around to catch anything skipped.
///
/// Returns null once every chapter has been read.
PlanChapter? nextChapterInPlan({
  required ReadingPlan plan,
  required Set<String> readKeys,
  String? startKey,
}) {
  final List<PlanChapter> sequence = chaptersForPlan(plan);
  int start = 0;
  if (startKey != null) {
    final int found = sequence.indexWhere((PlanChapter c) => c.key == startKey);
    // A resume point set under a previous plan still names a real chapter,
    // it just sits somewhere else in this order — so look it up rather than
    // storing an index that would silently point at the wrong book.
    if (found >= 0) {
      start = found;
    }
  }
  for (int i = 0; i < sequence.length; i++) {
    final PlanChapter candidate = sequence[(start + i) % sequence.length];
    if (!readKeys.contains(candidate.key)) {
      return candidate;
    }
  }
  return null;
}

extension ReadingPlanX on ReadingPlan {
  String get storageValue {
    switch (this) {
      case ReadingPlan.canonical:
        return 'canonical';
      case ReadingPlan.chronological:
        return 'chronological';
      case ReadingPlan.completion:
        return 'completion';
      case ReadingPlan.hebrewGreekMix:
        return 'hebrew_greek_mix';
      case ReadingPlan.thematic:
        return 'thematic';
    }
  }

  String label(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    switch (this) {
      case ReadingPlan.canonical:
        return l10n.planCanonicalTitle;
      case ReadingPlan.chronological:
        return l10n.planChronologicalTitle;
      case ReadingPlan.completion:
        return l10n.planCompletionTitle;
      case ReadingPlan.hebrewGreekMix:
        return l10n.planHebrewGreekTitle;
      case ReadingPlan.thematic:
        return l10n.planThematicTitle;
    }
  }

  String description(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    switch (this) {
      case ReadingPlan.canonical:
        return l10n.planCanonicalDesc;
      case ReadingPlan.chronological:
        return l10n.planChronologicalDesc;
      case ReadingPlan.completion:
        return l10n.planCompletionDesc;
      case ReadingPlan.hebrewGreekMix:
        return l10n.planHebrewGreekDesc;
      case ReadingPlan.thematic:
        return l10n.planThematicDesc;
    }
  }

  IconData get icon {
    switch (this) {
      case ReadingPlan.canonical:
        return Icons.menu_book_rounded;
      case ReadingPlan.chronological:
        return Icons.schedule_rounded;
      case ReadingPlan.completion:
        return Icons.history_edu_rounded;
      case ReadingPlan.hebrewGreekMix:
        return Icons.compare_arrows_rounded;
      case ReadingPlan.thematic:
        return Icons.category_rounded;
    }
  }
}

ReadingPlan readingPlanFromStorage(String? value) {
  for (final ReadingPlan plan in ReadingPlan.values) {
    if (plan.storageValue == value) {
      return plan;
    }
  }
  return ReadingPlan.canonical;
}
