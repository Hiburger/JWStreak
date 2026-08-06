import 'package:flutter/material.dart';

/// Diameter of the gray disc behind a navigation icon.
const double _kCircleSize = 32;
const double _kCircleIconSize = 18;

/// Shared style for a top-left navigation icon sitting on a filled gray
/// circle — Material's default AppBar back arrow has no background of its
/// own and looked bare next to icon buttons elsewhere in the app that do
/// (achievements, quick actions...). Exposed separately from
/// [CircularBackButton] for the onboarding screens' back arrows, which
/// navigate via a callback instead of `Navigator.pop` and so can't use that
/// widget directly.
ButtonStyle circularIconButtonStyle(BuildContext context) {
  final ColorScheme cs = Theme.of(context).colorScheme;
  return IconButton.styleFrom(
    backgroundColor: cs.surfaceContainerHighest,
    shape: const CircleBorder(),
    iconSize: _kCircleIconSize,
    minimumSize: const Size(_kCircleSize, _kCircleSize),
    maximumSize: const Size(_kCircleSize, _kCircleSize),
    padding: EdgeInsets.zero,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  );
}

/// An AppBar back arrow styled with [circularIconButtonStyle]. Only for
/// screens reached via `Navigator.push` (there has to be something to pop
/// back to) — the app's two root AppBars in home_screen.dart don't use this.
class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    // AppBar hands `leading` a slot of a fixed width (56dp by default) with a
    // tight constraint, which stretches the button — and with it the circle —
    // regardless of the size set in the ButtonStyle. Centring a hard-sized box
    // inside that slot is what actually pins the disc to _kCircleSize.
    return Center(
      child: SizedBox(
        width: _kCircleSize,
        height: _kCircleSize,
        child: BackButton(style: circularIconButtonStyle(context)),
      ),
    );
  }
}
