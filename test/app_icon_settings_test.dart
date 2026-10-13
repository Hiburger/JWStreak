import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/settings_screen.dart';
import 'package:jwstreak/services/notification_service.dart';
import 'package:jwstreak/theme/app_skin.dart';
import 'package:jwstreak/theme/theme_preference.dart';

Future<void> _pumpHub(WidgetTester tester) async {
  // The default 800x600 test viewport cuts the hub off mid-list; a taller
  // window keeps every tile laid out so their on-screen order can be read.
  tester.view.physicalSize = const Size(800, 1600);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SettingsScreen(
        currentThemePreference: ThemePreference.system,
        onThemePreferenceChanged: (_) async {},
        currentAppSkin: AppSkin.classic,
        onAppSkinChanged: (_) async {},
        notificationService: NotificationService(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('the hub lists App icon between Donations and Help & about', (
    WidgetTester tester,
  ) async {
    await _pumpHub(tester);

    final double donationsDy = tester.getTopLeft(find.text('Donations')).dy;
    final double appIconDy = tester.getTopLeft(find.text('App icon')).dy;
    final double aboutDy = tester.getTopLeft(find.text('Help & about')).dy;

    expect(
      donationsDy < appIconDy && appIconDy < aboutDy,
      isTrue,
      reason: 'App icon must sit between Donations and Help & about',
    );
  });

  testWidgets('tapping the tile opens the coming-soon page', (
    WidgetTester tester,
  ) async {
    await _pumpHub(tester);

    await tester.tap(find.text('App icon'));
    await tester.pumpAndSettle();

    expect(find.text('Coming soon'), findsOneWidget);
    expect(
      find.textContaining("Soon, you'll be able to change the app icon"),
      findsOneWidget,
    );
    expect(find.text('Send your ideas'), findsOneWidget);
    // The mailto affordance is a button that doesn't spell the address out.
    expect(find.text('Reach out via mail'), findsOneWidget);
    expect(find.text('contact@olynthe.org'), findsNothing);
  });
}
