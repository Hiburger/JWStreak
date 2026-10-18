import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../quiz/quiz_facts.dart';
import '../services/local_db_service.dart';
import '../widgets/action_glow.dart';
import '../widgets/circular_back_button.dart';
import '../theme/app_icons.dart';
import '../widgets/freeze_earned_dialog.dart';
import '../widgets/responsive_body.dart';
import 'quiz_screen.dart';

class _StarRow extends StatelessWidget {
  const _StarRow({required this.result});

  final QuizResult result;

  @override
  Widget build(BuildContext context) {
    final int stars = result.total == 0
        ? 0
        : ((result.score / result.total) * 3).ceil().clamp(1, 3);
    final AppIcons icons = AppIcons.of(context);
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      children: List<Widget>.generate(3, (int i) {
        final bool filled = i < stars;
        return icons.reward(
          size: 26,
          color: filled ? icons.rewardColor : cs.outlineVariant,
        );
      }),
    );
  }
}

/// Detail hub for a checkpoint: an optional quiz and a personal reflection.
class CheckpointScreen extends StatefulWidget {
  const CheckpointScreen({
    required this.dbService,
    required this.checkpoint,
    super.key,
  });

  final LocalDbService dbService;
  final Checkpoint checkpoint;

  @override
  State<CheckpointScreen> createState() => _CheckpointScreenState();
}

class _CheckpointScreenState extends State<CheckpointScreen>
    with SingleTickerProviderStateMixin {
  QuizResult? _result;
  String? _reflection;
  bool _isLoading = true;

  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
    _load();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  Widget _staggered({
    required double from,
    required double to,
    required Widget child,
  }) {
    final CurvedAnimation animation = CurvedAnimation(
      parent: _entranceController,
      curve: Interval(from, to, curve: Curves.easeOutCubic),
    );
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.18),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      ),
    );
  }

  Future<void> _load() async {
    final QuizResult? result = widget.checkpoint.hasQuiz
        ? await widget.dbService.getQuizResult(widget.checkpoint.id)
        : null;
    final String? reflection = await widget.dbService.getReflection(
      widget.checkpoint.id,
    );
    if (mounted) {
      setState(() {
        _result = result;
        _reflection = reflection;
        _isLoading = false;
      });
    }
  }

  Future<void> _startQuiz() async {
    final Checkpoint cp = widget.checkpoint;
    final String title = localizedCheckpointTitle(context, cp);
    final String languageCode = Localizations.localeOf(context).languageCode;
    final String? funFact = checkpointFactFor(
      cp.id,
      languageCode: languageCode,
    );
    try {
      final bool hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 30);
      }
    } catch (_) {
      // haptics are best-effort; shoudl never  block starting the quiz on them.
    }
    if (!mounted) {
      return;
    }
    bool freezeEarned = false;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => QuizScreen(
          title: title,
          questions: cp.questions,
          funFact: funFact,
          onCompleted: (int score, int total) async {
            freezeEarned = await widget.dbService.saveQuizResult(
              quizId: cp.id,
              score: score,
              total: total,
            );
          },
        ),
      ),
    );
    await _load();
    // Shown after returning from the quiz's own score screen, rather than
    // stacked on top of it, so the user sees their result first.
    if (freezeEarned && mounted) {
      await showFreezeEarnedDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Checkpoint cp = widget.checkpoint;

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        toolbarHeight: 86,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              localizedCheckpointTitle(context, cp),
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
            Text(
              l10n.checkpointAppBarTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              cs.surface,
              cs.primaryContainer.withValues(alpha: 0.35),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: ResponsiveBody(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                if (cp.hasQuiz) ...<Widget>[
                                  _staggered(
                                    from: 0,
                                    to: 0.4,
                                    child: _CardShell(
                                      icon: Icons.quiz_outlined,
                                      iconColor: cs.onPrimaryContainer,
                                      iconBg: cs.primaryContainer,
                                      title: l10n.checkpointQuizLabel,
                                      subtitle: _result == null
                                          ? l10n.checkpointQuestionCount(
                                              cp.questions.length,
                                            )
                                          : l10n.checkpointBestScore(
                                              _result!.score,
                                              _result!.total,
                                            ),
                                      child: _result == null
                                          ? null
                                          : _StarRow(result: _result!),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                ],
                                _staggered(
                                  from: 0.15,
                                  to: 0.55,
                                  child: _CardShell(
                                    icon: Icons.self_improvement_outlined,
                                    iconColor: cs.onSecondaryContainer,
                                    iconBg: cs.secondaryContainer,
                                    title: l10n.checkpointPersonalReflection,
                                    subtitle: localizedReflectionPrompt(
                                      context,
                                      cp,
                                    ),
                                    child: _ReflectionField(
                                      dbService: widget.dbService,
                                      checkpoint: cp,
                                      initialText: _reflection ?? '',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (cp.hasQuiz) ...<Widget>[
                          const SizedBox(height: 16),
                          _staggered(
                            from: 0.3,
                            to: 0.8,
                            child: ActionGlow(
                              borderRadius: BorderRadius.circular(999),
                              child: FilledButton.icon(
                                onPressed: _startQuiz,
                                style: FilledButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56),
                                  shape: const StadiumBorder(),
                                ),
                                icon: Icon(
                                  _result == null
                                      ? Icons.play_arrow
                                      : Icons.replay,
                                ),
                                label: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    _result == null
                                        ? l10n.checkpointStart
                                        : l10n.checkpointRedoQuiz,
                                    style: const TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.child,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  /// Optional body under the header; null leaves the card as a plain row.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Widget? body = child;
    return Card.filled(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: iconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (body != null) ...<Widget>[const SizedBox(height: 14), body],
          ],
        ),
      ),
    );
  }
}

class _ReflectionField extends StatefulWidget {
  const _ReflectionField({
    required this.dbService,
    required this.checkpoint,
    required this.initialText,
  });

  final LocalDbService dbService;
  final Checkpoint checkpoint;
  final String initialText;

  @override
  State<_ReflectionField> createState() => _ReflectionFieldState();
}

class _ReflectionFieldState extends State<_ReflectionField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialText,
  );
  late final FocusNode _focusNode = FocusNode();
  Timer? _savedFlashTimer;
  bool _showSaved = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    _savedFlashTimer?.cancel();
    super.dispose();
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      _save();
    }
  }

  Future<void> _save() async {
    await widget.dbService.saveReflection(
      promptId: widget.checkpoint.id,
      book: widget.checkpoint.bookId,
      chapter: widget.checkpoint.afterChapter,
      answer: _controller.text.trim(),
    );
    if (!mounted) {
      return;
    }

    setState(() => _showSaved = true);
    _savedFlashTimer?.cancel();
    _savedFlashTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showSaved = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: _controller,
          focusNode: _focusNode,
          minLines: 3,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (_) {
            _focusNode.unfocus();
          },
          decoration: InputDecoration(
            hintText: l10n.checkpointReflectionHint,
            filled: true,
            fillColor: cs.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: cs.primary, width: 2),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 18,
          child: AnimatedOpacity(
            opacity: _showSaved ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.check_rounded, size: 16, color: cs.primary),
                const SizedBox(width: 4),
                Text(
                  l10n.checkpointReflectionSaved,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
