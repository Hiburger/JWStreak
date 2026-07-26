import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/deep_link_service.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../theme/theme_preference.dart';
import '../widgets/message_dialog.dart';
import '../widgets/tap_easter_egg.dart';

/// A selectable UI language. The [name] is always shown in its own
/// language (endonym), regardless of the app's current locale — this is
/// the standard convention for language pickers.
class _AppLanguage {
  const _AppLanguage(this.code, this.name);

  /// null means "follow system language".
  final String? code;
  final String name;
}

const List<_AppLanguage> _kAppLanguages = <_AppLanguage>[
  _AppLanguage('en', 'English (US)'),
  _AppLanguage('fr', 'Français'),
  _AppLanguage('de', 'Deutsch'),
  _AppLanguage('pl', 'Polski'),
  _AppLanguage('it', 'Italiano'),
  _AppLanguage('es', 'Español'),
  _AppLanguage('pt', 'Português'),
  _AppLanguage('ru', 'Русский'),
  _AppLanguage('zh', '中文'),
];

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    required this.currentThemePreference,
    required this.onThemePreferenceChanged,
    required this.notificationService,
    this.useDynamicColor = false,
    this.onUseDynamicColorChanged,
    this.currentLocaleCode,
    this.onLocaleChanged,
    super.key,
  });

  final ThemePreference currentThemePreference;
  final Future<void> Function(ThemePreference value) onThemePreferenceChanged;
  final NotificationService notificationService;
  final bool useDynamicColor;
  final Future<void> Function(bool value)? onUseDynamicColorChanged;

  /// null means "follow system language".
  final String? currentLocaleCode;
  final Future<void> Function(String? code)? onLocaleChanged;

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late ThemePreference _selectedTheme;
  late bool _useDynamicColor;
  late String? _selectedLocaleCode;
  bool? _notificationsEnabled;
  bool? _exactAlarmsAllowed;
  bool _isCheckingPermissions = true;
  String _version = '...';

  // Bible target: true = open chapters in the JW Library app (default),
  // false = open on jw.org in a browser.
  bool _openInJwLibrary = true;
  final DeepLinkService _deepLinkService = DeepLinkService();

  // Secret: tap the version row 7 times (the classic Android "developer
  // options" gag) for a little wink — there's no real hidden mode here.
  static const int _versionTapsToTrigger = 7;
  static const Duration _versionTapWindow = Duration(milliseconds: 1500);
  int _versionTapCount = 0;
  DateTime? _versionLastTap;

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
        icon: const Text('🕵️', style: TextStyle(fontSize: 40)),
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

  @override
  void initState() {
    super.initState();
    _selectedTheme = widget.currentThemePreference;
    _useDynamicColor = widget.useDynamicColor;
    _selectedLocaleCode = widget.currentLocaleCode;
    _loadMetadata();
  }

  Future<void> _loadMetadata() async {
    try {
      final PackageInfo packageInfo = await PackageInfo.fromPlatform();
      final bool notificationsEnabled = await widget.notificationService
          .areNotificationsEnabled();
      final bool exactAlarmsAllowed = await widget.notificationService
          .canScheduleExactAlarms();
      final bool openOnWeb = await LocalDbService().getOpenBibleOnWeb();
      if (!mounted) {
        return;
      }
      setState(() {
        _version = '${packageInfo.version} (${packageInfo.buildNumber})';
        _notificationsEnabled = notificationsEnabled;
        _exactAlarmsAllowed = exactAlarmsAllowed;
        _openInJwLibrary = !openOnWeb;
        _isCheckingPermissions = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isCheckingPermissions = false;
      });
      _showError(error);
    }
  }

  Future<void> _changeTheme(ThemePreference preference) async {
    setState(() {
      _selectedTheme = preference;
    });
    try {
      await widget.onThemePreferenceChanged(preference);
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showError(error);
    }
  }

  Future<void> _changeUseDynamicColor(bool value) async {
    setState(() {
      _useDynamicColor = value;
    });
    final Future<void> Function(bool value)? callback =
        widget.onUseDynamicColorChanged;
    if (callback == null) {
      return;
    }
    try {
      await callback(value);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  /// Switches the Bible-opening target. When the user turns the switch toward
  /// JW Library but the app isn't installed, we don't apply the change and
  /// instead offer a link to install it.
  Future<void> _changeBibleTarget(bool wantJwLibrary) async {
    if (wantJwLibrary && !await _deepLinkService.isJwLibraryInstalled()) {
      if (mounted) {
        await _showJwLibraryRequiredDialog();
      }
      return;
    }
    setState(() {
      _openInJwLibrary = wantJwLibrary;
    });
    try {
      await LocalDbService().saveOpenBibleOnWeb(!wantJwLibrary);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  /// Clears the "tour already seen" flag and returns to the home screen,
  /// which re-checks the flag on resume and replays the walkthrough there.
  Future<void> _replayGuidedTour() async {
    final NavigatorState navigator = Navigator.of(context);
    try {
      await LocalDbService().resetGuidedTour();
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
      return;
    }
    navigator.pop();
  }

  Future<void> _showJwLibraryRequiredDialog() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme cs = Theme.of(context).colorScheme;
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        icon: Icon(Icons.menu_book_outlined, color: cs.primary),
        content: Text(
          l10n.settingsBibleTargetJwLibraryMissing,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _openExternal(Uri.parse(kJwLibraryPlayStoreUrl));
            },
            child: Text(l10n.settingsBibleTargetInstall),
          ),
        ],
      ),
    );
  }

  Future<void> _changeLocale(String? code) async {
    setState(() {
      _selectedLocaleCode = code;
    });
    final Future<void> Function(String? code)? callback =
        widget.onLocaleChanged;
    if (callback == null) {
      return;
    }
    final NavigatorState navigator = Navigator.of(context);
    navigator.push(
      PageRouteBuilder<void>(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 220),
        reverseTransitionDuration: const Duration(milliseconds: 220),
        pageBuilder: (_, _, _) => const _LocaleSwitchLoadingScreen(),
        transitionsBuilder: (_, Animation<double> animation, _, Widget child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
    try {
      await callback(code);
      await Future.delayed(const Duration(milliseconds: 1200));
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    } finally {
      navigator.pop();
    }
  }

  Future<void> _requestPermission() async {
    try {
      final bool granted = await widget.notificationService
          .requestNotificationPermission();
      if (!mounted) {
        return;
      }
      setState(() {
        _notificationsEnabled = granted;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showError(error);
    }
  }

  Future<void> _requestExactAlarms() async {
    try {
      final bool granted = await widget.notificationService
          .requestExactAlarmPermission();
      if (!mounted) {
        return;
      }
      setState(() {
        _exactAlarmsAllowed = granted;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      _showError(error);
    }
  }

  Future<void> _openExternal(Uri uri) async {
    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      throw StateError('Impossible d’ouvrir ${uri.toString()}');
    }
  }

  void _showError(Object error) {
    showMessageDialog(
      context,
      message: AppLocalizations.of(context)!.settingsError(error.toString()),
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool notificationsEnabled = _notificationsEnabled ?? false;
    final bool exactAlarmsAllowed = _exactAlarmsAllowed ?? false;

    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Text(
            l10n.settingsAppearance,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ThemePreference.values
                    .map(
                      (ThemePreference preference) => ChoiceChip(
                        label: Text(preference.label(context)),
                        selected: _selectedTheme == preference,
                        onSelected: (_) => _changeTheme(preference),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: SwitchListTile(
              title: Text(l10n.settingsDynamicColor),
              subtitle: Text(
                _useDynamicColor
                    ? l10n.settingsDynamicColorOn
                    : l10n.settingsDynamicColorOff,
              ),
              value: _useDynamicColor,
              onChanged: widget.onUseDynamicColorChanged == null
                  ? null
                  : _changeUseDynamicColor,
            ),
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: SwitchListTile(
              secondary: Icon(
                _openInJwLibrary
                    ? Icons.menu_book_outlined
                    : Icons.language_outlined,
              ),
              title: Text(l10n.settingsBibleTargetTitle),
              subtitle: Text(
                _openInJwLibrary
                    ? l10n.settingsBibleTargetJwLibrary
                    : l10n.settingsBibleTargetWeb,
              ),
              value: _openInJwLibrary,
              onChanged: _changeBibleTarget,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.settingsLanguage,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _kAppLanguages
                    .map(
                      (_AppLanguage lang) => ChoiceChip(
                        label: Text(lang.name),
                        selected: _selectedLocaleCode == lang.code,
                        onSelected: widget.onLocaleChanged == null
                            ? null
                            : (_) => _changeLocale(lang.code),
                      ),
                    )
                    .toList(growable: false),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card.filled(
            child: ListTile(
              leading: const Icon(Icons.explore_outlined),
              title: Text(l10n.settingsReplayTour),
              subtitle: Text(l10n.settingsReplayTourSubtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: _replayGuidedTour,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.settingsPermissions,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: ListTile(
              leading: Icon(
                notificationsEnabled ? Icons.check_circle : Icons.warning_amber,
                size: 32,
                color: notificationsEnabled
                    ? Colors.lightGreen
                    : Colors.redAccent,
              ),
              title: Text(l10n.settingsNotifPermTitle),
              subtitle: Text(
                _isCheckingPermissions
                    ? l10n.settingsChecking
                    : notificationsEnabled
                    ? l10n.settingsNotifActive
                    : l10n.settingsNotifMissing,
              ),
              trailing: TextButton(
                onPressed: _requestPermission,
                child: Text(l10n.settingsVerify),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Card.filled(
            child: ListTile(
              leading: Icon(
                exactAlarmsAllowed ? Icons.check_circle : Icons.warning_amber,
                size: 32,
                color: exactAlarmsAllowed
                    ? Colors.lightGreen
                    : Colors.redAccent,
              ),
              title: Text(l10n.settingsExactAlarms),
              subtitle: Text(
                _isCheckingPermissions
                    ? l10n.settingsChecking
                    : exactAlarmsAllowed
                    ? l10n.settingsExactAlarmsOn
                    : l10n.settingsExactAlarmsOff,
              ),
              trailing: TextButton(
                onPressed: _requestExactAlarms,
                child: Text(l10n.settingsAllow),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.settingsInfo,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Card.filled(
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
                  onTap: () => _openExternal(Uri.parse(kGithubRepoUrl)),
                ),
                ListTile(
                  leading: const Icon(Icons.edit_outlined),
                  title: Text(l10n.settingsLicense),
                  subtitle: const Text('GNU GPLv3'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: _showLicenses,
                ),
                ListTile(
                  leading: const Icon(Icons.waving_hand),
                  title: Text(l10n.settingsQuestion),
                  subtitle: const Text(kSupportEmail),
                  onTap: () => _openExternal(
                    Uri(
                      scheme: 'mailto',
                      path: kSupportEmail,
                      queryParameters: <String, String>{
                        'subject': 'Support JW Streak',
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            l10n.settingsFooter,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 32),
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Center(child: _HeartEasterEgg()),
          ),
        ],
      ),
    );
  }
}

class _HeartEasterEgg extends StatelessWidget {
  const _HeartEasterEgg();

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    return TapEasterEgg(
      onTriggered: () {
        LocalDbService().markEasterEggFound('heart');
        NotificationService().showInstantMessage(
          title: 'JW Streak 💛',
          body: l10n.easterEggHeartBody,
        );
      },
      child: Icon(
        Icons.favorite,
        size: 64,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

/// Full-screen Material loader shown while the app language switches, so the
/// UI text doesn't visibly jump-cut from one language to another. Blocks the
/// back gesture/button so it can't be dismissed before the switch completes.
class _LocaleSwitchLoadingScreen extends StatelessWidget {
  const _LocaleSwitchLoadingScreen();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            year2023: false,
            strokeWidth: 6,
            constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
          ),
        ),
      ),
    );
  }
}
