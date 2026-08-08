import 'package:flutter/material.dart';

/// The handful of icons that carry this app's own vocabulary — the streak
/// flame, the book, the star, the trophy — bundled so a skin can swap them
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
    required this.star,
    required this.starOutline,
    required this.trophy,
    required this.notes,
    required this.quiz,
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

  final IconData star;
  final IconData starOutline;
  final IconData trophy;
  final IconData notes;
  final IconData quiz;

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
    IconData? star,
    IconData? starOutline,
    IconData? trophy,
    IconData? notes,
    IconData? quiz,
  }) {
    return AppIcons(
      flame: flame ?? this.flame,
      frozen: frozen ?? this.frozen,
      book: book ?? this.book,
      reading: reading ?? this.reading,
      star: star ?? this.star,
      starOutline: starOutline ?? this.starOutline,
      trophy: trophy ?? this.trophy,
      notes: notes ?? this.notes,
      quiz: quiz ?? this.quiz,
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

/// Material's defaults, i.e. what the app looked like before skins existed.
const AppIcons kClassicIcons = AppIcons(
  flame: Icons.local_fire_department_rounded,
  frozen: Icons.ac_unit_rounded,
  book: Icons.menu_book_rounded,
  reading: Icons.auto_stories_outlined,
  star: Icons.star_rounded,
  starOutline: Icons.star_outline_rounded,
  trophy: Icons.emoji_events_rounded,
  notes: Icons.edit_note_outlined,
  quiz: Icons.quiz_outlined,
);

/// Terminal furniture, for the Matrix skin. The mapping keeps each icon's
/// *role* legible — the streak is still "power on / power off", the reward is
/// still a single collectible glyph — so the joke doesn't cost comprehension.
const AppIcons kMatrixIcons = AppIcons(
  flame: Icons.bolt_rounded,
  frozen: Icons.power_settings_new_rounded,
  book: Icons.terminal_rounded,
  reading: Icons.code_rounded,
  star: Icons.memory_rounded,
  starOutline: Icons.memory_outlined,
  trophy: Icons.verified_rounded,
  notes: Icons.keyboard_alt_outlined,
  quiz: Icons.psychology_rounded,
);

/// Scriptorium furniture, for the Parchment skin: quill, scroll, wax seal.
const AppIcons kParchmentIcons = AppIcons(
  flame: Icons.local_fire_department_rounded,
  frozen: Icons.hourglass_empty_rounded,
  book: Icons.auto_stories_rounded,
  reading: Icons.chrome_reader_mode_outlined,
  star: Icons.brightness_7_rounded,
  starOutline: Icons.brightness_5_rounded,
  trophy: Icons.workspace_premium_rounded,
  notes: Icons.history_edu_outlined,
  quiz: Icons.psychology_alt_outlined,
);
