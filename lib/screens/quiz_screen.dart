import 'dart:math';

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../quiz_data.dart';

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
  int _index = 0;
  int? _selected;
  bool _answered = false;
  int _score = 0;
  bool _finished = false;

  // Shuffled once per play-through, so replaying a quiz never shows the same
  // question order or the same option order (previously the correct answer
  // was always authored as option 0, so it was always listed first).
  late final List<QuizQuestion> _questions = _shuffledQuestions();

  QuizQuestion get _current => _questions[_index];

  List<QuizQuestion> _shuffledQuestions() {
    final Random random = Random();
    final List<QuizQuestion> shuffled = List<QuizQuestion>.of(widget.questions)
      ..shuffle(random);
    return shuffled.map((QuizQuestion q) {
      final List<int> order = List<int>.generate(q.options.length, (int i) => i)
        ..shuffle(random);
      final List<String> options = order
          .map((int i) => q.options[i])
          .toList(growable: false);
      final int correctIndex = order.indexOf(q.correctIndex);
      return QuizQuestion(
        text: q.text,
        options: options,
        correctIndex: correctIndex,
        explanation: q.explanation,
      );
    }).toList(growable: false);
  }

  void _select(int i) {
    if (_answered) {
      return;
    }
    setState(() {
      _selected = i;
      _answered = true;
      if (i == _current.correctIndex) {
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
      body: _finished ? _buildResult() : _buildQuestion(),
    );
  }

  Widget _buildQuestion() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool correct = _selected == _current.correctIndex;

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
              if (_score > 0)
                _StreakPill(score: _score),
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
              for (int i = 0; i < _current.options.length; i++) ...<Widget>[
                _AnimatedOption(
                  label: _current.options[i],
                  state: _optionState(i),
                  onTap: () => _select(i),
                ),
                const SizedBox(height: 10),
              ],
              if (_answered) ...<Widget>[
                const SizedBox(height: 8),
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
                _index < _questions.length - 1 ? l10n.quizNext : l10n.quizSeeScore,
              ),
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
                    return Transform.scale(
                      scale: 0.6 + 0.4 * v,
                      child: child,
                    );
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
      tween: Tween<double>(begin: 1, end: state == _OptionState.idle ? 1 : 1.02),
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
            Expanded(child: Text(text, style: TextStyle(color: fg))),
          ],
        ),
      ),
    );
  }
}
