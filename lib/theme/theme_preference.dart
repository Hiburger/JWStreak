import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

enum ThemePreference { system, light, dark, oled }

extension ThemePreferenceX on ThemePreference {
  String get storageValue {
    switch (this) {
      case ThemePreference.system:
        return 'system';
      case ThemePreference.light:
        return 'light';
      case ThemePreference.dark:
        return 'dark';
      case ThemePreference.oled:
        return 'oled';
    }
  }

  ThemeMode get materialThemeMode {
    switch (this) {
      case ThemePreference.light:
        return ThemeMode.light;
      case ThemePreference.dark:
      case ThemePreference.oled:
        return ThemeMode.dark;
      case ThemePreference.system:
        return ThemeMode.system;
    }
  }

  String label(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    switch (this) {
      case ThemePreference.system:
        return l10n.themeSystem;
      case ThemePreference.light:
        return l10n.themeLight;
      case ThemePreference.dark:
        return l10n.themeDark;
      case ThemePreference.oled:
        return l10n.themeOled;
    }
  }
}

ThemePreference themePreferenceFromStorage(String? value) {
  switch (value) {
    case 'light':
      return ThemePreference.light;
    case 'dark':
      return ThemePreference.dark;
    case 'oled':
      return ThemePreference.oled;
    case 'system':
    default:
      return ThemePreference.system;
  }
}
