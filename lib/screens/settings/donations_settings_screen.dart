import 'package:flutter/material.dart';

import '../../app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/onboarding_accent.dart';
import 'settings_common.dart';

/// Explains what supporting the project does and doesn't mean, and offers a
/// single way to do it. A whole page rather than a line in About: someone who
/// taps "Donations" is offering something, and answering that with one grey
/// sentence reads as brushing them off.
///
/// Two constraints shape this page, and both are load-bearing:
///
/// * Money is only ever collected **outside** the app, by handing GitHub to
///   the system browser. Apple's guideline 3.2.2(iv) allows a free app to
///   raise funds only that way; collecting in-app would require in-app
///   purchase. Never switch this to an in-app browser view.
/// * Sponsoring unlocks **nothing**. Guideline 3.2.1(vii) requires in-app
///   purchase for any gift tied to receiving digital content, and Google Play
///   billing attaches to payment "for access to in-app features". Keeping the
///   app identical for supporters is what keeps this a plain link rather than
///   a purchase — so never gate a theme, badge or feature behind it.
///
/// It also says in as many words that this supports the developer and is not
/// a religious donation: the app is unaffiliated, and someone tapping through
/// from a Bible-reading app should not have to guess where their money goes.
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
        const SizedBox(height: 20),
        FilledButton.icon(
          onPressed: () => openExternalUri(Uri.parse(kGithubSponsorsUrl)),
          icon: const Icon(Icons.favorite_rounded, size: 20),
          label: Text(l10n.donationsSponsorButton),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            backgroundColor: kAccentPink.background(context),
            foregroundColor: kAccentPink.foreground(context),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          l10n.donationsSponsorDisclaimer,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: cs.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        // Deliberately below the disclaimer and styled as the quieter
        // option: it costs nothing, so it should read as the free
        // alternative to sponsoring rather than compete with it. Points at
        // the repository, not the sponsors page — no money involved.
        TextButton.icon(
          onPressed: () => openExternalUri(Uri.parse(kGithubRepoUrl)),
          icon: const Icon(Icons.star_outline_rounded, size: 20),
          label: Text(l10n.donationsStarButton),
        ),
        const SizedBox(height: 16),
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
