import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/app_lock_service.dart';
import '../services/deep_link_service.dart';
import '../services/local_db_service.dart';
import '../services/notification_service.dart';
import '../theme/theme_preference.dart';
import '../widgets/message_dialog.dart';
import '../widgets/responsive_body.dart';
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

/// The `null`-code entry is what makes "follow the system language" — the
/// default on a fresh install — actually selectable *and* visibly selected.
/// Without it the picker had no chip matching a null preference, so a new
/// user saw a correctly-translated app above a picker with nothing chosen.
/// Its label is the only one localized rather than an endonym: it names a
/// behaviour, not a language.
const List<_AppLanguage> _kAppLanguages = <_AppLanguage>[
  _AppLanguage(null, ''),
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

  // App lock: null while we're still asking the platform whether the device
  // can authenticate at all. A device with no screen lock set up never gets
  // the switch, since turning it on there would lock the user out for good.
  final AppLockService _lockService = AppLockService();
  bool? _appLockAvailable;
  bool _appLockEnabled = false;

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
      final bool lockAvailable = await _lockService.isAvailable();
      final bool lockEnabled = await _lockService.isEnabled();
      if (!mounted) {
        return;
      }
      setState(() {
        _appLockAvailable = lockAvailable;
        _appLockEnabled = lockEnabled;
        // Version name only: the build number after the "+" is an Android
        // bookkeeping detail, not something a reader gets anything out of.
        _version = packageInfo.version;
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

  /// Turning the lock on or off both require passing the lock first: enabling
  /// proves the device can actually authenticate before the user is shut
  /// behind it, and disabling stops whoever is holding an already-unlocked
  /// session from simply switching the protection off.
  Future<void> _changeAppLock(bool wantEnabled) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool ok = await _lockService.authenticate(
      reason: wantEnabled
          ? l10n.appLockEnableReason
          : l10n.appLockDisableReason,
    );
    if (!ok || !mounted) {
      return;
    }
    setState(() {
      _appLockEnabled = wantEnabled;
    });
    try {
      await _lockService.setEnabled(wantEnabled);
    } catch (error) {
      if (mounted) {
        setState(() => _appLockEnabled = !wantEnabled);
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
              _openExternal(Uri.parse(jwLibraryStoreUrl));
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
      // Just long enough for the fade-in/fade-out of the loading screen to
      // read as a deliberate transition rather than a flash — the locale
      // switch itself is near-instant, so this used to sit idle for a full
      // extra second after everything was already done.
      await Future.delayed(const Duration(milliseconds: 300));
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
    final ColorScheme cs = Theme.of(context).colorScheme;
    // +2dp over Card's own implicit ~12dp default, with an outline so each
    // section reads as a distinct, bordered block instead of a borderless
    // tonal fill blending into the page background.
    final RoundedRectangleBorder sectionShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: BorderSide(color: cs.outlineVariant),
    );
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ResponsiveBody(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            Text(
              l10n.settingsAppearance,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card.filled(
              shape: sectionShape,
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
            // Dynamic color (Material You) is an Android-only concept — it
            // derives the palette from the device wallpaper, which iOS/iPadOS
            // has no equivalent of. The dynamic_color package already no-ops
            // there, but showing a toggle that can never do anything is just
            // confusing, so the setting itself is Android-only.
            if (defaultTargetPlatform == TargetPlatform.android) ...<Widget>[
              const SizedBox(height: 8),
              Card.filled(
                shape: sectionShape,
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
            ],
            const SizedBox(height: 8),
            Card.filled(
              shape: sectionShape,
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
              shape: sectionShape,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _kAppLanguages
                      .map(
                        (_AppLanguage lang) => ChoiceChip(
                          label: Text(
                            lang.code == null
                                ? l10n.settingsLanguageSystem
                                : lang.name,
                          ),
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
            Text(
              l10n.settingsPrivacy,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card.filled(
              shape: sectionShape,
              child: SwitchListTile(
                secondary: Icon(
                  _appLockEnabled
                      ? Icons.lock_rounded
                      : Icons.lock_open_rounded,
                ),
                title: Text(l10n.settingsAppLockTitle),
                subtitle: Text(
                  _appLockAvailable == false
                      ? l10n.settingsAppLockUnavailable
                      : _appLockEnabled
                      ? l10n.settingsAppLockOn
                      : l10n.settingsAppLockOff,
                ),
                value: _appLockEnabled,
                // Disabled (null) both while we're still checking and on a
                // device with no screen lock configured.
                onChanged: _appLockAvailable == true ? _changeAppLock : null,
              ),
            ),
            const SizedBox(height: 16),
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
            Text(
              l10n.settingsPermissions,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Card.filled(
              shape: sectionShape,
              child: ListTile(
                leading: Icon(
                  notificationsEnabled
                      ? Icons.check_circle
                      : Icons.warning_amber,
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
              shape: sectionShape,
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
                    onTap: () => _openExternal(Uri.parse(kGithubRepoUrl)),
                  ),
                  ListTile(
                    leading: const Icon(Icons.waving_hand),
                    title: Text(l10n.settingsQuestion),
                    subtitle: const Text(kSupportEmail),
                    trailing: const Icon(Icons.open_in_new_rounded, size: 20),
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
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.settingsUnaffiliated,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Center(child: _HeartEasterEgg()),
            ),
          ],
        ),
      ),
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
