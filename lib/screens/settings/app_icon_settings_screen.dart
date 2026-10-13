import 'package:flutter/material.dart';

import '../../app_constants.dart';
import '../../l10n/app_localizations.dart';
import 'settings_common.dart';

/// The app-icon settings page. Icon switching isn't built yet, so this page
/// says so honestly and shows what the choice will look like once it is

class AppIconSettingsScreen extends StatelessWidget {
  const AppIconSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return SettingsPage(
      title: l10n.settingsCatAppIcon,
      children: <Widget>[
        Card.filled(
          shape: settingsSectionShape(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.appIconComingSoonTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appIconComingSoonBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                // The current icon plus a handful of locked slots: it makes
                // the page feel like a preview of the picker to come, and
                // keeps the layout from being one lonely paragraph. A Wrap
                // rather than a Row so an unusually narrow window can drop
                // the last slot to a second line instead of overflowing.
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        'assets/icon_onboarding.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: cs.outlineVariant),
                        ),
                        child: Icon(
                          Icons.lock_outline_rounded,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card.filled(
          shape: settingsSectionShape(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.appIconSuggestionsTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appIconSuggestionsBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.tonalIcon(
                    onPressed: () => openExternalUri(
                      Uri(
                        scheme: 'mailto',
                        path: kSupportEmail,
                        queryParameters: <String, String>{
                          'subject': 'JW Streak app icon',
                        },
                      ),
                    ),
                    icon: const Icon(Icons.mail_outline_rounded),
                    label: Text(l10n.appIconSuggestionsButton),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
