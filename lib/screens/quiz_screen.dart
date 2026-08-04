import 'dart:math';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../services/answer_validator.dart';
import '../widgets/responsive_body.dart';

/// Runs a quiz: one question per screen, immediate feedback with an
/// explanation, then a final score. [onCompleted] is called once with the
/// final score/total so the caller can persist a result, award a freeze, etc.
class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.title,
    required this.questions,
    required this.onCompleted,
    super.key,
  });

  final String title;
  final List<QuizQuestion> questions;
  final Future<void> Function(int score, int total) onCompleted;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  static const AnswerValidator _validator = FuzzyAnswerValidator();

  final Random _random = Random();
  final TextEditingController _textController = TextEditingController();

  int _index = 0;
  int? _selected;
  bool _answered = false;
  bool _lastAnswerCorrect = false;
  int _score = 0;
  bool _finished = false;

  /// Word chips currently placed in the answer row (word-bank questions).
  List<String> _pickedWords = <String>[];

  // Shuffled once per play-through, so replaying a quiz never shows the same
  // question order or the same option order (previously the correct answer
  // was always authored as option 0, so it was always listed first).
  late final List<QuizQuestion> _questions = _shuffledQuestions();

  /// Chip pool per question index, shuffled once so tapping doesn't reorder it.
  late final Map<int, List<String>> _wordBanks = <int, List<String>>{};

  QuizQuestion get _current => _questions[_index];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  List<QuizQuestion> _shuffledQuestions() {
    final Random random = Random();
    final List<QuizQuestion> shuffled = List<QuizQuestion>.of(widget.questions)
      ..shuffle(random);
    return shuffled
        .map((QuizQuestion q) {
          // Only multiple-choice questions get their options reordered: the other
          // types derive their answer from `correctAnswer`, and shuffling would
          // just churn indices for no visible benefit.
          if (q.type != QuizAnswerType.multipleChoice) {
            return q;
          }
          final List<int> order = List<int>.generate(
            q.options.length,
            (int i) => i,
          )..shuffle(random);
          final List<String> options = order
              .map((int i) => q.options[i])
              .toList(growable: false);
          final int correctIndex = order.indexOf(q.correctIndex);
          return QuizQuestion(
            text: q.text,
            options: options,
            correctIndex: correctIndex,
            explanation: q.explanation,
            type: q.type,
            acceptedAnswers: q.acceptedAnswers,
            wordBankDistractors: q.wordBankDistractors,
            wordBankSegments: q.wordBankSegments,
          );
        })
        .toList(growable: false);
  }

  /// The scrambled chips for the current word-bank question: the words of the
  /// answer plus any authored distractors, shuffled once and then reused.
  List<String> _wordBankFor(int index) {
    return _wordBanks[index] ??= () {
      final QuizQuestion q = _questions[index];
      final List<String> answerWords = q.wordBankSegments.isNotEmpty
          ? q.wordBankSegments
          : q.correctAnswer
                .split(RegExp(r'\s+'))
                .where((String w) => w.isNotEmpty)
                .toList(growable: false);
      final List<String> words = <String>[
        ...answerWords,
        ...q.wordBankDistractors,
      ];
      return words..shuffle(_random);
    }();
  }

  void _select(int i) {
    if (_answered) {
      return;
    }
    setState(() {
      _selected = i;
      _answered = true;
      _lastAnswerCorrect = i == _current.correctIndex;
      if (_lastAnswerCorrect) {
        _score++;
      }
    });
  }

  void _submitTypedAnswer() {
    if (_answered) {
      return;
    }
    final String input = _current.type == QuizAnswerType.wordBank
        ? _pickedWords.join(' ')
        : _textController.text;
    if (input.trim().isEmpty) {
      return;
    }
    setState(() {
      _answered = true;
      _lastAnswerCorrect = _validator.matches(
        input,
        _current.allAcceptedAnswers,
      );
      if (_lastAnswerCorrect) {
        _score++;
      }
    });
  }

  Future<void> _next() async {
    if (_index < _questions.length - 1) {
      setState(() {
        _index++;
        _selected = null;
        _answered = false;
        _lastAnswerCorrect = false;
        _pickedWords = <String>[];
        _textController.clear();
      });
    } else {
      await widget.onCompleted(_score, _questions.length);
      if (mounted) {
        setState(() => _finished = true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ResponsiveBody(
        child: _finished ? _buildResult() : _buildQuestion(),
      ),
    );
  }

  Widget _buildQuestion() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool correct = _lastAnswerCorrect;

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
          child: Row(
            children: <Widget>[
              for (int i = 0; i < _questions.length; i++) ...<Widget>[
                Expanded(child: _ProgressDot(state: _dotState(i))),
                if (i != _questions.length - 1) const SizedBox(width: 6),
              ],
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                l10n.quizQuestionCounter(_index + 1, _questions.length),
                style: theme.textTheme.labelLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              if (_score > 0) _StreakPill(score: _score),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            children: <Widget>[
              Text(
                _current.text,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 20),
              switch (_current.type) {
                QuizAnswerType.multipleChoice => _buildChoices(),
                QuizAnswerType.freeText => _buildTextInput(l10n),
                QuizAnswerType.wordBank => _buildWordBank(l10n),
              },
              if (_answered) ...<Widget>[
                const SizedBox(height: 8),
                // For typed answers a wrong attempt should still teach the
                // right one, which the options list would have shown.
                if (!correct && _current.type != QuizAnswerType.multipleChoice)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      l10n.quizCorrectAnswerWas(_current.correctAnswer),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.primary,
                      ),
                    ),
                  ),
                _FeedbackBanner(correct: correct, text: _current.explanation),
              ],
            ],
          ),
        ),
        if (_answered)
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: FilledButton.icon(
              onPressed: _next,
              icon: Icon(
                _index < _questions.length - 1
                    ? Icons.arrow_forward_rounded
                    : Icons.flag_rounded,
              ),
              label: Text(
                _index < _questions.length - 1
                    ? l10n.quizNext
                    : l10n.quizSeeScore,
              ),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          )
        else if (_current.type != QuizAnswerType.multipleChoice)
          // Typed answers need an explicit submit; multiple choice commits as
          // soon as an option is tapped.
          SafeArea(
            minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: FilledButton.icon(
              onPressed: _hasPendingAnswer ? _submitTypedAnswer : null,
              icon: const Icon(Icons.check_rounded),
              label: Text(l10n.quizCheckAnswer),
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// Whether the user has entered enough to submit a typed answer.
  bool get _hasPendingAnswer => _current.type == QuizAnswerType.wordBank
      ? _pickedWords.isNotEmpty
      : _textController.text.trim().isNotEmpty;

  Widget _buildChoices() {
    return Column(
      children: <Widget>[
        for (int i = 0; i < _current.options.length; i++) ...<Widget>[
          _AnimatedOption(
            label: _current.options[i],
            state: _optionState(i),
            onTap: () => _select(i),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _buildTextInput(AppLocalizations l10n) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return TextField(
      controller: _textController,
      enabled: !_answered,
      autocorrect: false,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      textCapitalization: TextCapitalization.sentences,
      onChanged: (_) => setState(() {}),
      onSubmitted: (_) => _submitTypedAnswer(),
      decoration: InputDecoration(
        hintText: l10n.quizTypeAnswerHint,
        filled: true,
        fillColor: cs.surfaceContainerHigh,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: cs.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
      ),
      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildWordBank(AppLocalizations l10n) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final List<String> bank = _wordBankFor(_index);

    // A chip is used up once it's been placed; duplicates of the same word
    // are matched by position so repeated words still work.
    final List<String> remaining = List<String>.of(bank);
    for (final String picked in _pickedWords) {
      remaining.remove(picked);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          l10n.quizWordBankInstruction,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        // The answer being assembled.
        Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(16),
            border: Border(
              bottom: BorderSide(color: cs.outlineVariant, width: 2),
            ),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              for (int i = 0; i < _pickedWords.length; i++)
                _WordChip(
                  label: _pickedWords[i],
                  onTap: _answered
                      ? null
                      : () => setState(() => _pickedWords.removeAt(i)),
                  filled: true,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // The remaining pool.
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            for (final String word in remaining)
              _WordChip(
                label: word,
                onTap: _answered
                    ? null
                    : () => setState(() => _pickedWords.add(word)),
                filled: false,
              ),
          ],
        ),
        if (_pickedWords.isNotEmpty && !_answered) ...<Widget>[
          const SizedBox(height: 8),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: () => setState(() => _pickedWords = <String>[]),
              icon: const Icon(Icons.backspace_outlined, size: 18),
              label: Text(l10n.quizClearAnswer),
            ),
          ),
        ],
      ],
    );
  }

  _DotState _dotState(int i) {
    if (i < _index) {
      return _DotState.past;
    }
    if (i == _index) {
      return _answered ? _DotState.past : _DotState.current;
    }
    return _DotState.upcoming;
  }

  _OptionState _optionState(int i) {
    if (!_answered) {
      return _OptionState.idle;
    }
    if (i == _current.correctIndex) {
      return _OptionState.correct;
    }
    if (i == _selected) {
      return _OptionState.wrong;
    }
    return _OptionState.idle;
  }

  Widget _buildResult() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final int stars = _questions.isEmpty
        ? 0
        : ((_score / _questions.length) * 3).ceil().clamp(1, 3);
    final bool perfect = _score == _questions.length;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(3, (int i) {
                final bool filled = i < stars;
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: filled ? 1 : 0),
                  duration: Duration(milliseconds: 300 + i * 150),
                  curve: Curves.elasticOut,
                  builder: (BuildContext context, double v, Widget? child) {
                    return Transform.scale(scale: 0.6 + 0.4 * v, child: child);
                  },
                  child: Icon(
                    filled ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 56,
                    color: filled ? Colors.amber : cs.outlineVariant,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              perfect ? l10n.quizPerfect : l10n.quizWellDone,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.quizScore(_score, _questions.length),
              style: theme.textTheme.titleMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                minimumSize: const Size(200, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text(l10n.quizFinish),
            ),
          ],
        ),
      ),
    );
  }
}

