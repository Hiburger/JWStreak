import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/notification_service.dart';
import '../theme/theme_preference.dart';

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
    this.useDynamicColor = true,
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
      if (!mounted) {
        return;
      }
      setState(() {
        _version = '${packageInfo.version} (${packageInfo.buildNumber})';
        _notificationsEnabled = notificationsEnabled;
        _exactAlarmsAllowed = exactAlarmsAllowed;
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

  Future<void> _changeLocale(String? code) async {
    setState(() {
      _selectedLocaleCode = code;
    });
    final Future<void> Function(String? code)? callback =
        widget.onLocaleChanged;
    if (callback == null) {
      return;
    }
    try {
      await callback(code);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            granted
                ? AppLocalizations.of(context)!.settingsNotifGranted
                : AppLocalizations.of(context)!.settingsNotifDenied,
          ),
        ),
      );
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            granted
                ? AppLocalizations.of(context)!.settingsAlarmsGranted
                : AppLocalizations.of(context)!.settingsAlarmsDenied,
          ),
        ),
      );
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.settingsError(error.toString())),
      ),
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
          Text(l10n.settingsAppearance, style: Theme.of(context).textTheme.titleMedium),
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
          const SizedBox(height: 16),
          Text(l10n.settingsLanguage, style: Theme.of(context).textTheme.titleMedium),
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
          Text(l10n.settingsPermissions, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card.filled(
            child: ListTile(
              leading: Icon(
                notificationsEnabled ? Icons.check_circle : Icons.warning_amber,
                size: 32,
                color: notificationsEnabled ? Colors.lightGreen : Colors.redAccent,
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
                exactAlarmsAllowed
                    ? Icons.check_circle
                    : Icons.warning_amber,
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
          Text(l10n.settingsInfo, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Card.filled(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.settingsVersionLabel),
                  subtitle: Text(_version),
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
          const Spacer(),
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: _HeartEasterEgg(),
          ),
        ],
      ),
    );
  }
}

class _HeartEasterEgg extends StatefulWidget {
  const _HeartEasterEgg();

  @override
  State<_HeartEasterEgg> createState() => _HeartEasterEggState();
}

class _HeartEasterEggState extends State<_HeartEasterEgg> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  final NotificationService _notifications = NotificationService();

  // Fire the message after this many quick consecutive taps; the counter
  // resets if the user pauses longer than [_tapWindow].
  static const int _tapsToTrigger = 8;
  static const Duration _tapWindow = Duration(milliseconds: 1500);
  int _tapCount = 0;
  DateTime? _lastTap;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: -0.15),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -0.15, end: 0.15),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.15, end: -0.15),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: -0.15, end: 0.15),
          weight: 1,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.15, end: 0),
          weight: 1,
        ),
      ],
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    _controller.reset();
    _controller.forward();

    final bool hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      await Vibration.vibrate(duration: 50);
    }

    _registerTap();
  }

  void _registerTap() {
    final DateTime now = DateTime.now();
    if (_lastTap == null || now.difference(_lastTap!) > _tapWindow) {
      _tapCount = 0;
    }
    _lastTap = now;
    _tapCount++;

    if (_tapCount >= _tapsToTrigger) {
      _tapCount = 0;
      _lastTap = null;
      _notifications.showInstantMessage(
        title: 'JW Streak 💛',
        body: 'Moi aussi je t’aime :)',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: _shakeAnimation.value,
            child: Icon(
              Icons.favorite,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
          );
        },
      ),
    );
  }
}
