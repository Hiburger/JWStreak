import 'package:flutter/material.dart';

/// A row of small dots indicating progress through the onboarding flow. The
/// active dot is wider and uses the primary color; the others are muted.
class OnboardingProgress extends StatelessWidget {
  const OnboardingProgress({
    required this.count,
    required this.index,
    super.key,
  });

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: i == index ? 22 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index
                  ? cs.primary
                  : cs.onSurfaceVariant.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    );
  }
}
