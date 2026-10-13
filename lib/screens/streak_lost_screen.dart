import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_icons.dart';
import '../widgets/responsive_body.dart';

// streak lost ? sorry!
Future<void> pushStreakLostScreen(BuildContext context) {
  return Navigator.of(context).push<void>(
    PageRouteBuilder<void>(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (BuildContext _, Animation<double> _, Animation<double> _) =>
          const StreakLostScreen(),
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

class StreakLostScreen extends StatefulWidget {
  const StreakLostScreen({super.key});

  @override
  State<StreakLostScreen> createState() => _StreakLostScreenState();
}

const Color _kFrozenBlue = Color(0xFF4FC3F7);

class _StreakLostScreenState extends State<StreakLostScreen>
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

  Future<void> _handleDismiss() async {
    try {
      final bool hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 30);
      }
    } catch (_) {
      // haptics are best-effort never block dismissing on them
    }
    if (mounted) {
      Navigator.of(context).pop();
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
                  const Spacer(flex: 3),
                  _staggered(
                    from: 0,
                    to: 0.4,
                    child: Center(
                      child: RepaintBoundary(
                        child: _FrozenGlowRing(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(24),
                            child: Container(
                              width: 96,
                              height: 96,
                              color: cs.surfaceContainerHigh,
                              child: Icon(
                                AppIcons.of(context).frozen,
                                size: 48,
                                color: _kFrozenBlue,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _staggered(
                    from: 0.15,
                    to: 0.55,
                    child: Text(
                      l10n.streakLostTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1,
                        height: 1.15,
                        color: cs.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _staggered(
                    from: 0.25,
                    to: 0.65,
                    child: Text(
                      l10n.homeStreakLostMessage,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Spacer(flex: 3),
                  _staggered(
                    from: 0.45,
                    to: 0.9,
                    child: Center(
                      child: RepaintBoundary(
                        child: _PulsingGlow(
                          color: cs.primary,
                          child: FilledButton(
                            onPressed: _handleDismiss,
                            style: FilledButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 48,
                                vertical: 20,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: Text(
                              l10n.streakLostButton,
                              style: const TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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

class _FrozenGlowRing extends StatefulWidget {
  const _FrozenGlowRing({required this.child});

  final Widget child;

  @override
  State<_FrozenGlowRing> createState() => _FrozenGlowRingState();
}

class _FrozenGlowRingState extends State<_FrozenGlowRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double angle = _controller.value * 2 * math.pi;
        final double pulse =
            0.5 + 0.5 * math.sin(_controller.value * 2 * math.pi);
        return Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(27),
            gradient: SweepGradient(
              transform: GradientRotation(angle),
              colors: <Color>[
                _kFrozenBlue,
                _kFrozenBlue.withValues(alpha: 0.4),
                _kFrozenBlue.withValues(alpha: 0.8),
                _kFrozenBlue,
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kFrozenBlue.withValues(alpha: 0.35 + 0.3 * pulse),
                blurRadius: 14 + 10 * pulse,
                spreadRadius: 1 + 2 * pulse,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// A soft pulsing glow behind the dismiss button, matching the welcome
/// screen's primary-action treatment.
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
    return AnimatedBuilder(
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
    );
  }
}
