import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../widgets/reward_icons.dart';

/// The handful of icons that carry this app's own vocabulary — the streak
/// flame, the book, the reward, the trophy — bundled so a skin can swap them
/// all at once and no screen has to know which skin is active.
///
/// Deliberately small. Only icons that *mean* something specific to JW Streak
/// live here; generic affordances (chevrons, the back arrow, the settings
/// gear, delete) stay literal `Icons.` references at their call sites. A fun
/// theme that also renames the back button stops being fun and starts being
/// unusable.
@immutable
class AppIcons extends ThemeExtension<AppIcons> {
  const AppIcons({
    required this.flame,
    required this.frozen,
    required this.book,
    required this.reading,
    required this.trophy,
    required this.notes,
    required this.quiz,
    required this.reward,
    required this.rewardColor,
    required this.rewardNoun,
    required this.activeColor,
    required this.activeMotion,
  });

  /// The streak, while it's alive.
  final IconData flame;

  /// The streak, once it's back to zero — the "frozen" counterpart to
  /// [flame], not a generic error state.
  final IconData frozen;

  /// Opening a chapter elsewhere (JW Library / jw.org).
  final IconData book;

  /// Reading as an activity, as opposed to [book]'s "go read this now".
  final IconData reading;

  final IconData trophy;
  final IconData notes;
  final IconData quiz;

  /// The quiz reward, drawn at the given size and color. A widget builder
  /// rather than an [IconData] because not every skin's reward has a
  /// matching glyph in Flutter's icon font — Ocean's shell, Parchment's wax
  /// seal, Sunset's ember and Forest's acorn are hand-painted (see
  /// reward_icons.dart), and this is the one signature that fits both a
  /// plain [Icon] and a [CustomPaint] behind the same call.
  final Widget Function({required double size, required Color color}) reward;

  /// The reward's own accent color — Classic keeps the amber the app always
  /// used; the others pick a color that suits what they're actually
  /// depicting (a shell doesn't read as itself in amber).
  final Color rewardColor;

  /// The reward's name, singular or plural — "3 stars", "3 chips", "3
  /// shells". Takes [BuildContext] rather than a plain [AppLocalizations]
  /// because it's resolved at the call site's build time, not when the
  /// theme itself is constructed (main.dart builds the theme above where
  /// AppLocalizations.of(context) can still resolve).
  final String Function(BuildContext context, {required bool plural})
  rewardNoun;

  /// The home banner's hero icon color while the streak is alive — the glow
  /// halo behind it and the gradient painted across it both derive from this
  /// one color. Only meaningful for [flame]; the frozen state stays a fixed
  /// icy blue for every skin (cold reads as cold regardless of theme).
  final Color activeColor;

  /// How the hero icon moves while the streak is alive, given the animation
  /// phase `t` (0 to 2π, looping). A flickering skew-and-bob reads as "fire"
  /// for a literal flame glyph, but the same motion applied to, say, a wave
  /// or a leaf looks like nervous twitching rather than anything those
  /// things actually do — so each skin whose [flame] isn't literal fire gets
  /// motion that suits what it *is* instead (a sway for water, a sparkle's
  /// twinkle, an electric flicker for a bolt).
  final Widget Function(double t, Widget icon) activeMotion;

  /// Falls back to [kClassicIcons] rather than throwing: widget tests build
  /// bare `MaterialApp`s without the extension registered, and an icon is
  /// never worth failing a screen over.
  static AppIcons of(BuildContext context) =>
      Theme.of(context).extension<AppIcons>() ?? kClassicIcons;

