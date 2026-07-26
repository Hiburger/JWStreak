import 'dart:math' as math;

import 'package:flutter/material.dart';

/// The same purple used for the logo glow on the first onboarding page, so
/// the tour's highlight reads as part of the same visual language.
const Color _kGlowColor = Color(0xFFD5A5EE);

/// Shape of the spotlight cut out around a tour target.
enum TourHighlightShape {
  /// Rounded rectangle — for cards, tiles and sections.
  roundedRect,

  /// Circle — for icon buttons.
  circle,
}

/// One step of a guided tour: the widget to spotlight plus the copy to show
/// next to it.
///
/// Adding a step anywhere in the app is just: create a `GlobalKey`, attach it
/// to the widget you want to highlight, and append a [TourStep] to the list
/// you pass to [showGuidedTour]. Steps whose target isn't currently on screen
/// (for example a conditional banner) are skipped automatically.
class TourStep {
  const TourStep({
    required this.targetKey,
    required this.title,
    required this.body,
    this.shape = TourHighlightShape.roundedRect,
    this.cornerRadius = 20,
  });

  /// Key attached to the widget this step points at.
  final GlobalKey targetKey;

  /// Short headline (a few words).
  final String title;

  /// One or two sentences explaining what the target does.
  final String body;

  final TourHighlightShape shape;

  /// For [TourHighlightShape.roundedRect] steps: how rounded the spotlight
  /// cutout is. Match the target widget's own corner radius so the highlight
  /// reads as tracing its actual shape rather than a generic box.
  final double cornerRadius;
}

/// Labels used by the tour chrome. Passed in so this widget stays free of any
/// direct localization dependency.
class TourLabels {
  const TourLabels({
    required this.skip,
    required this.next,
    required this.done,
  });

  final String skip;
  final String next;
  final String done;
}

/// Shows [steps] as a spotlight walkthrough over the current screen.
///
/// Each step scrolls its target into view, dims everything else, and shows a
/// small card with the copy. Tapping anywhere advances; the last step closes
/// the tour. Returns once the tour is finished or skipped.
Future<void> showGuidedTour(
  BuildContext context, {
  required List<TourStep> steps,
  required TourLabels labels,
}) async {
  final List<TourStep> available = steps
      .where((TourStep s) => s.targetKey.currentContext != null)
      .toList(growable: false);
  if (available.isEmpty) {
    return;
  }
  await Navigator.of(
    context,
  ).push(_GuidedTourRoute(steps: available, labels: labels));
}

class _GuidedTourRoute extends PopupRoute<void> {
  _GuidedTourRoute({required this.steps, required this.labels});

  final List<TourStep> steps;
  final TourLabels labels;

  @override
  Color? get barrierColor => null; // The overlay paints its own scrim.

  @override
  bool get barrierDismissible => false;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 250);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(
      opacity: animation,
      child: _GuidedTourView(steps: steps, labels: labels),
    );
  }
}

class _GuidedTourView extends StatefulWidget {
  const _GuidedTourView({required this.steps, required this.labels});

  final List<TourStep> steps;
  final TourLabels labels;

  @override
  State<_GuidedTourView> createState() => _GuidedTourViewState();
}

