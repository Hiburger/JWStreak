import 'package:flutter/material.dart';

/// A single lit matchstick, hand-drawn: Material's icon font has no glyph
/// for one.
///
/// Used for the freeze count in the home screen's streak banner. That badge
/// used to borrow the streak's own flame glyph outright, which meant "your
/// streak is lit" and "how many freezes you're holding" looked identical —
/// a spare match reads as its own thing: something kept in reserve to
/// relight the streak if it goes out, not the fire itself. It keeps a small
/// flame of its own (unlike the plain unlit stick tried first, which read as
/// a pin) because that's the one feature that makes "matchstick" unambiguous
/// at a 16dp badge size — a bare stick-with-a-bump could be almost anything.
class MatchstickIcon extends StatelessWidget {
  const MatchstickIcon({required this.color, this.size = 16, super.key});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _MatchstickPainter(color: color)),
    );
  }
}

class _MatchstickPainter extends CustomPainter {
  const _MatchstickPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Everything below is drawn upright in this rotated space, so the whole
    // composition — stick, head and flame together — leans as one unit,
    // the way a held match actually tilts.
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(0.52);
    canvas.translate(-size.width / 2, -size.height / 2);

    // Stick: drawn as a thick round-capped line rather than a rectangle —
    // the rounded ends come for free, including the blunt (not pointed)
    // bottom that's what separates a matchstick from a pin.
    final Paint stickStroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.15
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.94),
      Offset(size.width * 0.5, size.height * 0.48),
      stickStroke,
    );

    // Head: a small bump where the stick meets the flame, overlapping both
    // so the join reads as one continuous object rather than three stacked
    // pieces.
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.44),
      size.width * 0.11,
      fill,
    );

    // Flame: one asymmetric teardrop rather than the layered inner/outer
    // curves a large illustration can afford — at a 16dp badge that detail
    // would just blur into the fill. Leaning right, the way a flame licks
    // up off whatever it's lit from rather than sitting perfectly upright.
    final double fw = size.width * 0.4;
    final double fh = size.height * 0.42;
    final double fx = size.width * 0.5 - fw * 0.42;
    final double fy = size.height * 0.03;
    final Path flame = Path()
      ..moveTo(fx + fw * 0.46, fy + fh)
      ..cubicTo(
        fx - fw * 0.08,
        fy + fh * 0.66,
        fx + fw * 0.02,
        fy + fh * 0.22,
        fx + fw * 0.62,
        fy,
      )
      ..cubicTo(
        fx + fw * 0.42,
        fy + fh * 0.32,
        fx + fw * 0.9,
        fy + fh * 0.4,
        fx + fw * 0.82,
        fy + fh * 0.78,
      )
      ..cubicTo(
        fx + fw * 0.78,
        fy + fh * 0.92,
        fx + fw * 0.6,
        fy + fh,
        fx + fw * 0.46,
        fy + fh,
      )
      ..close();
    canvas.drawPath(flame, fill);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _MatchstickPainter oldDelegate) =>
      oldDelegate.color != color;
}