enum _DotState { past, current, upcoming }

class _ProgressDot extends StatelessWidget {
  const _ProgressDot({required this.state});

  final _DotState state;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Color color = switch (state) {
      _DotState.past => cs.primary,
      _DotState.current => cs.primary.withValues(alpha: 0.5),
      _DotState.upcoming => cs.surfaceContainerHighest,
    };
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}

class _StreakPill extends StatelessWidget {
  const _StreakPill({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(Icons.bolt_rounded, size: 14, color: cs.onTertiaryContainer),
          const SizedBox(width: 3),
          Text(
            '$score',
            style: TextStyle(
              color: cs.onTertiaryContainer,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

/// A tappable word chip used to assemble a word-bank answer. Chips in the
/// pool are outlined; chips already placed in the answer are filled and tap
/// to remove.
class _WordChip extends StatelessWidget {
  const _WordChip({
    required this.label,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Material(
      color: filled ? cs.primaryContainer : cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: filled ? cs.primary : cs.outlineVariant,
          width: 1.5,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: filled ? cs.onPrimaryContainer : cs.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

enum _OptionState { idle, correct, wrong }

class _AnimatedOption extends StatelessWidget {
  const _AnimatedOption({
    required this.label,
    required this.state,
    required this.onTap,
  });

  final String label;
  final _OptionState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    late final Color bg;
    late final Color border;
    IconData? icon;
    switch (state) {
      case _OptionState.idle:
        bg = cs.surfaceContainerHigh;
        border = cs.outlineVariant;
        icon = null;
      case _OptionState.correct:
        bg = cs.primaryContainer;
        border = cs.primary;
        icon = Icons.check_circle;
      case _OptionState.wrong:
        bg = cs.errorContainer;
        border = cs.error;
        icon = Icons.cancel;
    }
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(
        begin: 1,
        end: state == _OptionState.idle ? 1 : 1.02,
      ),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      builder: (BuildContext context, double scale, Widget? child) {
        return Transform.scale(scale: scale, child: child);
      },
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: border, width: 1.5),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                if (icon != null) Icon(icon, color: border),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeedbackBanner extends StatelessWidget {
  const _FeedbackBanner({required this.correct, required this.text});

  final bool correct;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final Color bg = correct ? cs.primaryContainer : cs.surfaceContainerHigh;
    final Color fg = correct ? cs.onPrimaryContainer : cs.onSurfaceVariant;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 220),
      builder: (BuildContext context, double v, Widget? child) {
        return Opacity(
          opacity: v,
          child: Transform.translate(
            offset: Offset(0, (1 - v) * 8),
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              correct ? Icons.emoji_events_rounded : Icons.info_outline,
              size: 20,
              color: fg,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(text, style: TextStyle(color: fg)),
            ),
          ],
        ),
      ),
    );
  }
}
