import 'package:flutter/material.dart';

/// A single line of text that scrolls back and forth to reveal what
/// doesn't fit — only when it doesn't fit.
///
/// Built for the home banner's rotating greeting ("Good afternoon", "Happy
/// reading", …): some of the greeting variants, in some languages, at some
/// system font-size settings, run wider than the banner has room for, and an
/// ellipsis quietly throws away the part that made it worth greeting the
/// reader at all. Most of the time none of that applies and the text just
/// sits still like a normal [Text] — the animation only exists for the
/// specific case that needed it.
class MarqueeText extends StatefulWidget {
  const MarqueeText({
    required this.text,
    this.style,
    this.pauseDuration = const Duration(milliseconds: 1200),
    this.pixelsPerSecond = 32,
    super.key,
  });

  final String text;
  final TextStyle? style;

  /// How long to sit still at each end before scrolling to the other —
  /// long enough to actually read the visible half before it moves.
  final Duration pauseDuration;

  /// Scroll speed. Distance-based rather than a fixed duration so a barely
  /// -overflowing greeting doesn't crawl for as long as a badly overflowing
  /// one.
  final double pixelsPerSecond;

  @override
  State<MarqueeText> createState() => _MarqueeTextState();
}

class _MarqueeTextState extends State<MarqueeText>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _offset;

  double? _textWidth;
  double? _availableWidth;

  @override
  void didUpdateWidget(covariant MarqueeText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text || oldWidget.style != widget.style) {
      // Clears any in-flight animation synchronously, so a loop built for
      // the old text never paints — even for a single frame — against the
      // new one. Nulling _textWidth forces build() to remeasure and, since
      // that counts as "just measured", schedule a fresh _rebuild() for
      // whatever the new text actually needs (nothing, if it now fits).
      _controller?.dispose();
      _controller = null;
      _offset = null;
      _textWidth = null;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  double _measure(BuildContext context) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: widget.text, style: widget.style),
      textDirection: Directionality.of(context),
      maxLines: 1,
    )..layout();
    return painter.width;
  }

  /// (Re)builds the animation for the current text/available-width pair, or
  /// tears it down if the text fits after all (e.g. the greeting changed to
  /// a shorter variant, or the window grew).
  void _rebuild() {
    final double? textWidth = _textWidth;
    final double? availableWidth = _availableWidth;
    if (textWidth == null || availableWidth == null) {
      return;
    }

    _controller?.dispose();
    _controller = null;
    _offset = null;

    final double overflow = textWidth - availableWidth;
    if (overflow <= 0.5) {
      if (mounted) {
        setState(() {});
      }
      return;
    }

    final int scrollMs = (overflow / widget.pixelsPerSecond * 1000)
        .round()
        .clamp(400, 20000);
    final int pauseMs = widget.pauseDuration.inMilliseconds;
    final AnimationController controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: pauseMs * 2 + scrollMs * 2),
    );
    final Animation<double> offset = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        // Hold at the start — long enough to read the visible part before
        // it starts moving.
        TweenSequenceItem(
          tween: ConstantTween<double>(0),
          weight: pauseMs.toDouble(),
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: 0,
            end: overflow,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: scrollMs.toDouble(),
        ),
        // Hold at the end so the tail isn't just glimpsed mid-scroll.
        TweenSequenceItem(
          tween: ConstantTween<double>(overflow),
          weight: pauseMs.toDouble(),
        ),
        TweenSequenceItem(
          tween: Tween<double>(
            begin: overflow,
            end: 0,
          ).chain(CurveTween(curve: Curves.easeInOut)),
          weight: scrollMs.toDouble(),
        ),
      ],
    ).animate(controller);
    controller.repeat();

    if (mounted) {
      setState(() {
        _controller = controller;
        _offset = offset;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool justMeasured = _textWidth == null;
        _textWidth ??= _measure(context);
        final double availableWidth = constraints.maxWidth;
        // A half-pixel tolerance so ordinary layout-rounding jitter between
        // rebuilds doesn't restart an already-running loop from scratch.
        final bool widthChanged =
            _availableWidth == null ||
            (_availableWidth! - availableWidth).abs() > 0.5;
        if (justMeasured || widthChanged) {
          _availableWidth = availableWidth;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              _rebuild();
            }
          });
        }

        final Animation<double>? offset = _offset;
        if (offset == null) {
          // Either it fits, or the animation hasn't spun up for this frame
          // yet — either way, a plain clipped line is always a safe thing
          // to show, never a frame of raw overflow.
          return Text(
            widget.text,
            style: widget.style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }

        return ClipRect(
          child: AnimatedBuilder(
            key: const Key('marqueeAnimatedBuilder'),
            animation: offset,
            builder: (BuildContext context, Widget? child) =>
                Transform.translate(
                  key: const Key('marqueeTransform'),
                  offset: Offset(-offset.value, 0),
                  child: child,
                ),
            child: SizedBox(
              width: _textWidth,
              child: Text(
                widget.text,
                style: widget.style,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        );
      },
    );
  }
}
