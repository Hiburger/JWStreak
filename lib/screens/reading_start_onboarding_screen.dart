import 'package:flutter/material.dart';

import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/onboarding_progress.dart';
import '../widgets/picker_field.dart';
import '../widgets/responsive_body.dart';

/// Onboarding page asking whether the reader is already partway through the
/// Bible, and if so where to pick up.
///
/// Without this the app always opened at Genesis 1, which is wrong for anyone
/// who has been reading for years — they'd have to mark hundreds of chapters
/// by hand or read what they've already read.
///
/// Answering "yes" sets a resume point; it deliberately does not mark the
/// earlier chapters as read. The reader is saying where to continue, not
/// claiming they read those chapters here, and inventing those rows would
/// hand out streaks and achievements nobody earned.
class ReadingStartOnboardingScreen extends StatefulWidget {
  const ReadingStartOnboardingScreen({
    required this.onNext,
    required this.onBack,
    required this.stepCount,
    required this.stepIndex,
    required this.onStartKeyChanged,
    required this.onAnswered,
    required this.canContinue,
    this.initialStartKey,
    this.hideActionButton = false,
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;
  final int stepCount;
  final int stepIndex;

  /// Null clears the resume point, i.e. "start from the beginning".
  final ValueChanged<String?> onStartKeyChanged;

  /// Fired the moment the reader picks Yes or No — separate from
  /// [onStartKeyChanged], which also fires for "No" with a null key and
  /// would otherwise be indistinguishable from "hasn't answered yet".
  final VoidCallback onAnswered;

  /// Whether an answer has been given. Gates the Continue button; the page
  /// itself doesn't track this so a swipe-driven skip can be blocked from
  /// the PageView one level up, not just a button tap here.
  final bool canContinue;

  final String? initialStartKey;
  final bool hideActionButton;

  @override
  State<ReadingStartOnboardingScreen> createState() =>
      _ReadingStartOnboardingScreenState();
}

class _ReadingStartOnboardingScreenState
    extends State<ReadingStartOnboardingScreen> {
  /// Null until the reader answers, so neither card starts out looking picked.
  bool? _alreadyStarted;
  late BibleBook _book;
  int _chapter = 1;

  @override
  void initState() {
    super.initState();
    _book = kBibleBooks.first;
    final String? initial = widget.initialStartKey;
    if (initial != null) {
      final int sep = initial.lastIndexOf('|');
      if (sep > 0) {
        final String bookId = initial.substring(0, sep);
        final int? chapter = int.tryParse(initial.substring(sep + 1));
        for (final BibleBook b in kBibleBooks) {
          if (b.id == bookId) {
            _book = b;
            _chapter = (chapter ?? 1).clamp(1, b.chapters);
            _alreadyStarted = true;
            break;
          }
        }
      }
    }
  }

  void _answer(bool started) {
    setState(() {
      _alreadyStarted = started;
      if (!started) {
        _chapter = 1;
      }
    });
    widget.onAnswered();
    widget.onStartKeyChanged(
      started ? bibleChapterKey(_book.id, _chapter) : null,
    );
  }

  void _setBook(BibleBook book) {
    setState(() {
      _book = book;
      // Chapter counts vary wildly (Psalms 150, Obadiah 1), so a chapter
      // that was valid for the previous book often isn't for this one.
      _chapter = _chapter.clamp(1, book.chapters);
    });
    widget.onStartKeyChanged(bibleChapterKey(_book.id, _chapter));
  }

  void _setChapter(int chapter) {
    setState(() {
      _chapter = chapter;
    });
    widget.onStartKeyChanged(bibleChapterKey(_book.id, _chapter));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: ResponsiveBody(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    style: circularIconButtonStyle(context),
                    onPressed: widget.onBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                    tooltip: l10n.onbBack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.onbStartTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onbStartSubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.onbStartQuestion,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: _AnswerCard(
                                label: l10n.onbStartYes,
                                icon: Icons.bookmark_added_outlined,
                                accent: kAccentBlue,
                                selected: _alreadyStarted == true,
                                onTap: () => _answer(true),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _AnswerCard(
                                label: l10n.onbStartNo,
                                icon: Icons.flag_outlined,
                                accent: kAccentTeal,
                                selected: _alreadyStarted == false,
                                onTap: () => _answer(false),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // The two answers lead somewhere different, so the
                        // page swaps rather than showing both and greying
                        // one out. A plain crossfade, deliberately with no
                        // size animation at all: a bare AnimatedSize grew
                        // the clip around an already-fully-built child,
                        // which read as the new card being slowly revealed
                        // top to bottom. Pairing that grow with a fade (tried
                        // next) still traced the same shape, just softer —
                        // still visibly "materializing" from the top instead
                        // of appearing. Letting the height jump instantly
                        // and only cross-fading the content is what actually
                        // reads as one clean swap.
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 180),
                          // AnimatedSwitcher's default layout stacks the
                          // outgoing and incoming children *centered* on
                          // each other. While the outgoing one (a different
                          // height) is still fading out, that centers the
                          // stack around the taller of the two — so the
                          // incoming card rendered a couple of frames off
                          // from where it settles, then hopped up (or down)
                          // once the outgoing child finished and the stack
                          // shrank to just its height. Pinning both to the
                          // top edge instead means the incoming card is
                          // already exactly where it ends up, from frame one.
                          layoutBuilder:
                              (
                                Widget? currentChild,
                                List<Widget> previousChildren,
                              ) => Stack(
                                alignment: Alignment.topCenter,
                                children: <Widget>[
                                  ...previousChildren,
                                  ?currentChild,
                                ],
                              ),
                          child: KeyedSubtree(
                            key: ValueKey<bool?>(_alreadyStarted),
                            child: switch (_alreadyStarted) {
                              null => const SizedBox(width: double.infinity),
                              false => _FreshStartNote(
                                text: l10n.onbStartFresh,
                              ),
                              true => _ResumePicker(
                                book: _book,
                                chapter: _chapter,
                                onBookChanged: _setBook,
                                onChapterChanged: _setChapter,
                                label: l10n.onbStartResumeLabel,
                              ),
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                OnboardingProgress(
                  count: widget.stepCount,
                  index: widget.stepIndex,
                ),
                const SizedBox(height: 16),
                AnimatedOpacity(
                  opacity: widget.hideActionButton ? 0 : 1,
                  duration: const Duration(milliseconds: 150),
                  child: IgnorePointer(
                    ignoring: widget.hideActionButton,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: widget.canContinue
                                ? widget.onNext
                                : null,
                            style: FilledButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: Text(
                              l10n.onbContinue,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        if (!widget.canContinue) ...<Widget>[
                          const SizedBox(height: 8),
                          Text(
                            l10n.onbChooseToContinue,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AnswerCard extends StatelessWidget {
  const _AnswerCard({
    required this.label,
    required this.icon,
    required this.accent,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final OnboardingAccent accent;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Material(
      color: selected ? accent.background(context) : cs.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: selected ? accent.foreground(context) : cs.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          child: Column(
            children: <Widget>[
              Icon(
                icon,
                size: 26,
                color: selected
                    ? accent.foreground(context)
                    : cs.onSurfaceVariant,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: selected ? accent.foreground(context) : cs.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FreshStartNote extends StatelessWidget {
  const _FreshStartNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.auto_awesome_rounded, color: cs.primary, size: 20),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: theme.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}

class _ResumePicker extends StatelessWidget {
  const _ResumePicker({
    required this.book,
    required this.chapter,
    required this.onBookChanged,
    required this.onChapterChanged,
    required this.label,
  });

  final BibleBook book;
  final int chapter;
  final ValueChanged<BibleBook> onBookChanged;
  final ValueChanged<int> onChapterChanged;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: PickerField<String>(
                  currentLabel: localizedBookName(context, book),
                  selectedValue: book.id,
                  entries: <PickerEntry<String>>[
                    for (final BibleBook b in kBibleBooks)
                      PickerEntry<String>(
                        value: b.id,
                        label: localizedBookName(context, b),
                      ),
                  ],
                  onChanged: (String id) => onBookChanged(
                    kBibleBooks.firstWhere((BibleBook b) => b.id == id),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 2,
                child: PickerField<int>(
                  currentLabel: '${chapter.clamp(1, book.chapters)}',
                  selectedValue: chapter.clamp(1, book.chapters),
                  entries: <PickerEntry<int>>[
                    for (int c = 1; c <= book.chapters; c++)
                      PickerEntry<int>(value: c, label: '$c'),
                  ],
                  onChanged: onChapterChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
