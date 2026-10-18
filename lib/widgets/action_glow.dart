import 'dart:math' as math;
import 'package:flutter/material.dart';

class ActionGlow extends StatefulWidget {
  const ActionGlow({
    required this.child,
    required this.borderRadius,
    this.enabled = true,
    this.color,
    super.key,
  });

  final Widget child;

  /// ring and glow color
  final Color? color;

  final BorderRadius borderRadius;

  final bool enabled;

  @override
  State<ActionGlow> createState() => _ActionGlowState();
}

class _ActionGlowState extends State<ActionGlow>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    if (widget.enabled) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant ActionGlow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled == oldWidget.enabled) {
      return;
    }
    // Stopped rather than torn down: the glow can move between widgets as
    // the state around it changes, and back again.
    widget.enabled ? _controller.repeat() : _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }
    final Color base = widget.color ?? Theme.of(context).colorScheme.primary;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        final double angle = _controller.value * 2 * math.pi;
        final double pulse =
            0.5 + 0.5 * math.sin(_controller.value * 2 * math.pi);
        return Container(
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: SweepGradient(
              transform: GradientRotation(angle),
              colors: <Color>[
                base,
                base.withValues(alpha: 0.35),
                base.withValues(alpha: 0.75),
                base,
              ],
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: base.withValues(alpha: 0.30 + 0.25 * pulse),
                blurRadius: 10 + 8 * pulse,
                spreadRadius: 0.5 + 1.5 * pulse,
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