class _GuidedTourViewState extends State<_GuidedTourView>
    with SingleTickerProviderStateMixin {
  static const double _holePadding = 8;
  // Icon buttons (achievements/notes/settings) get a tighter ring — the
  // default padding made those circles feel oversized next to a small icon.
  static const double _circleHolePadding = -4;
  static const double _cardGap = 16;

  int _index = 0;
  // True while a scroll-into-view is in flight. The spotlight is measured
  // fresh every frame regardless (see `build`), so its size and position
  // morph continuously as the page scrolls — this is what makes it resize
  // *during* the move instead of only before or after. The card is hidden
  // meanwhile since it isn't worth animating along for a fast scroll.
  bool _isNavigating = true;
  late final AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
    WidgetsBinding.instance.addPostFrameCallback((_) => _goTo(0));
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  /// Scrolls step [index]'s target into view. The spotlight tracks it live
  /// (see `build`) for the whole duration, so no explicit "wait then measure
  /// once" step is needed here.
  Future<void> _goTo(int index) async {
    final BuildContext? target = widget.steps[index].targetKey.currentContext;
    if (target == null) {
      _advancePast(index);
      return;
    }
    setState(() => _isNavigating = true);
    await Scrollable.ensureVisible(
      target,
      alignment: 0.5,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
    if (!mounted) {
      return;
    }
    setState(() => _isNavigating = false);
  }

  /// Skips a step whose target vanished (e.g. a conditional banner).
  void _advancePast(int index) {
    if (index + 1 < widget.steps.length) {
      setState(() => _index = index + 1);
      _goTo(index + 1);
    } else {
      _finish();
    }
  }

  Rect? _measure(GlobalKey key) {
    final BuildContext? ctx = key.currentContext;
    if (ctx == null) {
      return null;
    }
    final RenderObject? box = ctx.findRenderObject();
    if (box is! RenderBox || !box.hasSize) {
      return null;
    }
    return box.localToGlobal(Offset.zero) & box.size;
  }

  void _next() {
    if (_isNavigating) {
      return;
    }
    if (_index + 1 < widget.steps.length) {
      setState(() => _index += 1);
      _goTo(_index);
    } else {
      _finish();
    }
  }

  void _finish() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TourStep step = widget.steps[_index];
    final Size screen = MediaQuery.sizeOf(context);
    final EdgeInsets safe = MediaQuery.paddingOf(context);
    final bool isLast = _index == widget.steps.length - 1;
    final bool showCard = !_isNavigating;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _next,
      child: Stack(
        children: <Widget>[
          // Dimmed backdrop with a glowing hole, re-measured every frame
          // (driven by the glow ticker) so it tracks the target's real
          // on-screen rect continuously — including while the page is still
          // scrolling it into view, which is what makes size and position
          // morph together smoothly instead of jumping at the end.
          Positioned.fill(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _glowController,
                builder: (BuildContext context, _) {
                  final Rect? hole = _measure(step.targetKey);
                  final double radius = hole == null
                      ? 0
                      : step.shape == TourHighlightShape.circle
                      ? hole.longestSide / 2 + _circleHolePadding
                      : step.cornerRadius;
                  final Rect inflated = hole == null
                      ? Rect.zero
                      : step.shape == TourHighlightShape.circle
                      ? Rect.fromCircle(center: hole.center, radius: radius)
                      : hole.inflate(_holePadding);
                  final double angle = _glowController.value * 2 * math.pi;
                  final double pulse =
                      0.5 + 0.5 * math.sin(_glowController.value * 2 * math.pi);
                  return CustomPaint(
                    painter: _SpotlightPainter(
                      hole: inflated,
                      radius: radius,
                      scrim: Colors.black.withValues(alpha: 0.72),
                      glowAngle: angle,
                      glowPulse: pulse,
                    ),
                  );
                },
              ),
            ),
          ),
          if (showCard)
            Builder(
              builder: (BuildContext context) {
                final Rect? hole = _measure(step.targetKey);
                if (hole == null) {
                  return const SizedBox.shrink();
                }
                final double padding = step.shape == TourHighlightShape.circle
                    ? hole.longestSide / 2 + _circleHolePadding
                    : _holePadding;
                final Rect inflated = step.shape == TourHighlightShape.circle
                    ? Rect.fromCircle(center: hole.center, radius: padding)
                    : hole.inflate(padding);
                final bool cardBelow = hole.center.dy < screen.height * 0.5;
                return Positioned(
                  left: 20,
                  right: 20,
                  top: cardBelow ? inflated.bottom + _cardGap : null,
                  bottom: cardBelow
                      ? null
                      : screen.height - inflated.top + _cardGap,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _TourCard(
                      key: ValueKey<int>(_index),
                      title: step.title,
                      body: step.body,
                      index: _index,
                      total: widget.steps.length,
                      actionLabel: isLast
                          ? widget.labels.done
                          : widget.labels.next,
                      onAction: _next,
                    ),
                  ),
                );
              },
            ),
          // Skip control, kept clear of the navigation bar.
          Positioned(
            left: 0,
            right: 0,
            bottom: safe.bottom + 16,
            child: Center(
              child: FilledButton.tonal(
                onPressed: _finish,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white.withValues(alpha: 0.16),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 12,
                  ),
                  shape: const StadiumBorder(),
                ),
                child: Text(
                  widget.labels.skip,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TourCard extends StatelessWidget {
  const _TourCard({
    required this.title,
    required this.body,
    required this.index,
    required this.total,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final String title;
  final String body;
  final int index;
  final int total;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return Material(
      color: cs.surfaceContainerHigh,
      elevation: 6,
      borderRadius: BorderRadius.circular(20),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              body,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: cs.onSurfaceVariant,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: <Widget>[
                for (int i = 0; i < total; i++)
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    width: i == index ? 18 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: i == index
                          ? cs.primary
                          : cs.onSurfaceVariant.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                const Spacer(),
                FilledButton.tonal(
                  onPressed: onAction,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    shape: const StadiumBorder(),
                  ),
                  child: Text(
                    actionLabel,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SpotlightPainter extends CustomPainter {
  const _SpotlightPainter({
    required this.hole,
    required this.radius,
    required this.scrim,
    required this.glowAngle,
    required this.glowPulse,
  });

  final Rect hole;
  final double radius;
  final Color scrim;

  /// Rotation phase (radians) for the sweeping gradient ring.
  final double glowAngle;

  /// 0..1 breathing phase for the glow's intensity.
  final double glowPulse;

  @override
  void paint(Canvas canvas, Size size) {
    final Path full = Path()..addRect(Offset.zero & size);
    if (hole.isEmpty) {
      canvas.drawPath(full, Paint()..color = scrim);
      return;
    }
    final RRect rrect = RRect.fromRectAndRadius(hole, Radius.circular(radius));
    final Path cut = Path()..addRRect(rrect);
    canvas.drawPath(
      Path.combine(PathOperation.difference, full, cut),
      Paint()..color = scrim,
    );

    // Soft blurred glow, same purple as the onboarding logo, breathing in
    // and out around the highlighted shape.
    final Path ring = Path()..addRRect(rrect);
    canvas.drawPath(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3 + 2 * glowPulse
        ..color = _kGlowColor.withValues(alpha: 0.5 + 0.3 * glowPulse)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 5 + 5 * glowPulse),
    );
    // Crisp rotating gradient ring on top, echoing the logo's sweep.
    canvas.drawPath(
      ring,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5
        ..shader = SweepGradient(
          transform: GradientRotation(glowAngle),
          colors: const <Color>[
            _kGlowColor,
            Color(0xFFB47FE0),
            Color(0xFFEBD1FA),
            _kGlowColor,
          ],
        ).createShader(hole.inflate(4)),
    );
  }

  @override
  bool shouldRepaint(_SpotlightPainter old) =>
      old.hole != hole ||
      old.radius != radius ||
      old.scrim != scrim ||
      old.glowAngle != glowAngle ||
      old.glowPulse != glowPulse;
}
