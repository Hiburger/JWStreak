import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/theme/app_icons.dart';
import 'package:jwstreak/theme/app_skin.dart';

void main() {
  // Each skin's reward is a *different widget kind* under the hood — a
  // plain Icon for Classic/Matrix/Amethyst, a CustomPaint for the other
  // four — so this checks the one thing they all have to do regardless:
  // build without throwing, at the sizes the app actually asks for.
  testWidgets('every skin builds its reward icon at every call-site size', (
    WidgetTester tester,
  ) async {
    for (final AppSkin skin in AppSkin.values) {
      for (final double size in <double>[15, 16, 18, 20, 22, 24, 26, 56, 68]) {
        await tester.pumpWidget(
          MaterialApp(
            home: Material(
              child: skin.icons.reward(size: size, color: Colors.white),
            ),
          ),
        );
        // A build that throws (a bad Path, a null field) surfaces as a
        // FlutterError caught by the test framework — pumping is enough to
        // provoke it.
        expect(tester.takeException(), isNull);
      }
    }
  });

  // Not a WCAG bar — every call site composites these over an app-chosen
  // container (a gradient banner, a colored chip, an icon drawn white on
  // top of the color itself), never bare page background, so a strict
  // contrast requirement against plain white/black would fail colors that
  // have worked fine for years (the original amber included). This checks
  // for the real mistake instead: picking something that isn't a genuine,
  // visible color at all — near-white, near-black, or grey.
  test('every reward color is an actual, visible color', () {
    for (final AppSkin skin in AppSkin.values) {
      final HSLColor hsl = HSLColor.fromColor(skin.icons.rewardColor);
      final String label = skin.storageValue;
      expect(
        hsl.lightness,
        inInclusiveRange(0.15, 0.9),
        reason: '$label reward color is too close to white or black',
      );
      expect(
        hsl.saturation,
        greaterThan(0.25),
        reason: '$label reward color is washed-out grey',
      );
    }
  });

  testWidgets('every skin has a non-empty singular and plural reward noun', (
    WidgetTester tester,
  ) async {
    for (final AppSkin skin in AppSkin.values) {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        MaterialApp(
          locale: const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(extensions: <ThemeExtension<dynamic>>[skin.icons]),
          home: Builder(
            builder: (BuildContext context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      await tester.pump();

      final AppIcons icons = AppIcons.of(capturedContext);
      final String singular = icons.rewardNoun(capturedContext, plural: false);
      final String plural = icons.rewardNoun(capturedContext, plural: true);
      final String label = skin.storageValue;

      expect(singular, isNotEmpty, reason: '$label singular');
      expect(plural, isNotEmpty, reason: '$label plural');
      // English always pluralizes with a suffix for every one of these
      // words (chip/chips, shell/shells, …) — a match here means the
      // singular and plural getters resolved to the same string by mistake,
      // not a legitimate invariant-plural language.
      expect(
        singular,
        isNot(equals(plural)),
        reason: '$label singular/plural resolved to the same string',
      );
    }
  });

  test(
    'classic keeps the app\'s original star, unaffected by the redesign',
    () {
      expect(AppSkin.classic.icons.rewardColor, Colors.amber);
    },
  );

  // The home banner's hero icon: activeMotion is pure Transform/Opacity
  // math driven by sin(t) at various frequencies, so this exercises it
  // across a full loop (0 to 2π) rather than trusting it never divides by
  // zero or produces a NaN offset partway through.
  testWidgets(
    'every skin\'s active-streak motion builds across a full animation loop',
    (WidgetTester tester) async {
      for (final AppSkin skin in AppSkin.values) {
        for (final double t in <double>[0, 1, 2, 3, 4, 5, 2 * 3.14159265]) {
          await tester.pumpWidget(
            MaterialApp(
              home: Material(
                child: skin.icons.activeMotion(
                  t,
                  const Icon(Icons.local_fire_department_rounded),
                ),
              ),
            ),
          );
          expect(tester.takeException(), isNull);
        }
      }
    },
  );

  test('every active color is an actual, visible color', () {
    for (final AppSkin skin in AppSkin.values) {
      final HSLColor hsl = HSLColor.fromColor(skin.icons.activeColor);
      final String label = skin.storageValue;
      expect(
        hsl.lightness,
        inInclusiveRange(0.15, 0.9),
        reason: '$label active color is too close to white or black',
      );
      expect(
        hsl.saturation,
        greaterThan(0.25),
        reason: '$label active color is washed-out grey',
      );
    }
  });
}
