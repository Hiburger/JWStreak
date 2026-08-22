// ignore_for_file: prefer_initializing_formals — the public constructor
// parameter names below are intentionally friendlier than the private fields
// they back.

import 'package:flutter/material.dart';

class OnboardingAccent {
  const OnboardingAccent({
    required Color lightBg,
    required Color lightFg,
    required Color darkBg,
    required Color darkFg,
  }) : _lightBg = lightBg,
       _lightFg = lightFg,
       _darkBg = darkBg,
       _darkFg = darkFg;

  final Color _lightBg;
  final Color _lightFg;
  final Color _darkBg;
  final Color _darkFg;

  Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _darkBg : _lightBg;

  Color foreground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? _darkFg : _lightFg;
}

const OnboardingAccent kAccentBlue = OnboardingAccent(
  lightBg: Color(0xFFD9E8FB),
  lightFg: Color(0xFF1F4E79),
  darkBg: Color(0xFF25436A),
  darkFg: Color(0xFFBFDBFF),
);

const OnboardingAccent kAccentAmber = OnboardingAccent(
  lightBg: Color(0xFFFFE7A8),
  lightFg: Color(0xFF7A5200),
  darkBg: Color(0xFF5C4200),
  darkFg: Color(0xFFFFD98A),
);

const OnboardingAccent kAccentTeal = OnboardingAccent(
  lightBg: Color(0xFFC7EDE2),
  lightFg: Color(0xFF0E6B56),
  darkBg: Color(0xFF104A3D),
  darkFg: Color(0xFF8FE6D2),
);

const OnboardingAccent kAccentPurple = OnboardingAccent(
  lightBg: Color(0xFFF0E0FC),
  lightFg: Color(0xFF6A3F94),
  darkBg: Color(0xFF48305F),
  darkFg: Color(0xFFE4C9FA),
);

/// Matches the deepOrange used for the streak flame elsewhere (home screen's
/// stat tile, the "streak fire" easter egg) — for streak achievements, so
/// the color means the same thing wherever it shows up.
const OnboardingAccent kAccentOrange = OnboardingAccent(
  lightBg: Color(0xFFFFDBC7),
  lightFg: Color(0xFF8A3900),
  darkBg: Color(0xFF6B3300),
  darkFg: Color(0xFFFFB88A),
);

/// Echoes the pink of the heart on the about page — used for the donations
/// category, the other place the app talks about supporting it.
const OnboardingAccent kAccentPink = OnboardingAccent(
  lightBg: Color(0xFFFBDCE7),
  lightFg: Color(0xFF8E2F52),
  darkBg: Color(0xFF612540),
  darkFg: Color(0xFFF8BDD2),
);
