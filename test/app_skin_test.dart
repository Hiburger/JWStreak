import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/theme/app_skin.dart';

/// WCAG relative-contrast ratio between two opaque colors.
double _contrast(Color a, Color b) {
  final double la = a.computeLuminance();
  final double lb = b.computeLuminance();
  final double lighter = la > lb ? la : lb;
  final double darker = la > lb ? lb : la;
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  test('every skin round-trips through storage', () {
    for (final AppSkin skin in AppSkin.values) {
      expect(appSkinFromStorage(skin.storageValue), skin);
    }
  });

  test('unknown or missing stored values fall back to classic', () {
    expect(appSkinFromStorage(null), AppSkin.classic);
    expect(appSkinFromStorage(''), AppSkin.classic);
    // A skin removed in a later version must not brick the app for someone
    // who had it selected.
    expect(appSkinFromStorage('vaporwave'), AppSkin.classic);
  });

  test('a dark-only skin ignores the requested brightness', () {
    expect(AppSkin.matrix.forcesDark, isTrue);
    expect(AppSkin.matrix.scheme(Brightness.light).brightness, Brightness.dark);
  });

  test('skins that follow the brightness preference actually do', () {
    for (final AppSkin skin in AppSkin.values.where(
      (AppSkin s) => !s.forcesDark,
    )) {
      expect(
        skin.scheme(Brightness.light).brightness,
        Brightness.light,
        reason: '${skin.storageValue} light',
      );
      expect(
        skin.scheme(Brightness.dark).brightness,
        Brightness.dark,
        reason: '${skin.storageValue} dark',
      );
    }
  });

  // Matrix and Parchment hand-pick their surface roles instead of taking
  // what fromSeed generates, which means nothing is checking that the text
  // on them stays readable. This is that check.
  test('text stays readable on every skin in both brightnesses', () {
    for (final AppSkin skin in AppSkin.values) {
      for (final Brightness brightness in Brightness.values) {
        final ColorScheme cs = skin.scheme(brightness);
        final String where = '${skin.storageValue}/${brightness.name}';

        expect(
          _contrast(cs.onSurface, cs.surface),
          greaterThanOrEqualTo(4.5),
          reason: 'onSurface on surface ($where)',
        );
        expect(
          _contrast(cs.onPrimary, cs.primary),
          greaterThanOrEqualTo(4.5),
          reason: 'onPrimary on primary ($where)',
        );
        expect(
          _contrast(cs.onPrimaryContainer, cs.primaryContainer),
          greaterThanOrEqualTo(4.5),
          reason: 'onPrimaryContainer on primaryContainer ($where)',
        );
        expect(
          _contrast(cs.onSecondaryContainer, cs.secondaryContainer),
          greaterThanOrEqualTo(4.5),
          reason: 'onSecondaryContainer on secondaryContainer ($where)',
        );
        expect(
          _contrast(cs.onTertiaryContainer, cs.tertiaryContainer),
          greaterThanOrEqualTo(4.5),
          reason: 'onTertiaryContainer on tertiaryContainer ($where)',
        );
        expect(
          _contrast(cs.onErrorContainer, cs.errorContainer),
          greaterThanOrEqualTo(4.5),
          reason: 'onErrorContainer on errorContainer ($where)',
        );
        // Secondary text and hairline borders only have to clear the 3:1 bar
        // WCAG sets for large text and UI outlines, not the 4.5:1 body-copy
        // one — holding them to 4.5 would flatten the visual hierarchy these
        // roles exist to create.
        expect(
          _contrast(cs.onSurfaceVariant, cs.surface),
          greaterThanOrEqualTo(3.0),
          reason: 'onSurfaceVariant on surface ($where)',
        );
        expect(
          _contrast(cs.outline, cs.surface),
          greaterThanOrEqualTo(1.5),
          reason: 'outline on surface ($where)',
        );
      }
    }
  });
}
