import 'package:flutter/material.dart';

/// Caps how wide a screen's main content gets and centers it, so a phone-
/// first layout doesn't stretch into one absurdly wide column edge-to-edge
/// on a tablet. A no-op on phones, since they're already narrower than
/// [maxWidth].
///
/// 840 rather than a narrower "ideal reading width" value: this app is
/// mostly cards and lists, not paragraphs, so a tighter cap just wastes the
/// extra room a tablet has — on a 13" iPad or a large Android tablet it was
/// leaving huge blank margins on both sides.
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({required this.child, this.maxWidth = 840, super.key});

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
