// Hand-drawn reward icons for the skins with no matching Material glyph.
//
// Matrix (chip -> Icons.memory_rounded) and Amethyst (gem ->
// Icons.diamond_rounded) already have a glyph in Flutter's bundled icon
// font -- checked before writing anything here, same way MatchstickIcon
// was: no shell, wax seal, ember or acorn exists in it. Each painter below
// is a single-tone filled silhouette, sized and colored like a normal
// Icon, so it drops into the same call sites the literal
// `Icons.star_rounded` used to sit in.

import 'dart:math' as math;

import 'package:flutter/material.dart';

/// A scallop shell, for Ocean. A fan of five ridges radiating from a hinge
/// point, the way the actual shellfish (and the classic shell logo) reads at
/// a glance even this small.
class ShellIcon extends StatelessWidget {
  const ShellIcon({required this.color, this.size = 16, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _ShellPainter(color: color)),
  );
}

class _ShellPainter extends CustomPainter {
  const _ShellPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Offset hinge = Offset(size.width * 0.5, size.height * 0.90);
    const int ridgeCount = 5;
    // The sweep runs from lower-left, up through straight-up, to
    // lower-right (180°-360°, i.e. sin always negative) — interpolating the
    // "short way" through 90° instead would send the middle ridge *below*
    // the hinge, which is what first turned this into a bat-wing shape
    // instead of a fan.
    const double sweepStart = math.pi * 1.14;
    const double sweepEnd = math.pi * 1.86;
    // Ridges trace the fan's points; valleys sit only a little closer in —
    // deep valleys turned the rim into a spiky crown, not a shell's smooth
    // scalloped edge.
    const double ridgeRadius = 0.48;
    const double valleyRadius = 0.40;

    Offset pointAt(double angle, double radius) =>
        hinge +
        Offset(
          math.cos(angle) * size.width * radius,
          math.sin(angle) * size.height * radius * 1.2,
        );

    final List<Offset> ridgeTips = <Offset>[
      for (int i = 0; i < ridgeCount; i++)
        pointAt(
          sweepStart + (sweepEnd - sweepStart) * (i / (ridgeCount - 1)),
          ridgeRadius,
        ),
    ];
    final List<Offset> valleys = <Offset>[
      for (int i = 0; i < ridgeCount - 1; i++)
        pointAt(
          sweepStart + (sweepEnd - sweepStart) * ((i + 0.5) / (ridgeCount - 1)),
          valleyRadius,
        ),
    ];

    final Path shell = Path()
      ..moveTo(hinge.dx, hinge.dy)
      ..lineTo(ridgeTips.first.dx, ridgeTips.first.dy);
    for (int i = 0; i < valleys.length; i++) {
      // A curve through each valley, not a straight line to it and back out
      // — that's what makes the rim read as scalloped rather than zigzagged.
      shell.quadraticBezierTo(
        valleys[i].dx,
        valleys[i].dy,
        ridgeTips[i + 1].dx,
        ridgeTips[i + 1].dy,
      );
    }
    shell.close();
    canvas.drawPath(shell, paint);
  }

  @override
  bool shouldRepaint(covariant _ShellPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// A wax seal, for Parchment: a round blob with a couple of small drips at
/// the rim, the way melted wax settles once it's been pressed and cooled.
class WaxSealIcon extends StatelessWidget {
  const WaxSealIcon({required this.color, this.size = 16, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _WaxSealPainter(color: color)),
  );
}

class _WaxSealPainter extends CustomPainter {
  const _WaxSealPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Offset center = Offset(size.width * 0.5, size.height * 0.42);
    canvas.drawCircle(center, size.width * 0.34, paint);

    // Two drips, differently sized, hanging just past the rim — identical
    // drips in a neat row would read as a face (two eyes) rather than wax.
    canvas.drawCircle(
      Offset(size.width * 0.36, size.height * 0.74),
      size.width * 0.1,
      paint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.6, size.height * 0.8),
      size.width * 0.075,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _WaxSealPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// A glowing ember, for Sunset — deliberately not another flame: the app
/// already has one (the streak's own icon), and reusing that shape here
/// would recreate exactly the "two different things, same glyph" confusion
/// the matchstick icon was built to get away from. An ember is a chunk, not
/// a lick of fire: an irregular rounded lump with a couple of sparks
/// drifting off it.
class EmberIcon extends StatelessWidget {
  const EmberIcon({required this.color, this.size = 16, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _EmberPainter(color: color)),
  );
}

class _EmberPainter extends CustomPainter {
  const _EmberPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // An asymmetric rounded lump, not a circle — traced by hand with
    // uneven cubic handles so it reads as a chunk of coal rather than a ball.
    final double w = size.width, h = size.height;
    final Path lump = Path()
      ..moveTo(w * 0.30, h * 0.92)
      ..cubicTo(w * 0.05, h * 0.80, w * 0.08, h * 0.48, w * 0.34, h * 0.42)
      ..cubicTo(w * 0.30, h * 0.22, w * 0.58, h * 0.14, w * 0.70, h * 0.32)
      ..cubicTo(w * 0.92, h * 0.36, w * 0.94, h * 0.70, w * 0.72, h * 0.84)
      ..cubicTo(w * 0.60, h * 0.94, w * 0.42, h * 0.96, w * 0.30, h * 0.92)
      ..close();
    canvas.drawPath(lump, paint);

    // Sparks: two small diamonds drifting up and to the right, off the hot
    // top edge of the ember.
    void spark(Offset center, double r) {
      final Path path = Path()
        ..moveTo(center.dx, center.dy - r)
        ..lineTo(center.dx + r * 0.6, center.dy)
        ..lineTo(center.dx, center.dy + r)
        ..lineTo(center.dx - r * 0.6, center.dy)
        ..close();
      canvas.drawPath(path, paint);
    }

    spark(Offset(w * 0.84, h * 0.14), w * 0.07);
    spark(Offset(w * 0.68, h * 0.02), w * 0.045);
  }

  @override
  bool shouldRepaint(covariant _EmberPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// An acorn, for Forest: an oval nut under a wider, flattened cap, with a
/// small stem — the one shape that unambiguously means "forest floor
/// collectible" rather than any of the season's other small round things.
class AcornIcon extends StatelessWidget {
  const AcornIcon({required this.color, this.size = 16, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: CustomPaint(painter: _AcornPainter(color: color)),
  );
}

class _AcornPainter extends CustomPainter {
  const _AcornPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final double w = size.width, h = size.height;

    // Nut: an egg shape, narrower at the bottom, sitting under the cap.
    final Rect nutRect = Rect.fromLTWH(w * 0.22, h * 0.40, w * 0.56, h * 0.54);
    canvas.drawOval(nutRect, paint);

    // Cap: wider than the nut, flattened, overlapping its top edge — the
    // overlap is what welds the two pieces into one silhouette instead of a
    // snowman-style stack.
    final RRect cap = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(w * 0.5, h * 0.38),
        width: w * 0.72,
        height: h * 0.32,
      ),
      Radius.circular(w * 0.12),
    );
    canvas.drawRRect(cap, paint);

    // Stem: a short stroke poking up from the cap's centre.
    final Paint stem = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.09
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(w * 0.5, h * 0.24), Offset(w * 0.5, h * 0.1), stem);
  }

  @override
  bool shouldRepaint(covariant _AcornPainter oldDelegate) =>
      oldDelegate.color != color;
}
