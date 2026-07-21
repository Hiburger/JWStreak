import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../quiz_data.dart';
import '../services/deep_link_service.dart';
import '../services/local_db_service.dart';
import 'checkpoint_screen.dart';
import 'quiz_screen.dart';

/// Browse the whole Bible: books grouped by testament, each showing reading
/// progress. Tapping a book opens its chapter grid.
class BibleBrowserScreen extends StatefulWidget {
  const BibleBrowserScreen({required this.dbService, super.key});

  final LocalDbService dbService;

  @override
  State<BibleBrowserScreen> createState() => _BibleBrowserScreenState();
}

class _BibleBrowserScreenState extends State<BibleBrowserScreen> {
  Set<String> _readKeys = const <String>{};
  Map<String, int> _starsByBook = const <String, int>{};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final Set<String> keys = await widget.dbService.getReadChapterKeys();
    final Map<String, int> stars = await widget.dbService
        .getEarnedStarsByBook();
    if (mounted) {
      setState(() {
        _readKeys = keys;
        _starsByBook = stars;
        _isLoading = false;
      });
    }
  }

  int _readCount(BibleBook book) {
    int count = 0;
    for (int c = 1; c <= book.chapters; c++) {
      if (_readKeys.contains(bibleChapterKey(book.id, c))) {
        count++;
      }
    }
    return count;
  }

  Future<void> _openBook(BibleBook book) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) =>
            BibleChaptersScreen(dbService: widget.dbService, book: book),
      ),
    );
    await _loadProgress();
  }

  @override
  Widget build(BuildContext context) {
    final List<BibleBook> ot = kBibleBooks
        .where((BibleBook b) => b.oldTestament)
        .toList(growable: false);
    final List<BibleBook> nt = kBibleBooks
        .where((BibleBook b) => !b.oldTestament)
        .toList(growable: false);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.bibleAppTitle)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              children: <Widget>[
                _TotalStarsBanner(
                  earned: _starsByBook.values.fold<int>(0, (int a, int b) => a + b),
                  max: totalMaxStars(),
                ),
                const SizedBox(height: 16),
                _GroupHeader(
                  title: AppLocalizations.of(context)!.bibleHebrewScriptures,
                ),
                ...ot.map(_bookTile),
                const SizedBox(height: 20),
                _GroupHeader(
                  title: AppLocalizations.of(context)!.bibleGreekScriptures,
                ),
                ...nt.map(_bookTile),
              ],
            ),
    );
  }

  Widget _bookTile(BibleBook book) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _BookTile(
        book: book,
        readCount: _readCount(book),
        stars: _starsByBook[book.id] ?? 0,
        maxStars: bookMaxStars(book),
        onTap: () => _openBook(book),
      ),
    );
  }
}

class _TotalStarsBanner extends StatelessWidget {
  const _TotalStarsBanner({required this.earned, required this.max});

  final int earned;
  final int max;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final double progress = max == 0 ? 0 : earned / max;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[cs.tertiaryContainer, cs.primaryContainer],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.star_rounded, color: Colors.amber, size: 40),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.bibleStarsEarnedLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onTertiaryContainer.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.bibleStarsFraction(earned, max),
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: cs.onTertiaryContainer,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: cs.onTertiaryContainer.withValues(
                      alpha: 0.15,
                    ),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.amber,
                    ),
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

