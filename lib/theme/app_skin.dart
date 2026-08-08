import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import 'app_icons.dart';

/// The app's visual identity, orthogonal to light/dark.
///
/// [ThemePreference] answers "how bright?"; this answers "which app am I
/// looking at?" — palette, signature icons, and typeface. Keeping the two
/// apart means every skin still honours the user's brightness choice instead
/// of each one having to ship its own light and dark variants as separate
/// entries in one flat list.
enum AppSkin { classic, matrix, parchment, ocean, sunset, forest, amethyst }

/// [ColorScheme.fromSeed] runs real HCT color math, and the settings gallery
/// asks every skin for both brightnesses at once to paint its previews.
/// Without this the picker would recompute fourteen palettes on every frame
/// of its own scroll.
final Map<(AppSkin, Brightness), ColorScheme> _schemeCache =
    <(AppSkin, Brightness), ColorScheme>{};

extension AppSkinX on AppSkin {
  String get storageValue {
    switch (this) {
      case AppSkin.classic:
        return 'classic';
      case AppSkin.matrix:
        return 'matrix';
      case AppSkin.parchment:
        return 'parchment';
      case AppSkin.ocean:
        return 'ocean';
      case AppSkin.sunset:
        return 'sunset';
      case AppSkin.forest:
        return 'forest';
      case AppSkin.amethyst:
        return 'amethyst';
    }
  }

  String label(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    switch (this) {
      case AppSkin.classic:
        return l10n.themeSkinClassic;
      case AppSkin.matrix:
        return l10n.themeSkinMatrix;
      case AppSkin.parchment:
        return l10n.themeSkinParchment;
      case AppSkin.ocean:
        return l10n.themeSkinOcean;
      case AppSkin.sunset:
        return l10n.themeSkinSunset;
      case AppSkin.forest:
        return l10n.themeSkinForest;
      case AppSkin.amethyst:
        return l10n.themeSkinAmethyst;
    }
  }

  /// Some skins only make sense in the dark — Matrix is a phosphor terminal,
  /// and a "light mode terminal" is just a green-on-white mess. Those pin the
  /// app to dark and the brightness chips go inert while they're selected.
  bool get forcesDark => this == AppSkin.matrix;

  /// Material You derives the palette from the wallpaper, which is precisely
  /// the thing a skin exists to override. Offering both at once would just be
  /// two settings fighting over the same pixels.
  bool get supportsDynamicColor => this == AppSkin.classic;

  AppIcons get icons {
    switch (this) {
      case AppSkin.matrix:
        return kMatrixIcons;
      case AppSkin.parchment:
        return kParchmentIcons;
      case AppSkin.classic:
      case AppSkin.ocean:
      case AppSkin.sunset:
      case AppSkin.forest:
      case AppSkin.amethyst:
        return kClassicIcons;
    }
  }

  /// Generic family names rather than bundled files: the app already ships
  /// one font it actually needs, and adding a monospace and a serif face to
  /// the APK for two optional skins isn't worth the megabytes. The fallback
  /// lists cover the platforms where the generic name isn't recognised.
  ///
  /// This is the *UI* face only. The "JW Streak" wordmark keeps its bundled
  /// brand font at every call site that spells it out, the same way a logo
  /// doesn't restyle itself to match the room it's hanging in.
  String? get fontFamily {
    switch (this) {
      case AppSkin.matrix:
        return 'monospace';
      case AppSkin.parchment:
        return 'serif';
      case AppSkin.classic:
      case AppSkin.ocean:
      case AppSkin.sunset:
      case AppSkin.forest:
      case AppSkin.amethyst:
        return null;
    }
  }

  List<String>? get fontFamilyFallback {
    switch (this) {
      case AppSkin.matrix:
        return const <String>['Menlo', 'Courier New', 'Courier'];
      case AppSkin.parchment:
        return const <String>['Georgia', 'Times New Roman', 'Times'];
      case AppSkin.classic:
      case AppSkin.ocean:
      case AppSkin.sunset:
      case AppSkin.forest:
      case AppSkin.amethyst:
        return null;
    }
  }

  Color get _seed {
    switch (this) {
      case AppSkin.classic:
        return const Color(0xFF2C5A87);
      case AppSkin.matrix:
        return const Color(0xFF00E676);
      case AppSkin.parchment:
        return const Color(0xFF8C5A2B);
      case AppSkin.ocean:
        return const Color(0xFF00838F);
      case AppSkin.sunset:
        return const Color(0xFFE25822);
      case AppSkin.forest:
        return const Color(0xFF2E6B34);
      case AppSkin.amethyst:
        return const Color(0xFF7B3FA0);
    }
  }

