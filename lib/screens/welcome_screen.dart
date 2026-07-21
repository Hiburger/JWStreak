import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibration/vibration.dart';

import '../l10n/app_localizations.dart';

/// First-launch welcome screen. Shown once, then never again
/// (persisted via the `onboarding_done` settings key).
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({required this.onContinue, super.key});

  /// Called when the user taps the big welcome button. The parent is
  /// responsible for persisting the onboarding flag and swapping screens.
  final Future<void> Function() onContinue;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _pulseController;
  late final Animation<double> _flameScale;
  late final Animation<Color?> _flameColor;
  bool _isLeaving = false;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _flameScale = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _flameColor = ColorTween(begin: Colors.orange, end: Colors.deepOrange)
        .animate(
          CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
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
                  child: AnimatedBuilder(
                    animation: _pulseController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform.scale(
                        scale: _flameScale.value,
                        child: Icon(
                          Icons.local_fire_department,
                          size: 96,
                          color: _flameColor.value,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                _staggered(
                  from: 0.15,
                  to: 0.55,
                  child: Text(
                    'JW Streak',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
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
                const Spacer(flex: 2),
                _staggered(
                  from: 0.4,
                  to: 0.8,
                  child: Column(
                    children: <Widget>[
                      _FeatureRow(
                        icon: Icons.notifications_active_outlined,
                        label: AppLocalizations.of(context)!.welcomeFeatureReminder,
                      ),
                      const SizedBox(height: 14),
                      _FeatureRow(
                        icon: Icons.auto_stories_outlined,
                        label: AppLocalizations.of(context)!.welcomeFeatureOpen,
                      ),
                      const SizedBox(height: 14),
                      _FeatureRow(
                        icon: Icons.lock_outline,
                        label: AppLocalizations.of(context)!.welcomeFeaturePrivate,
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                _staggered(
                  from: 0.6,
                  to: 1,
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
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
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

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 22, color: colorScheme.onSecondaryContainer),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
