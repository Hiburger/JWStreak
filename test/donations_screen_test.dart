import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/app_constants.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/settings/donations_settings_screen.dart';

void main() {
  testWidgets('the page offers one way to help and says what it is not', (
    WidgetTester tester,
  ) async {
    // Tall surface so the whole page is laid out: SettingsPage uses a
    // ListView, which never builds children below the fold.
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(400, 2400);
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: DonationsSettingsScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Sponsor on GitHub'), findsOneWidget);

    expect(
      find.textContaining('not a religious donation'),
      findsOneWidget,
      reason: 'the page must say plainly what the money is not',
    );
    expect(find.textContaining('independent developer'), findsOneWidget);

    // A free way to help sits alongside the paid one <3
    expect(find.text('Star the project on GitHub'), findsOneWidget);
  });

  test('the free option points at the repo, not the sponsors page', () {
    final String screen = File(
      'lib/screens/settings/donations_settings_screen.dart',
    ).readAsStringSync();
    expect(screen, contains('openExternalUri(Uri.parse(kGithubRepoUrl))'));
    expect(kGithubRepoUrl, isNot(contains('/sponsors/')));
  });

  test('sponsoring is never presented as unlocking anything', () {
    final String arb = File('lib/l10n/app_en.arb').readAsStringSync();
    expect(arb, contains('Sponsoring unlocks nothing at all'));
  });

  test('the sponsors link is only ever handed to the system browser', () {
    final String screen = File(
      'lib/screens/settings/donations_settings_screen.dart',
    ).readAsStringSync();

    expect(screen, contains('openExternalUri(Uri.parse(kGithubSponsorsUrl))'));
    expect(
      screen.contains('inAppBrowserView'),
      isFalse,
      reason: 'funds must be collected outside the app, never in a webview',
    );
    expect(kGithubSponsorsUrl, startsWith('https://github.com/sponsors/'));
  });
}
