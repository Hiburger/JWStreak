import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../reading_plan.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/onboarding_progress.dart';
import '../widgets/responsive_body.dart';

/// Onboarding page for picking the order chapters arrive in.
///
/// Each option gets a line explaining what it actually does — "chronological"
/// and "as it was written" sound like the same thing to anyone who hasn't met
/// the distinction before, and a list of bare names would make this a guess.
class ReadingPlanOnboardingScreen extends StatelessWidget {
  const ReadingPlanOnboardingScreen({
    required this.onNext,
    required this.onBack,
    required this.stepCount,
    required this.stepIndex,
    required this.selected,
    required this.onPlanChanged,
    required this.canContinue,
    this.hideActionButton = false,
    super.key,
  });

  final VoidCallback onNext;
  final VoidCallback onBack;
  final int stepCount;
  final int stepIndex;

  /// Null until the reader taps an option — nothing is pre-selected, even
  /// though [ReadingPlan] itself always defaults to canonical once a value
  /// exists. Showing canonical as "already chosen" on a page whose whole
  /// point is to choose would have been misleading.
  final ReadingPlan? selected;
  final ValueChanged<ReadingPlan> onPlanChanged;

  /// Whether the reader has explicitly tapped an option — [selected] always
  /// has a value (it defaults to canonical), so it alone can't distinguish
  /// "picked the default on purpose" from "never touched this page".
  final bool canContinue;

  final bool hideActionButton;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: ResponsiveBody(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    style: circularIconButtonStyle(context),
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                    tooltip: l10n.onbBack,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.onbPlanTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.onbPlanSubtitle,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      for (final ReadingPlan plan in ReadingPlan.values)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: PlanOptionTile(
                            plan: plan,
                            selected: plan == selected,
                            onTap: () => onPlanChanged(plan),
                          ),
                        ),
                    ],
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
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: canContinue ? onNext : null,
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
                        if (!canContinue) ...<Widget>[
                          const SizedBox(height: 8),
                          Text(
                            l10n.onbChooseToContinue,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// One selectable reading order. Public because settings offers the same
/// choice, and two pickers that drift apart would be worse than one shared
/// row.
class PlanOptionTile extends StatelessWidget {
  const PlanOptionTile({
    required this.plan,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final ReadingPlan plan;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Material(
      color: selected ? cs.primaryContainer : cs.surfaceContainerLow,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: selected ? cs.primary : cs.outlineVariant,
          width: selected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                plan.icon,
                size: 24,
                color: selected ? cs.onPrimaryContainer : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      plan.label(context),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: selected ? cs.onPrimaryContainer : null,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      plan.description(context),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: selected
                            ? cs.onPrimaryContainer.withValues(alpha: 0.85)
                            : cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
