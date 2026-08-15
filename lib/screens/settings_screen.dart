import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../theme/app_skin.dart';
import '../theme/theme_preference.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/onboarding_accent.dart';
import '../widgets/responsive_body.dart';
import 'settings/about_settings_screen.dart';
import 'settings/donations_settings_screen.dart';
import 'settings/notification_settings_screen.dart';
import 'settings/personalization_settings_screen.dart';
import 'settings/privacy_settings_screen.dart';
import 'settings/reading_settings_screen.dart';
import 'settings/settings_common.dart';

/// The settings hub: a handful of doors, nothing else.
///
/// Everything used to live on this one page — styles, brightness, dynamic
/// color, how the Bible opens, reading order, resume point, language, app
/// lock, the guided tour, three permission cards, version, source, license
/// and the footer, all stacked in one scroll. Finding anything meant
/// remembering roughly how far down it was, and the page mixed decisions a
/// reader makes ("which order do I read in?") with Android plumbing they
/// shouldn't have to think about.
///
/// Splitting it into named categories means the top level fits on one
/// screen and each choice is one tap from a page that only holds related
/// things. The grouping is by what a reader is trying to do, not by what
/// the code touches — which is why "Open the Bible with" now sits under
/// Reading rather than next to the color pickers.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    required this.currentThemePreference,
    required this.onThemePreferenceChanged,
    required this.currentAppSkin,
    required this.onAppSkinChanged,
    required this.notificationService,
    this.useDynamicColor = false,
    this.onUseDynamicColorChanged,
    this.currentLocaleCode,
    this.onLocaleChanged,
    super.key,
  });

  final ThemePreference currentThemePreference;
  final Future<void> Function(ThemePreference value) onThemePreferenceChanged;
  final AppSkin currentAppSkin;
  final Future<void> Function(AppSkin value)? onAppSkinChanged;
  final NotificationService notificationService;
  final bool useDynamicColor;
  final Future<void> Function(bool value)? onUseDynamicColorChanged;

  /// null means "follow system language".
  final String? currentLocaleCode;
  final Future<void> Function(String? code)? onLocaleChanged;

  void _open(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push<void>(MaterialPageRoute<void>(builder: builder));
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.settingsTitle),
      ),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.palette_outlined,
              accent: kAccentPurple,
              title: l10n.settingsCatPersonalization,
              subtitle: l10n.settingsCatPersonalizationDesc,
              onTap: () => _open(
                context,
                (_) => PersonalizationSettingsScreen(
                  currentThemePreference: currentThemePreference,
                  onThemePreferenceChanged: onThemePreferenceChanged,
                  currentAppSkin: currentAppSkin,
                  onAppSkinChanged: onAppSkinChanged,
                  useDynamicColor: useDynamicColor,
                  onUseDynamicColorChanged: onUseDynamicColorChanged,
                  currentLocaleCode: currentLocaleCode,
                  onLocaleChanged: onLocaleChanged,
                ),
              ),
            ),
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.auto_stories_outlined,
              accent: kAccentBlue,
              title: l10n.settingsReadingSection,
              subtitle: l10n.settingsCatReadingDesc,
              onTap: () => _open(context, (_) => const ReadingSettingsScreen()),
            ),
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.notifications_outlined,
              accent: kAccentAmber,
              title: l10n.settingsCatNotifications,
              subtitle: l10n.settingsCatNotificationsDesc,
              onTap: () => _open(
                context,
                (_) => NotificationSettingsScreen(
                  notificationService: notificationService,
                ),
              ),
            ),
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.lock_outline_rounded,
              accent: kAccentTeal,
              title: l10n.settingsPrivacy,
              subtitle: l10n.settingsCatPrivacyDesc,
              onTap: () => _open(context, (_) => const PrivacySettingsScreen()),
            ),
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.volunteer_activism_outlined,
              accent: kAccentPink,
              title: l10n.settingsCatDonations,
              subtitle: l10n.settingsCatDonationsDesc,
              onTap: () =>
                  _open(context, (_) => const DonationsSettingsScreen()),
            ),
            _CategoryTile(
              shape: sectionShape,
              icon: Icons.help_outline_rounded,
              accent: kAccentOrange,
              title: l10n.settingsCatAbout,
              subtitle: l10n.settingsCatAboutDesc,
              onTap: () => _open(context, (_) => const AboutSettingsScreen()),
            ),
          ],
        ),
      ),
    );
  }
}

/// One door on the hub. The subtitle lists what's behind it in plain words
/// rather than describing the category again — it's the only thing standing
/// between a reader and a wrong guess, since the titles alone ("Reading",
/// "Notifications") don't say whether what they want is in there.
class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.shape,
    required this.icon,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final RoundedRectangleBorder shape;
  final IconData icon;

  /// A distinct color per category — identical primary-container circles
  /// all told the eye "these are the same kind of thing," which worked when
  /// there was one list to scan but fights against a row of doors meant to
  /// be told apart at a glance.
  final OnboardingAccent accent;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final Color accentFg = accent.foreground(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card.filled(
        shape: shape,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          leading: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: accent.background(context),
              // The pastel fill alone read as washed-out against the
              // card's own fill — a thin ring in the icon's own color
              // gives each circle a crisp edge without darkening the fill.
              border: Border.all(color: accentFg.withValues(alpha: 0.4)),
            ),
            child: Icon(icon, color: accentFg, size: 20),
          ),
          title: Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: cs.onSurfaceVariant,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right_rounded,
            color: cs.onSurfaceVariant,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
