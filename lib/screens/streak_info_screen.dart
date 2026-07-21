import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Second onboarding page (shown once, right after the welcome page): explains
/// the streak + freeze mechanic so users understand how to keep their series.
class StreakInfoScreen extends StatelessWidget {
  const StreakInfoScreen({required this.onDone, super.key});

  final Future<void> Function() onDone;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: cs.tertiaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  Icons.local_fire_department_rounded,
                  color: cs.onTertiaryContainer,
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
              const SizedBox(height: 28),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    _InfoRow(
                      icon: Icons.check_circle_outline,
                      title: AppLocalizations.of(context)!.streakInfoRow1Title,
                      text: AppLocalizations.of(context)!.streakInfoRow1Text,
                    ),
                    _InfoRow(
                      icon: Icons.ac_unit_rounded,
                      title: AppLocalizations.of(context)!.streakInfoRow2Title,
                      text: AppLocalizations.of(context)!.streakInfoRow2Text,
                    ),
                    _InfoRow(
                      icon: Icons.workspace_premium_outlined,
                      title: AppLocalizations.of(context)!.streakInfoRow3Title,
                      text: AppLocalizations.of(context)!.streakInfoRow3Text,
                    ),
                    _InfoRow(
                      icon: Icons.notifications_active_outlined,
                      title: AppLocalizations.of(context)!.streakInfoRow4Title,
                      text: AppLocalizations.of(context)!.streakInfoRow4Text,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: onDone,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.streakInfoButton,
                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
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
    required this.title,
    required this.text,
  });

  final IconData icon;
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
              color: cs.secondaryContainer,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: cs.onSecondaryContainer, size: 22),
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
