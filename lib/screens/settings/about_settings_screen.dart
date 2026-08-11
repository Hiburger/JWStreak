import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../services/local_db_service.dart';
import '../../services/notification_service.dart';
import '../../widgets/tap_easter_egg.dart';
import 'settings_common.dart';

/// The page nobody needs day to day: replay the tour, check the version,
/// find the source, get in touch. Also where the app says who it is (and
/// who it isn't) — the footer belongs next to the license, not underneath
/// a list of switches.
class AboutSettingsScreen extends StatefulWidget {
  const AboutSettingsScreen({super.key});

  @override
  State<AboutSettingsScreen> createState() => _AboutSettingsScreenState();
}

class _AboutSettingsScreenState extends State<AboutSettingsScreen> {
  String _version = '...';

  // Secret: tap the version row 7 times (the classic Android "developer
  // options" gag) for a little wink — there's no real hidden mode here.
  static const int _versionTapsToTrigger = 7;
  static const Duration _versionTapWindow = Duration(milliseconds: 1500);
  int _versionTapCount = 0;
  DateTime? _versionLastTap;

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (!mounted) {
        return;
      }
      setState(() {
        // Version name only: the build number after the "+" is an Android
        // bookkeeping detail, not something a reader gets anything out of.
        _version = packageInfo.version;
      });
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  void _handleVersionTap() {
    final DateTime now = DateTime.now();
    if (_versionLastTap == null ||
        now.difference(_versionLastTap!) > _versionTapWindow) {
      _versionTapCount = 0;
    }
    _versionLastTap = now;
    _versionTapCount++;

    if (_versionTapCount >= _versionTapsToTrigger) {
      _versionTapCount = 0;
      _versionLastTap = null;
      LocalDbService().markEasterEggFound('version');
      _showVersionEasterEggDialog();
    }
  }

  Future<void> _showVersionEasterEggDialog() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        icon: const Icon(Icons.auto_awesome_rounded, size: 32),
        title: Text(l10n.easterEggVersionTitle),
        content: Text(l10n.easterEggVersionBody),
        actions: <Widget>[
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.easterEggVersionButton),
          ),
        ],
      ),
    );
  }

  /// Opens Flutter's built-in Material license page, which lists the
  /// open-source licenses of every bundled dependency. The app's own GPLv3
  /// terms are shown as the legalese under the app name.
  void _showLicenses() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    showLicensePage(
      context: context,
      applicationName: 'JW Streak',
      applicationVersion: _version,
      applicationLegalese: l10n.settingsLicenseLegalese,
    );
  }

  /// Clears the "tour already seen" flag and returns to the home screen,
  /// which re-checks the flag on resume and replays the walkthrough there.
  ///
  /// Pops all the way back rather than one route: the tour now lives two
  /// pages deep (settings hub, then this page), and it points at widgets on
  /// the home screen, so stopping at the hub would leave it waiting behind
  /// a page that never shows it.
  Future<void> _replayGuidedTour() async {
    final NavigatorState navigator = Navigator.of(context);
    try {
      await LocalDbService().resetGuidedTour();
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
      return;
    }
    navigator.popUntil((Route<dynamic> route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);

    return SettingsPage(
      title: l10n.settingsCatAbout,
      children: <Widget>[
        Card.filled(
          shape: sectionShape,
          child: ListTile(
            leading: const Icon(Icons.explore_outlined),
            title: Text(l10n.settingsReplayTour),
            subtitle: Text(l10n.settingsReplayTourSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: _replayGuidedTour,
          ),
        ),
        const SizedBox(height: 16),
        SettingsSectionLabel(l10n.settingsInfo),
        Card.filled(
          shape: sectionShape,
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: Text(l10n.settingsVersionLabel),
                subtitle: Text(_version),
                onTap: _handleVersionTap,
              ),
              ListTile(
                leading: const Icon(Icons.code_outlined),
                title: Text(l10n.settingsSourceCode),
                subtitle: Text(kGithubRepoUrl),
                trailing: const Icon(Icons.open_in_new_rounded, size: 20),
                onTap: () => openExternalUri(Uri.parse(kGithubRepoUrl)),
              ),
              ListTile(
                leading: const Icon(Icons.waving_hand),
                title: Text(l10n.settingsQuestion),
                subtitle: const Text(kSupportEmail),
                trailing: const Icon(Icons.open_in_new_rounded, size: 20),
                onTap: () => openExternalUri(
                  Uri(
                    scheme: 'mailto',
                    path: kSupportEmail,
                    queryParameters: <String, String>{
                      'subject': 'Support JW Streak',
                    },
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: Text(l10n.settingsLicense),
                subtitle: const Text('GNU GPLv3'),
                trailing: const Icon(Icons.chevron_right),
                onTap: _showLicenses,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          l10n.settingsFooter,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.settingsUnaffiliated,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.only(bottom: 24),
          child: Center(child: _HeartEasterEgg()),
        ),
      ],
    );
  }
}

class _HeartEasterEgg extends StatefulWidget {
  const _HeartEasterEgg();

  @override
  State<_HeartEasterEgg> createState() => _HeartEasterEggState();
}

class _HeartEasterEggState extends State<_HeartEasterEgg> {
  // Cycles through on every tap, wrapping back to the theme's own primary
  // color at 0 — so the heart starts and ends looking like a normal icon,
  // with the color play only showing up while someone's actually tapping.
  static const List<Color> _colors = <Color>[
    Colors.pinkAccent,
    Colors.deepOrange,
    Colors.amber,
    Colors.lightGreen,
    Colors.teal,
    Colors.lightBlue,
    Colors.deepPurpleAccent,
  ];

  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final Color color = _tapCount == 0
        ? Theme.of(context).colorScheme.primary
        : _colors[(_tapCount - 1) % _colors.length];
    return TapEasterEgg(
      onTapCount: (int count) => setState(() => _tapCount = count),
      onTriggered: () {
        LocalDbService().markEasterEggFound('heart');
        NotificationService().showInstantMessage(
          title: 'JW Streak 💛',
          body: l10n.easterEggHeartBody,
        );
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 150),
        child: Icon(
          Icons.favorite,
          key: ValueKey<Color>(color),
          size: 64,
          color: color,
        ),
      ),
    );
  }
}
