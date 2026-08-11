import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_icons.dart';
import '../../theme/app_skin.dart';
import '../../theme/theme_preference.dart';
import 'settings_common.dart';

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

/// Everything that changes how the app looks and reads: style, brightness,
/// wallpaper colors, language. Grouped together because from a reader's side
/// they're one question ("how do I want this to look?"), even though under
/// the hood a theme and a locale have nothing in common.
class PersonalizationSettingsScreen extends StatefulWidget {
  const PersonalizationSettingsScreen({
    required this.currentThemePreference,
    required this.onThemePreferenceChanged,
    required this.currentAppSkin,
    required this.onAppSkinChanged,
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
  final bool useDynamicColor;
  final Future<void> Function(bool value)? onUseDynamicColorChanged;

  /// null means "follow system language".
  final String? currentLocaleCode;
  final Future<void> Function(String? code)? onLocaleChanged;

  @override
  State<PersonalizationSettingsScreen> createState() =>
      _PersonalizationSettingsScreenState();
}

class _PersonalizationSettingsScreenState
    extends State<PersonalizationSettingsScreen> {
  late ThemePreference _selectedTheme = widget.currentThemePreference;
  late AppSkin _selectedSkin = widget.currentAppSkin;
  late bool _useDynamicColor = widget.useDynamicColor;
  late String? _selectedLocaleCode = widget.currentLocaleCode;

  Future<void> _changeTheme(ThemePreference preference) async {
    setState(() {
      _selectedTheme = preference;
    });
    try {
      await widget.onThemePreferenceChanged(preference);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  Future<void> _changeSkin(AppSkin skin) async {
    final Future<void> Function(AppSkin value)? callback =
        widget.onAppSkinChanged;
    if (callback == null) {
      return;
    }
    setState(() {
      _selectedSkin = skin;
    });
    try {
      await callback(skin);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
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
        showSettingsError(context, error);
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
        showSettingsError(context, error);
      }
    } finally {
      navigator.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);

    return SettingsPage(
      title: l10n.settingsCatPersonalization,
      children: <Widget>[
        SettingsSectionLabel(l10n.settingsAppearance),
        Card.filled(
          shape: sectionShape,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.settingsThemeStyle,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                // A named list of styles tells you nothing — "Parchment"
                // could be anything. Each one paints itself instead, so
                // the choice is made by looking rather than by guessing
                // and then undoing.
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: AppSkin.values
                      .map(
                        (AppSkin skin) => _SkinSwatch(
                          skin: skin,
                          selected: _selectedSkin == skin,
                          onTap: widget.onAppSkinChanged == null
                              ? null
                              : () => _changeSkin(skin),
                        ),
                      )
                      .toList(growable: false),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.settingsThemeBrightness,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: ThemePreference.values
                      .map(
                        (ThemePreference preference) => ChoiceChip(
                          shape: kSettingsChipShape,
                          label: Text(preference.label(context)),
                          selected: _selectedTheme == preference,
                          selectedColor: cs.primary,
                          checkmarkColor: cs.onPrimary,
                          labelStyle: TextStyle(
                            color: _selectedTheme == preference
                                ? cs.onPrimary
                                : cs.onSurface,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide(
                            color: _selectedTheme == preference
                                ? cs.primary
                                : cs.outlineVariant,
                          ),
                          // A dark-only style overrides this anyway, so
                          // the chips go inert rather than silently
                          // accepting a choice that changes nothing.
                          onSelected: _selectedSkin.forcesDark
                              ? null
                              : (_) => _changeTheme(preference),
                        ),
                      )
                      .toList(growable: false),
                ),
                if (_selectedSkin.forcesDark) ...<Widget>[
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: cs.onSurfaceVariant,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          l10n.settingsThemeStyleDarkOnly,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: cs.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 8),
              ],
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
                // A style *is* a palette, so wallpaper colors and a skin
                // would be two settings fighting over the same pixels —
                // say why it's off rather than just greying it out.
                !_selectedSkin.supportsDynamicColor
                    ? l10n.settingsDynamicColorClassicOnly
                    : _useDynamicColor
                    ? l10n.settingsDynamicColorOn
                    : l10n.settingsDynamicColorOff,
              ),
              value: _useDynamicColor && _selectedSkin.supportsDynamicColor,
              onChanged:
                  widget.onUseDynamicColorChanged == null ||
                      !_selectedSkin.supportsDynamicColor
                  ? null
                  : _changeUseDynamicColor,
            ),
          ),
        ],
        const SizedBox(height: 16),
        SettingsSectionLabel(l10n.settingsLanguage),
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
                      shape: kSettingsChipShape,
                      label: Text(
                        lang.code == null
                            ? l10n.settingsLanguageSystem
                            : lang.name,
                      ),
                      selected: _selectedLocaleCode == lang.code,
                      selectedColor: cs.primary,
                      checkmarkColor: cs.onPrimary,
                      labelStyle: TextStyle(
                        color: _selectedLocaleCode == lang.code
                            ? cs.onPrimary
                            : cs.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                      side: BorderSide(
                        color: _selectedLocaleCode == lang.code
                            ? cs.primary
                            : cs.outlineVariant,
                      ),
                      onSelected: widget.onLocaleChanged == null
                          ? null
                          : (_) => _changeLocale(lang.code),
                    ),
                  )
                  .toList(growable: false),
            ),
          ),
        ),
      ],
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

/// One entry in the style gallery: a miniature of the app painted in that
/// skin's own palette and drawn with that skin's own icons.
///
/// Names alone don't carry a theme — "Parchment" could be anything, and
/// picking blind means applying a style just to see it and then undoing it.
/// Rendering each option in its own colors makes the choice a glance instead
/// of a trial run.
class _SkinSwatch extends StatelessWidget {
  const _SkinSwatch({
    required this.skin,
    required this.selected,
    required this.onTap,
  });

  final AppSkin skin;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    // Asks for the current brightness so the previews sit consistently next
    // to the live UI; a dark-only skin ignores that and hands back its dark
    // palette anyway, which is exactly what it'll look like once picked.
    final ColorScheme preview = skin.scheme(theme.brightness);
    final AppIcons icons = skin.icons;

    return Semantics(
      selected: selected,
      button: true,
      label: skin.label(context),
      child: SizedBox(
        width: 96,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Material(
              color: preview.surface,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: selected ? cs.primary : cs.outlineVariant,
                  width: selected ? 2 : 1,
                ),
              ),
              child: InkWell(
                onTap: onTap,
                child: SizedBox(
                  height: 62,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Stands in for the app bar, so the miniature reads as
                      // a screen rather than as an abstract color chip.
                      Container(height: 16, color: preview.primary),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(icons.flame, size: 16, color: preview.primary),
                            Icon(
                              icons.book,
                              size: 16,
                              color: preview.secondary,
                            ),
                            // The reward's own color, not a generic tertiary
                            // tint — the preview should show what you'll
                            // actually get (a shell reads oddly in amber).
                            icons.reward(size: 16, color: icons.rewardColor),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            // Fixed height so a two-line name ("Coucher de soleil") doesn't
            // shove its row of swatches out of alignment with the others.
            SizedBox(
              height: 32,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (selected) ...<Widget>[
                    Icon(Icons.check_rounded, size: 14, color: cs.primary),
                    const SizedBox(width: 2),
                  ],
                  Flexible(
                    child: Text(
                      skin.label(context),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected ? cs.primary : cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