  @override
  AppIcons copyWith({
    IconData? flame,
    IconData? frozen,
    IconData? book,
    IconData? reading,
    IconData? trophy,
    IconData? notes,
    IconData? quiz,
    Widget Function({required double size, required Color color})? reward,
    Color? rewardColor,
    String Function(BuildContext context, {required bool plural})? rewardNoun,
    Color? activeColor,
    Widget Function(double t, Widget icon)? activeMotion,
  }) {
    return AppIcons(
      flame: flame ?? this.flame,
      frozen: frozen ?? this.frozen,
      book: book ?? this.book,
      reading: reading ?? this.reading,
      trophy: trophy ?? this.trophy,
      notes: notes ?? this.notes,
      quiz: quiz ?? this.quiz,
      reward: reward ?? this.reward,
      rewardColor: rewardColor ?? this.rewardColor,
      rewardNoun: rewardNoun ?? this.rewardNoun,
      activeColor: activeColor ?? this.activeColor,
      activeMotion: activeMotion ?? this.activeMotion,
    );
  }

  /// Icons can't be tweened, so this snaps at the halfway point. Switching
  /// skins therefore changes the glyphs mid-way through the color animation
  /// rather than on either edge of it, which reads as one transition instead
  /// of two.
  @override
  AppIcons lerp(ThemeExtension<AppIcons>? other, double t) {
    if (other is! AppIcons) {
      return this;
    }
    return t < 0.5 ? this : other;
  }
}

// The home banner's "streak is alive" motion, one per skin. Each takes the
// animation's current phase and the icon widget, and returns it transformed
// for that instant — home_screen.dart drives the clock and the shared glow
// halo; these only decide how the icon itself behaves inside it.

/// The original: an asymmetric skew, a scale pulse and an upward bob,
/// timed to feel like a small flame licking rather than a mechanical
/// wobble. Used by every skin whose [AppIcons.flame] is still literal fire.
Widget _flameMotion(double t, Widget icon) {
  final double scale =
      1.0 + 0.05 * math.sin(t * 3) + 0.02 * math.sin(t * 5 + 0.6);
  final double skew = 0.05 * math.sin(t * 2 + 1.0);
  final double bob = 1.5 * math.sin(t * 3 + 0.5);
  return Transform.translate(
    offset: Offset(0, bob),
    child: Transform(
      alignment: Alignment.bottomCenter,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateZ(skew)
        ..scaleByDouble(scale, scale, 1, 1),
      child: icon,
    ),
  );
}

/// Matrix's bolt: an electric flicker — an irregular opacity strobe (two
/// sine terms at frequencies that don't share a period, so it never
/// settles into an obvious metronome) plus a tiny horizontal jitter, the
/// way a loose connection stutters rather than breathes.
Widget _boltMotion(double t, Widget icon) {
  final double strobe = (math.sin(t * 7) * math.sin(t * 3.3)).abs();
  final double jitterX = 1.2 * math.sin(t * 11) * math.sin(t * 4.7);
  return Transform.translate(
    offset: Offset(jitterX, 0),
    child: Opacity(opacity: 0.72 + 0.28 * strobe, child: icon),
  );
}

/// Ocean's wave: a smooth side-to-side sway with a shallow bob — floating,
/// not flickering. No skew and no scale pulse, both of which read as fire.
Widget _waveMotion(double t, Widget icon) {
  final double swayX = 3.0 * math.sin(t);
  final double bob = 2.0 * math.sin(t * 2 + 0.4);
  return Transform.translate(offset: Offset(swayX, bob), child: icon);
}

/// Sunset's twilight sun: a slow, steady breathing scale — a sun glows,
/// it doesn't jitter, so this is deliberately the calmest motion of the set.
Widget _sunMotion(double t, Widget icon) {
  final double scale = 1.0 + 0.04 * math.sin(t);
  return Transform.scale(scale: scale, child: icon);
}

/// Forest's leaf: a gentle sway paired with a little rotation — what a leaf
/// does in a light breeze, as distinct from water's straight side-to-side
/// glide. Both frequencies are whole multiples of the loop (1 and 2, same
/// as the wave's own sway) — the original used 1.3 and 2.6, which don't
/// land back on themselves after one loop and produced a small but real
/// snap on every restart.
Widget _leafMotion(double t, Widget icon) {
  final double angle = 0.06 * math.sin(t);
  final double bob = 1.5 * math.sin(t * 2 + 0.5);
  return Transform.translate(
    offset: Offset(0, bob),
    child: Transform.rotate(angle: angle, child: icon),
  );
}