class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w800,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  const _BookTile({
    required this.book,
    required this.readCount,
    required this.stars,
    required this.maxStars,
    required this.onTap,
  });

  final BibleBook book;
  final int readCount;
  final int stars;
  final int maxStars;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final bool complete = readCount >= book.chapters;
    final double progress = readCount / book.chapters;

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
                  color: complete ? cs.primary : cs.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  complete ? Icons.check_rounded : Icons.menu_book_outlined,
                  color: complete ? cs.onPrimary : cs.onPrimaryContainer,
                  size: 22,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      localizedBookName(context, book),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 5,
                        backgroundColor: cs.surfaceContainerHighest,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.bibleChaptersReadCount(readCount, book.chapters),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              if (maxStars > 0)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.star_rounded,
                      size: 18,
                      color: stars > 0 ? Colors.amber : cs.outlineVariant,
                    ),
                    Text(
                      AppLocalizations.of(
                        context,
                      )!.bibleBookStarsFraction(stars, maxStars),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: cs.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              const SizedBox(width: 4),
              Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

/// Chapter grid for a single book. Tap a chapter to open it in JW Library or
/// toggle its read status.
class BibleChaptersScreen extends StatefulWidget {
  const BibleChaptersScreen({
    required this.dbService,
    required this.book,
    super.key,
  });

  final LocalDbService dbService;
  final BibleBook book;

  @override
  State<BibleChaptersScreen> createState() => _BibleChaptersScreenState();
}

class _BibleChaptersScreenState extends State<BibleChaptersScreen> {
  final DeepLinkService _deepLinkService = DeepLinkService();
  Set<int> _readChapters = const <int>{};
  Map<String, QuizResult> _quizResults = const <String, QuizResult>{};
  Set<String> _answeredReflections = const <String>{};
  bool _isLoading = true;

  late final List<Checkpoint> _checkpoints = checkpointsForBook(
    widget.book,
    languageCode: Localizations.localeOf(context).languageCode,
  );

  /// Chapter numbers interleaved with quiz-checkpoint markers, in reading
  /// order, so a special quiz cell appears right after the chapter that
  /// unlocks it. Entries are either an `int` (chapter) or a `Checkpoint`
  /// (quiz cell) — only checkpoints with a quiz get a grid cell.
  late final List<Object> _gridEntries = () {
    final Map<int, Checkpoint> quizByChapter = <int, Checkpoint>{
      for (final Checkpoint cp in _checkpoints)
        if (cp.hasQuiz) cp.afterChapter: cp,
    };
    final List<Object> entries = <Object>[];
    for (int c = 1; c <= widget.book.chapters; c++) {
      entries.add(c);
      final Checkpoint? cp = quizByChapter[c];
      if (cp != null) {
        entries.add(cp);
      }
    }
    return entries;
  }();

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final Set<String> keys = await widget.dbService.getReadChapterKeys();
    final Map<String, QuizResult> quiz = await widget.dbService
        .getAllQuizResults();
    final Set<String> reflections = await widget.dbService
        .getAnsweredReflectionIds();
    final Set<int> read = <int>{};
    for (int c = 1; c <= widget.book.chapters; c++) {
      if (keys.contains(bibleChapterKey(widget.book.id, c))) {
        read.add(c);
      }
    }
    if (mounted) {
      setState(() {
        _readChapters = read;
        _quizResults = quiz;
        _answeredReflections = reflections;
        _isLoading = false;
      });
    }
  }

  bool _isCheckpointUnlocked(Checkpoint cp) {
    for (int c = 1; c <= cp.afterChapter; c++) {
      if (!_readChapters.contains(c)) {
        return false;
      }
    }
    return true;
  }

  // A checkpoint moves to "Terminés" once its primary gate is cleared: the
  // quiz if it has one, otherwise the reflection. The reflection remains a
  // separate, always-available action and no longer blocks this status —
  // previously requiring both meant a completed quiz stayed stuck in "À
  // faire" until the reflection was also written.
  bool _isCheckpointDone(Checkpoint cp) {
    if (cp.hasQuiz) {
      return _quizResults.containsKey(cp.id);
    }
    return _answeredReflections.contains(cp.id);
  }

  int _bookStars() {
    int total = 0;
    for (final Checkpoint cp in _checkpoints) {
      if (cp.hasQuiz) {
        total += _quizResults[cp.id]?.stars ?? 0;
      }
    }
    return total;
  }

  List<Widget> _buildCheckpointSections() {
    final List<Checkpoint> todo = _checkpoints
        .where((Checkpoint cp) => !_isCheckpointDone(cp))
        .toList(growable: false);
    final List<Checkpoint> done = _checkpoints
        .where(_isCheckpointDone)
        .toList(growable: false);

    Widget row(Checkpoint cp) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: _CheckpointRow(
        checkpoint: cp,
        unlocked: _isCheckpointUnlocked(cp),
        done: _isCheckpointDone(cp),
        result: _quizResults[cp.id],
        reflectionAnswered: _answeredReflections.contains(cp.id),
        onTap: () => _openCheckpoint(cp),
      ),
    );

    return <Widget>[
      if (todo.isNotEmpty) ...<Widget>[
        _SubHeader(AppLocalizations.of(context)!.bibleTodoHeader),
        const SizedBox(height: 10),
        ...todo.map(row),
      ],
      if (done.isNotEmpty) ...<Widget>[
        if (todo.isNotEmpty) const SizedBox(height: 20),
        _SubHeader(AppLocalizations.of(context)!.bibleDoneHeader),
        const SizedBox(height: 10),
        ...done.map(row),
      ],
    ];
  }

  Future<void> _openCheckpoint(Checkpoint cp) async {
    if (!_isCheckpointUnlocked(cp)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)!.bibleUnlockHint(
              localizedCheckpointTitle(context, cp),
            ),
          ),
        ),
      );
      return;
    }
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) =>
            CheckpointScreen(dbService: widget.dbService, checkpoint: cp),
      ),
    );
    await _loadProgress();
  }

  Future<void> _openInJwLibrary(int chapter) async {
    try {
      await _deepLinkService.openReference(
        book: widget.book.id,
        chapter: chapter,
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context)!.bibleErrorGeneric('$error'),
            ),
          ),
        );
      }
    }
  }

  Future<void> _toggleRead(int chapter) async {
    final bool isRead = _readChapters.contains(chapter);
    if (isRead) {
      await widget.dbService.unmarkChapterRead(
        book: widget.book.id,
        chapter: chapter,
      );
    } else {
      await widget.dbService.markChapterRead(
        book: widget.book.id,
        chapter: chapter,
      );
    }
    await _loadProgress();
  }

  void _onChapterTap(int chapter) {
    final bool isRead = _readChapters.contains(chapter);
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  '${localizedBookName(context, widget.book)} $chapter',
                  style: Theme.of(sheetContext).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.open_in_new),
                title: Text(
                  AppLocalizations.of(context)!.bibleOpenInJwLibrary,
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _openInJwLibrary(chapter);
                },
              ),
              ListTile(
                leading: Icon(
                  isRead ? Icons.remove_done : Icons.check_circle_outline,
                ),
                title: Text(
                  isRead
                      ? AppLocalizations.of(context)!.bibleMarkUnread
                      : AppLocalizations.of(context)!.bibleMarkRead,
                ),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  _toggleRead(chapter);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(localizedBookName(context, widget.book)),
        actions: <Widget>[
          if (bookMaxStars(widget.book) > 0)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  const Icon(Icons.star_rounded, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    '${_bookStars()}/${bookMaxStars(widget.book)}',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.bibleChaptersHeader,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                  itemCount: _gridEntries.length,
                  itemBuilder: (BuildContext context, int index) {
                    final Object entry = _gridEntries[index];
                    if (entry is int) {
                      final int chapter = entry;
                      return _ChapterCell(
                        chapter: chapter,
                        isRead: _readChapters.contains(chapter),
                        onTap: () => _onChapterTap(chapter),
                        cs: cs,
                      );
                    }
                    final Checkpoint cp = entry as Checkpoint;
                    return _QuizGridCell(
                      unlocked: _isCheckpointUnlocked(cp),
                      done: _isCheckpointDone(cp),
                      onTap: () => _openCheckpoint(cp),
                    );
                  },
                ),
                const SizedBox(height: 24),
                ..._buildCheckpointSections(),
                if (_allQuizzesDone()) ...<Widget>[
                  const SizedBox(height: 20),
                  _FullBookQuizCard(onTap: _openFullBookQuiz),
                ],
              ],
            ),
    );
  }

  /// True once every checkpoint that has a quiz has been completed (the
  /// book may still have reflection-only checkpoints pending).
  bool _allQuizzesDone() {
    final List<Checkpoint> quizCheckpoints = _checkpoints
        .where((Checkpoint cp) => cp.hasQuiz)
        .toList(growable: false);
    if (quizCheckpoints.isEmpty) {
      return false;
    }
    return quizCheckpoints.every(
      (Checkpoint cp) => _quizResults.containsKey(cp.id),
    );
  }

  Future<void> _openFullBookQuiz() async {
    final List<QuizQuestion> questions = allQuestionsForBook(
      widget.book,
      languageCode: Localizations.localeOf(context).languageCode,
    );
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => QuizScreen(
          title: AppLocalizations.of(
            context,
          )!.bibleFullQuizTitle(localizedBookName(context, widget.book)),
          questions: questions,
          onCompleted: (int score, int total) => widget.dbService
              .saveQuizResult(
                quizId: '${widget.book.id}#full',
                score: score,
                total: total,
              ),
        ),
      ),
    );
  }
}

