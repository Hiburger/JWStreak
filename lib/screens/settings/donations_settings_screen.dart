import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/onboarding_accent.dart';
import 'settings_common.dart';

/// Says plainly that donations aren't open yet, and why they might be one
/// day. A whole page rather than a line in About: someone who taps
/// "Donations" is offering something, and answering that with a single grey
/// sentence reads as brushing them off. There is deliberately nothing to tap
/// through to — no payment link, no waitlist, no email capture — so the page
/// can't be mistaken for an ask.
class DonationsSettingsScreen extends StatelessWidget {
  const DonationsSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);

    return SettingsPage(
      title: l10n.settingsCatDonations,
      children: <Widget>[
        Card.filled(
          shape: sectionShape,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              children: <Widget>[
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: kAccentPink.background(context),
                    border: Border.all(
                      color: kAccentPink
                          .foreground(context)
                          .withValues(alpha: 0.4),
                    ),
                  ),
                  child: Icon(
                    Icons.volunteer_activism_outlined,
                    size: 32,
                    color: kAccentPink.foreground(context),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.donationsHeadline,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.donationsLead,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card.filled(
          shape: sectionShape,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: <Widget>[
                _DonationRow(
                  icon: Icons.receipt_long_outlined,
                  title: l10n.donationsRow1Title,
                  text: l10n.donationsRow1Text,
                ),
                _DonationRow(
                  icon: Icons.lock_open_rounded,
                  title: l10n.donationsRow2Title,
                  text: l10n.donationsRow2Text,
                ),
                _DonationRow(
                  icon: Icons.favorite_outline_rounded,
                  title: l10n.donationsRow3Title,
                  text: l10n.donationsRow3Text,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.donationsThanks,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}

class _DonationRow extends StatelessWidget {
  const _DonationRow({
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
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 20, color: cs.onSurfaceVariant),
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
                  style: theme.textTheme.bodySmall?.copyWith(
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