/// Amethyst's sparkle: a twinkle, not a slow spin — a sharp brightness flash
/// (cubing the sine wave turns its smooth bump into a quick pop that fades
/// slower than it rises, closer to how a glint actually catches the eye)
/// with a small tilt, not the earlier continuous rotation. That rotation
/// used a frequency that wasn't a whole multiple of the loop, so the angle
/// didn't land back where it started — every ~4s the icon visibly snapped
/// backward when the loop restarted. Every term here is back to a whole
/// multiple, the same rule the rest of this file's motions already follow.
Widget _sparkleMotion(double t, Widget icon) {
  final double glint = math.pow(0.5 + 0.5 * math.sin(t * 2), 3).toDouble();
  final double wobble = 0.05 * math.sin(t * 2 + 0.7);
  return Transform.rotate(
    angle: wobble,
    child: Transform.scale(
      scale: 1.0 + 0.09 * glint,
      child: Opacity(opacity: 0.7 + 0.3 * glint, child: icon),
    ),
  );
}

Widget _starReward({required double size, required Color color}) =>
    Icon(Icons.star_rounded, size: size, color: color);

Widget _chipReward({required double size, required Color color}) =>
    Icon(Icons.memory_rounded, size: size, color: color);

Widget _sealReward({required double size, required Color color}) =>
    WaxSealIcon(size: size, color: color);

Widget _shellReward({required double size, required Color color}) =>
    ShellIcon(size: size, color: color);

Widget _emberReward({required double size, required Color color}) =>
    EmberIcon(size: size, color: color);

Widget _acornReward({required double size, required Color color}) =>
    AcornIcon(size: size, color: color);

Widget _gemReward({required double size, required Color color}) =>
    Icon(Icons.diamond_rounded, size: size, color: color);

String _starNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.homeStatStarsPlural : l10n.homeStatStarSingular;
}

String _chipNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardChipsPlural : l10n.rewardChipSingular;
}

String _sealNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardSealsPlural : l10n.rewardSealSingular;
}

String _shellNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardShellsPlural : l10n.rewardShellSingular;
}

String _emberNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardEmbersPlural : l10n.rewardEmberSingular;
}

String _acornNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardAcornsPlural : l10n.rewardAcornSingular;
}

String _gemNoun(BuildContext context, {required bool plural}) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  return plural ? l10n.rewardGemsPlural : l10n.rewardGemSingular;
}

/// Material's defaults, i.e. what the app looked like before skins existed.
const AppIcons kClassicIcons = AppIcons(
  flame: Icons.local_fire_department_rounded,
  frozen: Icons.ac_unit_rounded,
  book: Icons.menu_book_rounded,
  reading: Icons.auto_stories_outlined,
  trophy: Icons.emoji_events_rounded,
  notes: Icons.edit_note_outlined,
  quiz: Icons.quiz_outlined,
  reward: _starReward,
  rewardColor: Colors.amber,
  rewardNoun: _starNoun,
  activeColor: Colors.deepOrange,
  activeMotion: _flameMotion,
);

/// Terminal furniture, for the Matrix skin. The mapping keeps each icon's
/// *role* legible — the streak is still "power on / power off", the reward is
/// still a single collectible glyph — so the joke doesn't cost comprehension.
const AppIcons kMatrixIcons = AppIcons(
  flame: Icons.bolt_rounded,
  frozen: Icons.power_settings_new_rounded,
  book: Icons.terminal_rounded,
  reading: Icons.code_rounded,
  trophy: Icons.verified_rounded,
  notes: Icons.keyboard_alt_outlined,
  quiz: Icons.psychology_rounded,
  reward: _chipReward,
  rewardColor: Color(0xFF44FF7D),
  rewardNoun: _chipNoun,
  activeColor: Color(0xFF44FF7D),
  activeMotion: _boltMotion,
);