class _FullBookQuizCard extends StatelessWidget {
  const _FullBookQuizCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Material(
      color: cs.tertiaryContainer,
      borderRadius: BorderRadius.circular(16),
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
                  color: cs.tertiary,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  Icons.emoji_events_rounded,
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
                      AppLocalizations.of(context)!.bibleFullBookQuizTitle,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onTertiaryContainer,
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.bibleFullBookQuizSubtitle,
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
  }
}

class _SubHeader extends StatelessWidget {
  const _SubHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w800,
          color: theme.colorScheme.onSurfaceVariant,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _CheckpointRow extends StatelessWidget {
  const _CheckpointRow({
    required this.checkpoint,
    required this.unlocked,
    required this.done,
    required this.result,
    required this.reflectionAnswered,
    required this.onTap,
  });

  final Checkpoint checkpoint;
  final bool unlocked;
  final bool done;
  final bool reflectionAnswered;
  final QuizResult? result;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final Color iconBg;
    final Color iconColor;
    final IconData icon;
    if (done) {
      iconBg = cs.primary;
      iconColor = cs.onPrimary;
      icon = Icons.check_rounded;
    } else if (unlocked) {
      iconBg = cs.tertiary;
      iconColor = cs.onTertiary;
      icon = Icons.workspace_premium_rounded;
    } else {
      iconBg = cs.surfaceContainerHighest;
      iconColor = cs.onSurfaceVariant;
      icon = Icons.lock_outline;
    }

    return Opacity(
      opacity: unlocked || done ? 1 : 0.55,
      child: Material(
        color: cs.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: iconBg,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        localizedCheckpointTitle(context, checkpoint),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      _subtitle(context, theme, cs),
                    ],
                  ),
                ),
                if (result != null) ...<Widget>[
                  _MiniStars(stars: result!.stars),
                  const SizedBox(width: 8),
                ],
                Icon(
                  unlocked || done
                      ? Icons.chevron_right
                      : Icons.lock_outline,
                  color: cs.onSurfaceVariant,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _subtitle(BuildContext context, ThemeData theme, ColorScheme cs) {
    final TextStyle? style = theme.textTheme.bodySmall?.copyWith(
      color: cs.onSurfaceVariant,
    );
    if (done && result != null) {
      final String suffix = reflectionAnswered
          ? ''
          : AppLocalizations.of(context)!.bibleReflectionToWriteSuffix;
      final String date = DateFormat('dd/MM à HH:mm').format(result!.passedAt);
      return Text(
        AppLocalizations.of(context)!.bibleCheckpointScoreDate(
          result!.score,
          result!.total,
          date,
          suffix,
        ),
        style: style,
      );
    }
    if (done) {
      return Text(
        AppLocalizations.of(context)!.bibleReflectionSaved,
        style: style,
      );
    }
    if (!unlocked) {
      return Text(AppLocalizations.of(context)!.bibleLocked, style: style);
    }
    final String label = checkpoint.hasQuiz
        ? AppLocalizations.of(context)!.bibleQuizAndReflection
        : AppLocalizations.of(context)!.bibleReflectionOnly;
    return Text(label, style: style);
  }
}

class _MiniStars extends StatelessWidget {
  const _MiniStars({required this.stars});