  /// The palette for this skin at [brightness].
  ///
  /// Most skins are a plain seed — Material 3's generated palette is already
  /// coherent and there's nothing to be gained by hand-tuning thirty roles.
  /// Matrix and Parchment override their surfaces because their whole point
  /// is a surface that doesn't look like stock Material: a seed alone gives
  /// Matrix a polite dark grey rather than a black CRT.
  ColorScheme scheme(Brightness brightness) {
    // A dark-only skin has to answer for light too — MaterialApp always
    // builds both themes — so hand back the dark palette rather than a light
    // one that would flash on screen before themeMode pins it.
    final Brightness effective = forcesDark ? Brightness.dark : brightness;
    return _schemeCache[(this, effective)] ??= _buildScheme(effective);
  }

  ColorScheme _buildScheme(Brightness brightness) {
    final ColorScheme base = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );
    switch (this) {
      case AppSkin.matrix:
        return base.copyWith(
          primary: const Color(0xFF44FF7D),
          onPrimary: const Color(0xFF00220C),
          primaryContainer: const Color(0xFF0C3F1F),
          onPrimaryContainer: const Color(0xFF7CFFA8),
          secondary: const Color(0xFF00E68C),
          onSecondary: const Color(0xFF00220C),
          secondaryContainer: const Color(0xFF07331F),
          onSecondaryContainer: const Color(0xFF6BFFC0),
          tertiary: const Color(0xFFA8FF6B),
          onTertiary: const Color(0xFF102600),
          tertiaryContainer: const Color(0xFF1B3D0A),
          onTertiaryContainer: const Color(0xFFC9FF9E),
          surface: const Color(0xFF030804),
          onSurface: const Color(0xFFB6FFC6),
          onSurfaceVariant: const Color(0xFF79C78D),
          surfaceContainerLowest: const Color(0xFF000000),
          surfaceContainerLow: const Color(0xFF060F08),
          surfaceContainer: const Color(0xFF08150B),
          surfaceContainerHigh: const Color(0xFF0C1D10),
          surfaceContainerHighest: const Color(0xFF112716),
          outline: const Color(0xFF2E7043),
          outlineVariant: const Color(0xFF1B4427),
          error: const Color(0xFFFF6B6B),
          onError: const Color(0xFF2A0000),
          errorContainer: const Color(0xFF4A0E0E),
          onErrorContainer: const Color(0xFFFFB4AB),
          inverseSurface: const Color(0xFFB6FFC6),
          onInverseSurface: const Color(0xFF030804),
        );
      case AppSkin.parchment:
        if (brightness == Brightness.light) {
          return base.copyWith(
            surface: const Color(0xFFF7EFDD),
            onSurface: const Color(0xFF3B2E1E),
            onSurfaceVariant: const Color(0xFF6B573D),
            surfaceContainerLowest: const Color(0xFFFFFBF2),
            surfaceContainerLow: const Color(0xFFF3E9D3),
            surfaceContainer: const Color(0xFFEEE2C8),
            surfaceContainerHigh: const Color(0xFFE8DABB),
            surfaceContainerHighest: const Color(0xFFE2D2AE),
            outline: const Color(0xFF8F7A5A),
            outlineVariant: const Color(0xFFCDBB99),
          );
        }
        return base.copyWith(
          surface: const Color(0xFF1C1710),
          onSurface: const Color(0xFFEDE0C8),
          onSurfaceVariant: const Color(0xFFCBB79A),
          surfaceContainerLowest: const Color(0xFF120E09),
          surfaceContainerLow: const Color(0xFF231D14),
          surfaceContainer: const Color(0xFF292218),
          surfaceContainerHigh: const Color(0xFF352C1F),
          surfaceContainerHighest: const Color(0xFF413626),
          outline: const Color(0xFF8A7758),
          outlineVariant: const Color(0xFF544736),
        );
      case AppSkin.classic:
      case AppSkin.ocean:
      case AppSkin.sunset:
      case AppSkin.forest:
      case AppSkin.amethyst:
        return base;
    }
  }
}

AppSkin appSkinFromStorage(String? value) {
  for (final AppSkin skin in AppSkin.values) {
    if (skin.storageValue == value) {
      return skin;
    }
  }
  return AppSkin.classic;
}
