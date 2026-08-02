import 'package:flutter/material.dart';

/// Caps how wide a screen's main content gets and centers it, so a phone-
/// first layout doesn't stretch into one absurdly wide column edge-to-edge
/// on a tablet. A no-op on phones, since they're already narrower than
/// [maxWidth].
class ResponsiveBody extends StatelessWidget {
  const ResponsiveBody({required this.child, this.maxWidth = 600, super.key});

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
