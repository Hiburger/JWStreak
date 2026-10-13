import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../l10n/app_localizations.dart';
import '../theme/app_icons.dart';
import '../widgets/responsive_body.dart';

/// What the user answered on the reading-return page.
enum ReadingReturnResult {
  /// They're still reading — leave the chapter unread.
  notYet,

  /// They finished — mark the chapter as read.
  markRead,

  /// They want to write a note about the passage first. Not the same as
  /// confirming it was finished: the chapter is *not* marked read on the way
  /// to the editor, exactly like the old dialog's reflection button.
  writeNote,
}

/// Pushes the reading-return page and returns what the user answered, or
/// null when they backed out of it (which reads the same as [notYet]).
Future<ReadingReturnResult?> pushReadingReturnScreen(
  BuildContext context, {
  required String reference,
  bool showWriteNote = false,
}) {
  return Navigator.of(context).push<ReadingReturnResult>(
    PageRouteBuilder<ReadingReturnResult>(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (BuildContext _, Animation<double> _, Animation<double> _) =>
          ReadingReturnScreen(
            reference: reference,
            showWriteNote: showWriteNote,
          ),
      transitionsBuilder:
          (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            final CurvedAnimation curved = CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            );
            return FadeTransition(
              opacity: curved,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 0.02),
                  end: Offset.zero,
                ).animate(curved),
                child: child,
              ),
            );
          },
    ),
  );
}

/// The full-screen replacement for the old "finished reading?" dialog, shown
/// when the user comes back from reading a chapter in JW Library or on
/// jw.org. Same visual language as the onboarding welcome: gradient wash,
/// Plus Jakarta Sans, a big glowing affirmative button.
class ReadingReturnScreen extends StatefulWidget {
  const ReadingReturnScreen({
    required this.reference,
    this.showWriteNote = false,
    super.key,
  });

  /// Display reference of the chapter they just came back from, e.g.
  /// "Genesis 1".
  final String reference;

  /// Whether to offer writing a note about the passage. The home screen
  /// offers it; the Bible browser doesn't (same as the dialogs they replace).
  final bool showWriteNote;

  @override
  State<ReadingReturnScreen> createState() => _ReadingReturnScreenState();
}

class _ReadingReturnScreenState extends State<ReadingReturnScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
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

  Future<void> _answer(ReadingReturnResult result) async {
    if (result == ReadingReturnResult.markRead) {
      try {
        final bool hasVibrator = await Vibration.hasVibrator();
        if (hasVibrator) {
          await Vibration.vibrate(duration: 40);
        }
      } catch (_) {
        // Haptics are best-effort; never block the answer on them.
      }
    }
    if (mounted) {
      Navigator.of(context).pop(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
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
          child: ResponsiveBody(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24),
                  _staggered(
                    from: 0,
                    to: 0.4,
                    child: Text(
                      l10n.readingReturnTitle(widget.reference),
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        height: 1.15,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _staggered(
                    from: 0.1,
                    to: 0.5,
                    child: Text(
                      l10n.readingSessionDoneBody,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  _staggered(
                    from: 0.3,
                    to: 0.75,
                    child: IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Expanded(
                            child: _AnswerButton(
                              word: l10n.readingReturnNo,
                              description: l10n.readingReturnNoDescription,
                              onTap: () => _answer(ReadingReturnResult.notYet),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _PulsingGlow(
                              color: cs.primary,
                              child: _AnswerButton(
                                filled: true,
                                word: l10n.readingReturnYes,
                                description: l10n.readingReturnYesDescription,
                                onTap: () =>
                                    _answer(ReadingReturnResult.markRead),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (widget.showWriteNote) ...<Widget>[
                    const SizedBox(height: 12),
                    _staggered(
                      from: 0.45,
                      to: 0.9,
                      child: TextButton.icon(
                        onPressed: () => _answer(ReadingReturnResult.writeNote),
                        icon: Icon(AppIcons.of(context).notes, size: 20),
                        label: Text(l10n.readingReturnWriteNote),
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// One of the two big answers. The word carries the answer; the description
/// under it says what tapping it will actually do, so the buttons can be
/// big enough to hit without the label having to hedge ("Yes" alone is
/// ambiguous once the description has left the screen).
class _AnswerButton extends StatelessWidget {
  const _AnswerButton({
    required this.word,
    required this.description,
    required this.onTap,
    this.filled = false,
  });

  final String word;
  final String description;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextStyle wordStyle = TextStyle(
      fontFamily: 'PlusJakartaSans',
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: filled ? cs.onPrimary : cs.onSurface,
    );
    final TextStyle descriptionStyle = TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w500,
      color: filled
          ? cs.onPrimary.withValues(alpha: 0.85)
          : cs.onSurfaceVariant,
    );
    final Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(word, style: wordStyle),
        const SizedBox(height: 3),
        Text(description, style: descriptionStyle, textAlign: TextAlign.center),
      ],
    );
    if (filled) {
      return FilledButton(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: content,
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        side: BorderSide(color: cs.outlineVariant, width: 1.5),
      ),
      child: content,
    );
  }
}

/// A soft pulsing glow behind the "Yes" button, matching the welcome
/// screen's treatment of its own primary action.
class _PulsingGlow extends StatefulWidget {
  const _PulsingGlow({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  State<_PulsingGlow> createState() => _PulsingGlowState();
}

class _PulsingGlowState extends State<_PulsingGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          final double t = _controller.value;
          return DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: widget.color.withValues(alpha: 0.25 + 0.25 * t),
                  blurRadius: 16 + 14 * t,
                  spreadRadius: 1 + 3 * t,
                ),
              ],
            ),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
