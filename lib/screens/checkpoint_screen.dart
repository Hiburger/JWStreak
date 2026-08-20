import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../quiz/quiz_facts.dart';
import '../services/local_db_service.dart';
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

class _CheckpointScreenState extends State<CheckpointScreen> {
  QuizResult? _result;
  String? _reflection;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
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
    final String? funFact = checkpointFactFor(
      cp.id,
      languageCode: Localizations.localeOf(context).languageCode,
    );
    bool freezeEarned = false;
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => QuizScreen(
          title: localizedCheckpointTitle(context, cp),
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

  Future<void> _answerReflection() async {
    await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => ReflectionScreen(
          dbService: widget.dbService,
          checkpoint: widget.checkpoint,
        ),
      ),
    );
    await _load();
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
        title: Text(l10n.checkpointAppBarTitle),
      ),
      body: ResponsiveBody(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: cs.tertiaryContainer,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.workspace_premium_outlined,
                          color: cs.onTertiaryContainer,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          localizedCheckpointTitle(context, cp),
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (cp.hasQuiz) ...<Widget>[
                    _CardShell(
                      icon: Icons.quiz_outlined,
                      iconColor: cs.onPrimaryContainer,
                      iconBg: cs.primaryContainer,
                      title: l10n.checkpointQuizLabel,
                      subtitle: _result == null
                          ? l10n.checkpointQuestionCount(cp.questions.length)
                          : l10n.checkpointBestScore(
                              _result!.score,
                              _result!.total,
                            ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (_result != null) ...<Widget>[
                            _StarRow(result: _result!),
                            const SizedBox(height: 12),
                          ],
                          FilledButton.icon(
                            onPressed: _startQuiz,
                            icon: Icon(
                              _result == null ? Icons.play_arrow : Icons.replay,
                            ),
                            label: Text(
                              _result == null
                                  ? l10n.checkpointStart
                                  : l10n.checkpointRedoQuiz,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                  _CardShell(
                    icon: Icons.self_improvement_outlined,
                    iconColor: cs.onSecondaryContainer,
                    iconBg: cs.secondaryContainer,
                    title: l10n.checkpointPersonalReflection,
                    subtitle: localizedReflectionPrompt(context, cp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (_reflection != null && _reflection!.isNotEmpty) ...[
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(_reflection!),
                          ),
                          const SizedBox(height: 12),
                        ],
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FilledButton.tonalIcon(
                            onPressed: _answerReflection,
                            icon: Icon(
                              _reflection == null
                                  ? Icons.edit_outlined
                                  : Icons.edit,
                            ),
                            label: Text(
                              _reflection == null
                                  ? l10n.checkpointAnswer
                                  : l10n.checkpointEdit,
                            ),
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

class _CardShell extends StatelessWidget {
  const _CardShell({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Card.filled(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerHigh,
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
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }
}

/// Simple editor for a checkpoint reflection answer. Stored privately.
class ReflectionScreen extends StatefulWidget {
  const ReflectionScreen({
    required this.dbService,
    required this.checkpoint,
    super.key,
  });

  final LocalDbService dbService;
  final Checkpoint checkpoint;

  @override
  State<ReflectionScreen> createState() => _ReflectionScreenState();
}

class _ReflectionScreenState extends State<ReflectionScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final String? existing = await widget.dbService.getReflection(
      widget.checkpoint.id,
    );
    if (mounted) {
      setState(() {
        _controller.text = existing ?? '';
        _isLoading = false;
      });
    }
  }

  Future<void> _save() async {
    await widget.dbService.saveReflection(
      promptId: widget.checkpoint.id,
      book: widget.checkpoint.bookId,
      chapter: widget.checkpoint.afterChapter,
      answer: _controller.text.trim(),
    );
    if (mounted) {
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.checkpointReflectionAppBarTitle),
      ),
      body: ResponsiveBody(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.all(20),
                      children: <Widget>[
                        Text(
                          localizedReflectionPrompt(context, widget.checkpoint),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _controller,
                          autofocus: true,
                          minLines: 6,
                          maxLines: null,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: l10n.checkpointReflectionHint,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Inside the body rather than Scaffold.bottomNavigationBar:
                  // that slot is pinned to the bottom of the screen and gets
                  // no keyboard inset, so with the field focused the keyboard
                  // covered Save completely and there was no way to finish a
                  // reflection. The body *is* resized for the keyboard, so
                  // sitting at the end of this column keeps Save just above it.
                  SafeArea(
                    top: false,
                    minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.check),
                      label: Text(l10n.checkpointSave),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
