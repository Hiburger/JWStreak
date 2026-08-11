import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';

import 'l10n/app_localizations.dart';
import 'reading_plan.dart';
import 'screens/features_intro_screen.dart';
import 'screens/home_screen.dart';
import 'screens/reading_plan_onboarding_screen.dart';
import 'screens/reading_start_onboarding_screen.dart';
import 'screens/reminder_onboarding_screen.dart';
import 'screens/streak_info_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/local_db_service.dart';
import 'theme/app_skin.dart';
import 'theme/theme_preference.dart';
import 'widgets/app_lock_gate.dart';

void main() {
  // The native launch splash (android/app/src/main/res/drawable/
  // launch_background.xml + the Android 12 SplashScreen API, both generated
  // by `dart run flutter_native_splash:create`) is removed automatically the
  // moment Flutter draws its first frame — deliberately not held open any
  // longer than that. Blocking it on _loadThemePreference() finishing used
  // to make Android show its own "still loading" spinner once the icon's
  // budgeted display time ran out; better to get *something* on screen fast
  // (see _isThemeLoading's skeleton below) than to hold a blank native
  // splash hostage to a network-free, sub-50ms local DB read.
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
  AppSkin _appSkin = AppSkin.classic;
  bool _useDynamicColor = false;

  /// null means "follow system language".
  String? _localeCode;
  bool _isThemeLoading = true;
  bool _showWelcome = false;
  // Onboarding pages: 0 = welcome, 1 = features, 2 = streak,
  // 3 = starting point, 4 = reading order, 5 = reminders.
  static const int _onboardingStepCount = 6;

  // Held here rather than written straight to the DB from each page, so
  // swiping back and forth through onboarding doesn't persist a half-made
  // choice; both land together when onboarding completes.
  ReadingPlan _onboardingPlan = ReadingPlan.canonical;
  String? _onboardingStartKey;

  // Both default to false so the pages they gate can't be swiped or
  // tapped past before the reader has actually made a choice — [selected]
  // on the plan page always has a value (it defaults to canonical), so
  // "has a value" alone can't tell "picked on purpose" apart from
  // "never touched this page".
  bool _onboardingStartAnswered = false;
  bool _onboardingPlanChosen = false;
  int _onboardingStep = 0;
  final PageController _onboardingController = PageController();
  // True only while the user is actively dragging the onboarding PageView
  // (not during a programmatic animateToPage) — hides each page's bottom
  // button so it doesn't compete with the swipe gesture.
  bool _isOnboardingDragging = false;

  @override
  void initState() {
    super.initState();
    if (widget.skipBootstrap) {
      _isThemeLoading = false;
      return;
    }
    _loadThemePreference();
  }

  @override
  void dispose() {
    _onboardingController.dispose();
    super.dispose();
  }

  Future<void> _loadThemePreference() async {
    try {
      await _dbService.initialize();
      // These 5 reads don't depend on each other — run them concurrently
      // instead of paying 5 separate method-channel round-trips back to
      // back, so the skeleton below is on screen as briefly as possible.
      final List<Object?> results = await Future.wait(<Future<Object?>>[
        _dbService.getThemePreference(),
        _dbService.getUseDynamicColor(),
        _dbService.getAppLocale(),
        _dbService.isOnboardingDone(),
        _dbService.getAppSkin(),
      ]);
      final ThemePreference preference = results[0] as ThemePreference;
      final bool useDynamicColor = results[1]! as bool;
      final String? localeCode = results[2] as String?;
      final bool onboardingDone = results[3]! as bool;
      final AppSkin skin = results[4]! as AppSkin;
      if (!mounted) {
        return;
      }
      setState(() {
        _themePreference = preference;
        _appSkin = skin;
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

  /// Whether the reader is done with [step] and may move past it — the
  /// "starting point" and "reading order" pages must be answered first.
  bool _canLeaveOnboardingStep(int step) {
    switch (step) {
      case 3:
        return _onboardingStartAnswered;
      case 4:
        return _onboardingPlanChosen;
      default:
        return true;
    }
  }

  /// A swipe reaches the same "skip past an unanswered page" result the
  /// Continue button already blocks, just via a different gesture so it
  /// gets blocked the same way: if the page being left still needs an
  /// answer, bounce back to it instead of accepting the new page.
  void _onOnboardingPageChanged(int page) {
    final int from = _onboardingStep;
    if (page > from && !_canLeaveOnboardingStep(from)) {
      // PageView has already settled on `page` by the time this fires;
      // animating back now (rather than mid-callback) avoids fighting the
      // transition that's still wrapping up.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _onboardingController.animateToPage(
            from,
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
          );
        }
      });
      return;
    }
    setState(() => _onboardingStep = page);
  }

  Future<void> _goToOnboardingStep(int step) async {
    await _onboardingController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  /// Distinguishes a manual finger-drag from a programmatic `animateToPage`
  /// scroll: [ScrollStartNotification.dragDetails] is only set for the former.
  bool _handleOnboardingScroll(ScrollNotification notification) {
    // ScrollStartNotification fires on a plain touch-down (Scrollable starts
    // a "hold" to arrest any fling) even with zero finger movement, so
    // relying on it made the button flicker away on a simple tap.
    // ScrollUpdateNotification only fires once the scroll offset actually
    // changes, so gating on it (with dragDetails set, i.e. driven by the
    // user's finger rather than a programmatic animateToPage) only reacts to
    // a genuine swipe.
    if (notification is ScrollUpdateNotification &&
        notification.dragDetails != null) {
      if (!_isOnboardingDragging) {
        setState(() => _isOnboardingDragging = true);
      }
    } else if (notification is ScrollEndNotification) {
      if (_isOnboardingDragging) {
        setState(() => _isOnboardingDragging = false);
      }
    }
    return false;
  }

  Widget _buildOnboardingPageView() {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleOnboardingScroll,
      child: PageView(
        key: const ValueKey<String>('onboarding-flow'),
        controller: _onboardingController,
        onPageChanged: _onOnboardingPageChanged,
        children: <Widget>[
          // Each page gets its own compositing layer so dragging the
          // PageView just repositions cached rasters instead of repainting
          // all four pages' content on every scroll frame.
          RepaintBoundary(
            child: WelcomeScreen(
              stepCount: _onboardingStepCount,
              stepIndex: 0,
              onContinue: () => _goToOnboardingStep(1),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
          RepaintBoundary(
            child: FeaturesIntroScreen(
              stepCount: _onboardingStepCount,
              stepIndex: 1,
              onNext: () => _goToOnboardingStep(2),
              onBack: () => _goToOnboardingStep(0),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
          RepaintBoundary(
            child: StreakInfoScreen(
              stepCount: _onboardingStepCount,
              stepIndex: 2,
              onNext: () => _goToOnboardingStep(3),
              onBack: () => _goToOnboardingStep(1),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
          RepaintBoundary(
            child: ReadingStartOnboardingScreen(
              stepCount: _onboardingStepCount,
              stepIndex: 3,
              initialStartKey: _onboardingStartKey,
              onStartKeyChanged: (String? key) => _onboardingStartKey = key,
              onAnswered: () => setState(() => _onboardingStartAnswered = true),
              canContinue: _onboardingStartAnswered,
              onNext: () => _goToOnboardingStep(4),
              onBack: () => _goToOnboardingStep(2),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
          RepaintBoundary(
            child: ReadingPlanOnboardingScreen(
              stepCount: _onboardingStepCount,
              stepIndex: 4,
              // Only shown as chosen once the reader has actually tapped an
              // option — _onboardingPlan itself defaults to canonical from
              // the start (that's what gets saved if they never touch this
              // page), but the page shouldn't claim it was picked.
              selected: _onboardingPlanChosen ? _onboardingPlan : null,
              onPlanChanged: (ReadingPlan plan) => setState(() {
                _onboardingPlan = plan;
                _onboardingPlanChosen = true;
              }),
              canContinue: _onboardingPlanChosen,
              onNext: () => _goToOnboardingStep(5),
              onBack: () => _goToOnboardingStep(3),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
          RepaintBoundary(
            child: ReminderOnboardingScreen(
              dbService: _dbService,
              stepCount: _onboardingStepCount,
              stepIndex: 5,
              onDone: _completeOnboarding,
              onBack: () => _goToOnboardingStep(4),
              hideActionButton: _isOnboardingDragging,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    try {
      await _dbService.saveReadingPlan(_onboardingPlan);
      await _dbService.savePlanStartKey(_onboardingStartKey);
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

  Future<void> _updateAppSkin(AppSkin value) async {
    await _dbService.saveAppSkin(value);
    if (!mounted) {
      return;
    }
    setState(() {
      _appSkin = value;
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
    const Widget loading = SizedBox.shrink();
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        // Material You reads the palette off the wallpaper, which is exactly
        // what picking a skin overrides — so the wallpaper only gets a say
        // while the (skin-less by design) Classic style is selected.
        final bool dynamicAllowed =
            _useDynamicColor && _appSkin.supportsDynamicColor;
        final ColorScheme lightScheme =
            (dynamicAllowed ? lightDynamic : null) ??
            _appSkin.scheme(Brightness.light);
        final ColorScheme baseDark =
            (dynamicAllowed ? darkDynamic : null) ??
            _appSkin.scheme(Brightness.dark);
        // OLED stays a modifier on top of whatever the skin produced rather
        // than a palette of its own, so "true black" keeps working for every
        // style instead of only the default one.
        final bool oled = _themePreference == ThemePreference.oled;
        final ColorScheme darkScheme = oled
            ? baseDark.copyWith(
                surface: Colors.black,
                surfaceContainerHighest: const Color(0xFF111111),
                surfaceContainerHigh: const Color(0xFF111111),
                surfaceContainer: const Color(0xFF080808),
                surfaceContainerLow: const Color(0xFF060606),
                surfaceContainerLowest: Colors.black,
              )
            : baseDark;

        ThemeData buildTheme(ColorScheme scheme, {Color? scaffoldBackground}) {
          return ThemeData(
            useMaterial3: true,
            colorScheme: scheme,
            fontFamily: _appSkin.fontFamily,
            fontFamilyFallback: _appSkin.fontFamilyFallback,
            scaffoldBackgroundColor: scaffoldBackground,
            cardTheme: const CardThemeData(clipBehavior: Clip.antiAlias),
            // Carries the skin's signature glyphs down the tree so screens
            // ask the theme for "the streak icon" instead of hard-coding one.
            extensions: <ThemeExtension<dynamic>>[_appSkin.icons],
          );
        }

        final ThemeData lightTheme = buildTheme(lightScheme);
        final ThemeData darkTheme = buildTheme(
          darkScheme,
          scaffoldBackground: oled ? Colors.black : null,
        );

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'JW Streak',
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: _appSkin.forcesDark
              ? ThemeMode.dark
              : _themePreference.materialThemeMode,
          locale: _localeCode == null ? null : Locale(_localeCode!),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeListResolutionCallback: _resolveLocale,
          home: _isThemeLoading
              ? loading
              : _withAppLock(
                  PopScope(
                    // While onboarding, the system back gesture should step
                    // backwards through the flow instead of exiting the app —
                    // there's no Navigator route to pop since each step just
                    // swaps the same `home` widget.
                    canPop: !_showWelcome || _onboardingStep == 0,
                    onPopInvokedWithResult: (bool didPop, Object? result) {
                      if (didPop) {
                        return;
                      }
                      if (_showWelcome && _onboardingStep > 0) {
                        _goToOnboardingStep(_onboardingStep - 1);
                      }
                    },
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: _showWelcome
                          ? _buildOnboardingPageView()
                          : HomeScreen(
                              key: const ValueKey<String>('home'),
                              skipBootstrap: widget.skipBootstrap,
                              currentThemePreference: _themePreference,
                              onThemePreferenceChanged: _updateThemePreference,
                              currentAppSkin: _appSkin,
                              onAppSkinChanged: _updateAppSkin,
                              useDynamicColor: _useDynamicColor,
                              onUseDynamicColorChanged: _updateUseDynamicColor,
                              currentLocaleCode: _localeCode,
                              onLocaleChanged: _updateLocale,
                            ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  /// Picks the UI language for a device whose own language list is what we
  /// have to work with (i.e. no explicit in-app choice saved).
  ///
  /// Flutter's built-in resolution falls back to `supportedLocales.first`,
  /// and that list is generated alphabetically from the .arb filenames — so
  /// German, purely by being alphabetically first, was the fallback for every
  /// unsupported language. A device set to Japanese got a German UI. English
  /// is the sane fallback instead.
  Locale? _resolveLocale(
    List<Locale>? deviceLocales,
    Iterable<Locale> supported,
  ) {
    for (final Locale deviceLocale in deviceLocales ?? const <Locale>[]) {
      for (final Locale candidate in supported) {
        if (candidate.languageCode == deviceLocale.languageCode) {
          return candidate;
        }
      }
    }
    return const Locale('en');
  }

  /// Wraps the app in the lock gate, except under [skipBootstrap] (widget
  /// tests), where there is no database for the gate to read its setting from.
  Widget _withAppLock(Widget child) =>
      widget.skipBootstrap ? child : AppLockGate(child: child);
}
