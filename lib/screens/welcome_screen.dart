import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

import '../l10n/app_localizations.dart';
import '../widgets/onboarding_progress.dart';

/// First-launch welcome screen: a warm splash that kicks off onboarding.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    required this.onContinue,
    required this.stepCount,
    required this.stepIndex,
    this.hideActionButton = false,
    super.key,
  });

  /// Called when the user taps the big welcome button. The parent advances the
  /// onboarding flow.
  final Future<void> Function() onContinue;
  final int stepCount;
  final int stepIndex;

  /// True while the user is manually dragging the onboarding PageView — the
  /// button fades out so it doesn't compete with the swipe gesture.
  final bool hideActionButton;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

/// The logo artwork's own purple (sampled from the icon), used for its glow
/// so it stays consistent regardless of the device's dynamic (Material You)
/// theme color.
const Color _kLogoPurple = Color(0xFFD5A5EE);
const double _kLogoSize = 116;
const double _kLogoGlowSize = 124;

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  bool _isLeaving = false;
  bool _showGreeting = false;
  Timer? _greetingTimer;

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
    _greetingTimer?.cancel();
    super.dispose();
  }

  /// Little easter egg: tapping the logo pops up a small "hi!" speech bubble
  /// for a couple of seconds.
  Future<void> _handleLogoTap() async {
    _greetingTimer?.cancel();
    setState(() => _showGreeting = true);
    try {
      final bool hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 20);
      }
    } catch (_) {
      // Haptics are best-effort.
    }
    _greetingTimer = Timer(const Duration(milliseconds: 1800), () {
      if (mounted) {
        setState(() => _showGreeting = false);
      }
    });
  }

  Future<void> _handleContinue() async {
    if (_isLeaving) {
      return;
    }
    _isLeaving = true;
    try {
      final bool hasVibrator = await Vibration.hasVibrator();
      if (hasVibrator) {
        await Vibration.vibrate(duration: 40);
      }
    } catch (_) {
      // Haptics are best-effort; never block onboarding on them.
    }
    await widget.onContinue();
  }

  /// Fade+slide entrance for one element of the staggered sequence.
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              colorScheme.surface,
              colorScheme.primaryContainer.withValues(alpha: 0.35),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Spacer(flex: 3),
                _staggered(
                  from: 0,
                  to: 0.45,
                  child: RepaintBoundary(
                    child: SizedBox(
                      width: _kLogoGlowSize,
                      height: _kLogoGlowSize,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: <Widget>[
                          Center(
                            child: GestureDetector(
                              onTap: _handleLogoTap,
                              child: _LogoGlow(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(24),
                                  child: Image.asset(
                                    'assets/icon_onboarding.png',
                                    width: _kLogoSize,
                                    height: _kLogoSize,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: (_kLogoGlowSize - _kLogoSize) / 2 - 50,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: IgnorePointer(
                                child: AnimatedOpacity(
                                  opacity: _showGreeting ? 1 : 0,
                                  duration: const Duration(milliseconds: 180),
                                  child: AnimatedScale(
                                    scale: _showGreeting ? 1 : 0.7,
                                    duration: const Duration(milliseconds: 180),
                                    curve: Curves.easeOut,
                                    child: _GreetingBubble(
                                      text: AppLocalizations.of(
                                        context,
                                      )!.welcomeLogoGreeting,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _staggered(
                  from: 0.15,
                  to: 0.55,
                  child: Text(
                    'JW Streak',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                _staggered(
                  from: 0.25,
                  to: 0.65,
                  child: Text(
                    AppLocalizations.of(context)!.welcomeTagline,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                _staggered(
                  from: 0.45,
                  to: 0.85,
                  child: OnboardingProgress(
                    count: widget.stepCount,
                    index: widget.stepIndex,
                  ),
                ),
                const SizedBox(height: 20),
                _staggered(
                  from: 0.6,
                  to: 1,
                  child: AnimatedOpacity(
                    opacity: widget.hideActionButton ? 0 : 1,
                    duration: const Duration(milliseconds: 150),
                    child: IgnorePointer(
                      ignoring: widget.hideActionButton,
                      child: _PulsingGlow(
                        color: colorScheme.primary,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(999),
                        child: FilledButton(
                          onPressed: _handleContinue,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48,
                              vertical: 20,
                            ),
                            shape: const StadiumBorder(),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.welcomeButton,
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
                const SizedBox(height: 16),
                _staggered(
                  from: 0.7,
                  to: 1,
                  child: Text(
                    AppLocalizations.of(context)!.welcomeFooter,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A soft pulsing glow behind the main CTA button, matching the button's own
/// fill color so it reads as radiating rather than clashing with it.
class _PulsingGlow extends StatefulWidget {
  const _PulsingGlow({
    required this.color,
    required this.shape,
    required this.child,
    this.borderRadius,
  });

  final Color color;
  final BoxShape shape;
  final BorderRadius? borderRadius;
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
              shape: widget.shape,
              borderRadius: widget.shape == BoxShape.rectangle
                  ? widget.borderRadius
                  : null,
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

/// Rotating gradient ring + pulsing glow around the logo, echoing the "new
/// quiz unlocked" banner treatment on the home screen — same slow sweep +
/// pulse mechanic, tuned to the logo's own purple instead of amber.
class _LogoGlow extends StatefulWidget {
  const _LogoGlow({required this.child});

  final Widget child;

  @override
  State<_LogoGlow> createState() => _LogoGlowState();
}

class _LogoGlowState extends State<_LogoGlow>
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
    return RepaintBoundary(
      child: AnimatedBuilder(
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
                colors: const <Color>[
                  _kLogoPurple,
                  Color(0xFFB47FE0),
                  Color(0xFFEBD1FA),
                  _kLogoPurple,
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kLogoPurple.withValues(alpha: 0.35 + 0.3 * pulse),
                  blurRadius: 14 + 10 * pulse,
                  spreadRadius: 1 + 2 * pulse,
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

/// Small speech bubble used for the logo tap easter egg.
class _GreetingBubble extends StatelessWidget {
  const _GreetingBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          color: cs.onPrimary,
          fontWeight: FontWeight.w700,
          fontSize: 15,
        ),
      ),
    );
  }
}
