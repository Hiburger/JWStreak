import 'package:flutter/material.dart';

// this is a lot for just a circular button i admit :(

/// Diameter of the gray disc behind a navigation icon:
const double _kCircleSize = 32;
const double _kCircleIconSize = 18;

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

class CircularBackButton extends StatelessWidget {
  const CircularBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: _kCircleSize,
        height: _kCircleSize,
        child: BackButton(style: circularIconButtonStyle(context)),
      ),
    );
  }
}