/// Scriptorium furniture, for the Parchment skin: quill, scroll, wax seal.
const AppIcons kParchmentIcons = AppIcons(
  flame: Icons.local_fire_department_rounded,
  frozen: Icons.hourglass_empty_rounded,
  book: Icons.auto_stories_rounded,
  reading: Icons.chrome_reader_mode_outlined,
  trophy: Icons.workspace_premium_rounded,
  notes: Icons.history_edu_outlined,
  quiz: Icons.psychology_alt_outlined,
  reward: _sealReward,
  rewardColor: Color(0xFFB33A3A),
  rewardNoun: _sealNoun,
  activeColor: Colors.deepOrange,
  activeMotion: _flameMotion,
);

/// Coastal furniture, for Ocean: the streak is the current still rolling in
/// (still) versus a dropped anchor (stopped); reading is diving in.
const AppIcons kOceanIcons = AppIcons(
  flame: Icons.waves_rounded,
  frozen: Icons.anchor_rounded,
  book: Icons.sailing_rounded,
  reading: Icons.scuba_diving_rounded,
  trophy: Icons.beach_access_rounded,
  notes: Icons.water_drop_rounded,
  quiz: Icons.bubble_chart_rounded,
  reward: _shellReward,
  rewardColor: Color(0xFFFF8A65),
  rewardNoun: _shellNoun,
  activeColor: Color(0xFF00BCD4),
  activeMotion: _waveMotion,
);

/// Golden-hour furniture, for Sunset: the sun still up on the horizon
/// (active) versus night having fallen (streak lost).
const AppIcons kSunsetIcons = AppIcons(
  flame: Icons.wb_twilight_rounded,
  frozen: Icons.nightlight_rounded,
  book: Icons.landscape_rounded,
  reading: Icons.terrain_rounded,
  trophy: Icons.military_tech_rounded,
  notes: Icons.edit_outlined,
  quiz: Icons.tips_and_updates_rounded,
  reward: _emberReward,
  rewardColor: Color(0xFFFF7043),
  rewardNoun: _emberNoun,
  activeColor: Color(0xFFFFA726),
  activeMotion: _sunMotion,
);

/// Woodland furniture, for Forest: growth (active streak) versus a quiet,
/// bare park (streak dormant) — deliberately not literal fire, which reads
/// as "forest fire" here rather than "streak alive."
const AppIcons kForestIcons = AppIcons(
  flame: Icons.eco_rounded,
  frozen: Icons.park_rounded,
  book: Icons.forest_rounded,
  reading: Icons.grass_rounded,
  trophy: Icons.emoji_nature_rounded,
  notes: Icons.edit_note_outlined,
  quiz: Icons.travel_explore_rounded,
  reward: _acornReward,
  rewardColor: Color(0xFF8D6E43),
  rewardNoun: _acornNoun,
  activeColor: Color(0xFF66BB6A),
  activeMotion: _leafMotion,
);

/// Crystal furniture, for Amethyst: a shimmer (active) versus that shimmer
/// dulled (streak lost) — book stays a literal open book, same as every
/// other skin, since that's the one icon that's also a tap target and
/// getting too abstract about it costs more than it gains.
const AppIcons kAmethystIcons = AppIcons(
  flame: Icons.auto_awesome_rounded,
  frozen: Icons.blur_on_rounded,
  book: Icons.auto_stories_rounded,
  reading: Icons.auto_fix_high_rounded,
  trophy: Icons.stars_rounded,
  notes: Icons.auto_fix_normal_outlined,
  quiz: Icons.auto_awesome_mosaic_rounded,
  reward: _gemReward,
  rewardColor: Color(0xFFB388FF),
  rewardNoun: _gemNoun,
  activeColor: Color(0xFFAB47BC),
  activeMotion: _sparkleMotion,
);
