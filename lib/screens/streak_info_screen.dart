import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/onboarding_progress.dart';

/// Onboarding page explaining the streak + match mechanic so users understand
/// how to keep their series alive.
class StreakInfoScreen extends StatelessWidget {
  const StreakInfoScreen({
    required this.onNext,
    required this.onBack,
    required this.stepCount,
    required this.stepIndex,
    this.hideActionButton = false,
    super.key,
  });

  final Future<void> Function() onNext;
  final VoidCallback onBack;
  final int stepCount;
  final int stepIndex;

  /// True while the user is manually dragging the onboarding PageView — the
  /// button fades out so it doesn't compete with the swipe gesture.
  final bool hideActionButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  tooltip: l10n.onbBack,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: kAccentAmber.background(context),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: kAccentAmber.foreground(context),
                  size: 34,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                AppLocalizations.of(context)!.streakInfoTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                AppLocalizations.of(context)!.streakInfoSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _InfoRow(
                              icon: Icons.check_circle_outline,
                              accent: kAccentBlue,
                              title: AppLocalizations.of(
                                context,
                              )!.streakInfoRow1Title,
                              text: AppLocalizations.of(
                                context,
                              )!.streakInfoRow1Text,
                            ),
                            _InfoRow(
                              icon: Icons.whatshot_rounded,
                              accent: kAccentAmber,
                              title: AppLocalizations.of(
                                context,
                              )!.streakInfoRow2Title,
                              text: AppLocalizations.of(
                                context,
                              )!.streakInfoRow2Text,
                            ),
                            _InfoRow(
                              icon: Icons.workspace_premium_outlined,
                              accent: kAccentPurple,
                              title: AppLocalizations.of(
                                context,
                              )!.streakInfoRow3Title,
                              text: AppLocalizations.of(
                                context,
                              )!.streakInfoRow3Text,
                            ),
                            _InfoRow(
                              icon: Icons.notifications_active_outlined,
                              accent: kAccentTeal,
                              title: AppLocalizations.of(
                                context,
                              )!.streakInfoRow4Title,
                              text: AppLocalizations.of(
                                context,
                              )!.streakInfoRow4Text,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              OnboardingProgress(count: stepCount, index: stepIndex),
              const SizedBox(height: 16),
              AnimatedOpacity(
                opacity: hideActionButton ? 0 : 1,
                duration: const Duration(milliseconds: 150),
                child: IgnorePointer(
                  ignoring: hideActionButton,
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: onNext,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.accent,
    required this.title,
    required this.text,
  });

  final IconData icon;
  final OnboardingAccent accent;
  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accent.background(context),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent.foreground(context), size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  text,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
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
