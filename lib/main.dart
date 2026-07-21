import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'l10n/app_localizations.dart';
import 'screens/home_screen.dart';
import 'screens/streak_info_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/local_db_service.dart';
import 'theme/theme_preference.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const DailyJwApp());
}

class DailyJwApp extends StatefulWidget {
  const DailyJwApp({super.key, this.skipBootstrap = false});

  final bool skipBootstrap;

  @override
  State<DailyJwApp> createState() => _DailyJwAppState();
}

class _DailyJwAppState extends State<DailyJwApp> {
  final LocalDbService _dbService = LocalDbService();
  ThemePreference _themePreference = ThemePreference.system;
  bool _useDynamicColor = true;
  /// null means "follow system language".
  String? _localeCode;
  bool _isThemeLoading = true;
  bool _showWelcome = false;
  // 0 = welcome page, 1 = streak explanation page (only while onboarding).
  int _onboardingStep = 0;

  @override
  void initState() {
    super.initState();
    if (widget.skipBootstrap) {
      _isThemeLoading = false;
      return;
    }
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      await _dbService.initialize();
      final ThemePreference preference = await _dbService.getThemePreference();
      final bool useDynamicColor = await _dbService.getUseDynamicColor();
      final String? localeCode = await _dbService.getAppLocale();
      final bool onboardingDone = await _dbService.isOnboardingDone();
      if (!mounted) {
        return;
      }
      setState(() {
        _themePreference = preference;
        _useDynamicColor = useDynamicColor;
        _localeCode = localeCode;
        _showWelcome = !onboardingDone;
        _isThemeLoading = false;
      });
    } catch (_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isThemeLoading = false;
      });
    }
  }

  Future<void> _completeOnboarding() async {
    try {
      await _dbService.setOnboardingDone();
    } catch (_) {
      // Even if persisting fails, let the user through; the welcome
      // screen will simply show again next launch.
    }
    if (!mounted) {
      return;
    }
    setState(() {
      _showWelcome = false;
    });
  }

  Future<void> _updateThemePreference(ThemePreference value) async {
    await _dbService.saveThemePreference(value);
    if (!mounted) {
      return;
    }
    setState(() {
      _themePreference = value;
    });
  }

  Future<void> _updateUseDynamicColor(bool value) async {
    await _dbService.saveUseDynamicColor(value);
    if (!mounted) {
      return;
    }
    setState(() {
      _useDynamicColor = value;
    });
  }

  Future<void> _updateLocale(String? code) async {
    await _dbService.saveAppLocale(code);
    if (!mounted) {
      return;
    }
    setState(() {
      _localeCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Widget loading = const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        final ColorScheme lightScheme =
            (_useDynamicColor ? lightDynamic : null) ??
            ColorScheme.fromSeed(seedColor: const Color(0xFF2C5A87));
        final ColorScheme defaultDark =
            (_useDynamicColor ? darkDynamic : null) ??
            ColorScheme.fromSeed(
              brightness: Brightness.dark,
              seedColor: const Color(0xFF2C5A87),
            );
        final ColorScheme oledDark = defaultDark.copyWith(
          surface: Colors.black,
          surfaceContainerHighest: const Color(0xFF111111),
          surfaceContainerHigh: const Color(0xFF111111),
          surfaceContainer: const Color(0xFF080808),
          surfaceContainerLow: const Color(0xFF060606),
          surfaceContainerLowest: Colors.black,
        );

        final ThemeData lightTheme = ThemeData(
          useMaterial3: true,
          colorScheme: lightScheme,
          cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias),
        );

        final ThemeData darkTheme = ThemeData(
          useMaterial3: true,
          colorScheme: _themePreference == ThemePreference.oled
              ? oledDark
              : defaultDark,
          scaffoldBackgroundColor: _themePreference == ThemePreference.oled
              ? Colors.black
              : null,
          cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias),
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JW Streak',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _themePreference.materialThemeMode,
          locale: _localeCode == null ? null : Locale(_localeCode!),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: _isThemeLoading
              ? loading
              : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 450),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _showWelcome
                      ? (_onboardingStep == 0
                            ? WelcomeScreen(
                                key: const ValueKey<String>('welcome'),
                                onContinue: () async {
                                  setState(() => _onboardingStep = 1);
                                },
                              )
                            : StreakInfoScreen(
                                key: const ValueKey<String>('streak-info'),
                                onDone: _completeOnboarding,
                              ))
                      : HomeScreen(
                          key: const ValueKey<String>('home'),
                          skipBootstrap: widget.skipBootstrap,
                          currentThemePreference: _themePreference,
                          onThemePreferenceChanged: _updateThemePreference,
                          useDynamicColor: _useDynamicColor,
                          onUseDynamicColorChanged: _updateUseDynamicColor,
                          currentLocaleCode: _localeCode,
                          onLocaleChanged: _updateLocale,
                        ),
                ),
        );
      },
    );
  }
}
