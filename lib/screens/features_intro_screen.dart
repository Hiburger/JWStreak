import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/onboarding_progress.dart';

/// Second onboarding page: a dedicated tour of the app's primary features,
/// with a little more explanation than the welcome splash.
class FeaturesIntroScreen extends StatelessWidget {
  const FeaturesIntroScreen({
    required this.onNext,
    required this.onBack,
    required this.stepCount,
    required this.stepIndex,
    this.hideActionButton = false,
    super.key,
  });

  final VoidCallback onNext;
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
              const SizedBox(height: 4),
              Text(
                l10n.onbFeaturesTitle,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.onbFeaturesSubtitle,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // A plain fixed Column so the page doesn't feel
                    // draggable on normal screens; the ConstrainedBox +
                    // SingleChildScrollView is only a safety net so nothing
                    // gets clipped on unusually short screens.
                    return SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _FeatureCard(
                              icon: Icons.auto_stories_outlined,
                              accent: kAccentBlue,
                              title: l10n.onbFeatureReadingTitle,
                              desc: l10n.onbFeatureReadingDesc,
                            ),
                            _FeatureCard(
                              icon: Icons.quiz_outlined,
                              accent: kAccentAmber,
                              title: l10n.onbFeatureQuizTitle,
                              desc: l10n.onbFeatureQuizDesc,
                            ),
                            _FeatureCard(
                              icon: Icons.edit_note_rounded,
                              accent: kAccentTeal,
                              title: l10n.onbFeatureNotesTitle,
                              desc: l10n.onbFeatureNotesDesc,
                            ),
                            _FeatureCard(
                              icon: Icons.lock_outline_rounded,
                              accent: kAccentPurple,
                              title: l10n.onbFeaturePrivacyTitle,
                              desc: l10n.onbFeaturePrivacyDesc,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
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

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.accent,
    required this.title,
    required this.desc,
  });

  final IconData icon;
  final OnboardingAccent accent;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: accent.background(context),
                borderRadius: BorderRadius.circular(13),
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
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: cs.onSurfaceVariant,
                      height: 1.35,
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
