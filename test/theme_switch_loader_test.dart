import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/settings/personalization_settings_screen.dart';
import 'package:jwstreak/theme/app_skin.dart';
import 'package:jwstreak/theme/theme_preference.dart';

/// Pumps the personalization page with [gate] blocking the change callback,
/// so the loader's presence can be asserted while the switch is in flight.
Future<void> pumpPersonalization(
  WidgetTester tester, {
  required Completer<void> gate,
  void Function(AppSkin skin)? onSkin,
  void Function(ThemePreference preference)? onTheme,
  void Function(String? code)? onLocale,
}) async {
  // Tall enough that the brightness chips sit inside the viewport without
  // scrolling — the test taps them where they are laid out.
  await tester.binding.setSurfaceSize(const Size(800, 1200));
  addTearDown(() => tester.binding.setSurfaceSize(null));

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: PersonalizationSettingsScreen(
        currentThemePreference: ThemePreference.system,
        onThemePreferenceChanged: (ThemePreference value) async {
          onTheme?.call(value);
          await gate.future;
        },
        currentAppSkin: AppSkin.classic,
        onAppSkinChanged: (AppSkin value) async {
          onSkin?.call(value);
          await gate.future;
        },
        onLocaleChanged: (String? code) async {
          onLocale?.call(code);
          await gate.future;
        },
      ),
    ),
  );
  await tester.pump();
}

/// The frame the tap lands on, then the loader's fade-in.
Future<void> pumpSwitchStart(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 220));
}

/// Lets the gated change finish and the loader fade back out.
Future<void> finishSwitch(WidgetTester tester, Completer<void> gate) async {
  gate.complete();
  // The deliberate hold after the change, then the reverse fade.
  await tester.pump(const Duration(milliseconds: 300));
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  testWidgets('switching brightness shows the shared loader', (
    WidgetTester tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    ThemePreference? received;
    await pumpPersonalization(
      tester,
      gate: gate,
      onTheme: (ThemePreference preference) => received = preference,
    );

    await tester.tap(find.text('Dark'));
    await pumpSwitchStart(tester);
    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
      reason: 'the loader must cover the re-theme while it happens',
    );

    await finishSwitch(tester, gate);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(received, ThemePreference.dark);
  });

  testWidgets('switching skin shows the shared loader', (
    WidgetTester tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    AppSkin? received;
    await pumpPersonalization(
      tester,
      gate: gate,
      onSkin: (AppSkin skin) => received = skin,
    );

    // The swatch preview under the "Amethyst" label, found by the surface
    // color that preview is painted with — the label itself sits below the
    // tap target.
    final Finder amethystSwatch = find.byWidgetPredicate(
      (Widget widget) =>
          widget is Material &&
          widget.color == AppSkin.amethyst.scheme(Brightness.light).surface,
    );
    await tester.tap(amethystSwatch);
    await pumpSwitchStart(tester);
    expect(
      find.byType(CircularProgressIndicator),
      findsOneWidget,
      reason: 'the loader must cover the re-skin while it happens',
    );

    await finishSwitch(tester, gate);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(received, AppSkin.amethyst);
  });

  testWidgets('switching language keeps the same loader', (
    WidgetTester tester,
  ) async {
    final Completer<void> gate = Completer<void>();
    String? received;
    await pumpPersonalization(
      tester,
      gate: gate,
      onLocale: (String? code) => received = code,
    );

    await tester.tap(find.text('Français'));
    await pumpSwitchStart(tester);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await finishSwitch(tester, gate);
    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(received, 'fr');
  });
}