  final int stars;

  @override
  Widget build(BuildContext context) {
    final Color out = Theme.of(context).colorScheme.outlineVariant;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(3, (int i) {
        final bool filled = i < stars;
        return Icon(
          filled ? Icons.star_rounded : Icons.star_outline_rounded,
          size: 15,
          color: filled ? Colors.amber : out,
        );
      }),
    );
  }
}

/// Special quiz cell inserted in the chapter grid right after the chapter
/// that unlocks it. Shows a rotating amber glow (matching the home page's
/// "Nouveau quiz débloqué" banner) while available, a static gold cell once
/// done, or a muted locked cell otherwise.
class _QuizGridCell extends StatefulWidget {
  const _QuizGridCell({
    required this.unlocked,
    required this.done,
    required this.onTap,
  });

  final bool unlocked;
  final bool done;
  final VoidCallback onTap;

  @override
  State<_QuizGridCell> createState() => _QuizGridCellState();
}

class _QuizGridCellState extends State<_QuizGridCell>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  bool get _available => widget.unlocked && !widget.done;

  @override
  void initState() {
    super.initState();
    if (_available) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    }
  }

  @override
  void didUpdateWidget(_QuizGridCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_available && _controller == null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 4),
      )..repeat();
    } else if (!_available && _controller != null) {
      _controller!.dispose();
      _controller = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    final Widget cell = Material(
      color: widget.done
          ? cs.primary
          : widget.unlocked
          ? cs.tertiaryContainer
          : cs.surfaceContainerHighest.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: widget.done
              ? cs.primary
              : widget.unlocked
              ? cs.tertiary
              : cs.outlineVariant.withValues(alpha: 0.4),
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: widget.onTap,
        child: Center(
          child: Icon(
            widget.done
                ? Icons.check_rounded
                : widget.unlocked
                ? Icons.emoji_events_rounded
                : Icons.lock_outline,
            size: 18,
            color: widget.done
                ? cs.onPrimary
                : widget.unlocked
                ? cs.onTertiaryContainer
                : cs.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
    );

    final AnimationController? controller = _controller;
    if (controller == null) {
      return cell;
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        final double angle = controller.value * 2 * math.pi;
        final double pulse = 0.5 + 0.5 * math.sin(controller.value * 2 * math.pi);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: SweepGradient(
              transform: GradientRotation(angle),
              colors: const <Color>[
                Colors.amber,
                Color(0xFFFFD54F),
                Colors.orangeAccent,
                Colors.amber,
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.amber.withValues(alpha: 0.35 + 0.3 * pulse),
                blurRadius: 8 + 6 * pulse,
                spreadRadius: 0.5 + 1.5 * pulse,
              ),
            ],
          ),
          padding: const EdgeInsets.all(2),
          child: child,
        );
      },
      child: cell,
    );
  }
}

class _ChapterCell extends StatelessWidget {
  const _ChapterCell({
    required this.chapter,
    required this.isRead,
    required this.onTap,
    required this.cs,
  });

  final int chapter;
  final bool isRead;
  final VoidCallback onTap;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isRead ? cs.primary : cs.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isRead ? cs.primary : cs.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Center(
          child: isRead
              ? Icon(Icons.check_rounded, color: cs.onPrimary)
              : Text(
                  '$chapter',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
        ),
      ),
    );
  }
}
