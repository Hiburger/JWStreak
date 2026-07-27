import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

/// Wraps [child] so tapping it [tapsToTrigger] times within [tapWindow] of
/// each other fires [onTriggered], with a little shake + haptic buzz on
/// every tap. The shared "secret gesture" behind every hidden delight in
/// the app (the settings heart, the streak flame, ...).
class TapEasterEgg extends StatefulWidget {
  const TapEasterEgg({
    required this.child,
    required this.onTriggered,
    this.tapsToTrigger = 8,
    this.tapWindow = const Duration(milliseconds: 1500),
    super.key,
  });

  final Widget child;
  final VoidCallback onTriggered;
  final int tapsToTrigger;
  final Duration tapWindow;

  @override
  State<TapEasterEgg> createState() => _TapEasterEggState();
}

class _TapEasterEggState extends State<TapEasterEgg>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );
  late final Animation<double> _shakeAnimation =
      TweenSequence<double>(<TweenSequenceItem<double>>[
        TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: -0.15), weight: 1),
        TweenSequenceItem<double>(tween: Tween<double>(begin: -0.15, end: 0.15), weight: 1),
        TweenSequenceItem<double>(tween: Tween<double>(begin: 0.15, end: -0.15), weight: 1),
        TweenSequenceItem<double>(tween: Tween<double>(begin: -0.15, end: 0.15), weight: 1),
        TweenSequenceItem<double>(tween: Tween<double>(begin: 0.15, end: 0), weight: 1),
      ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  int _tapCount = 0;
  DateTime? _lastTap;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onTap() async {
    _controller
      ..reset()
      ..forward();

    final bool hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator) {
      await Vibration.vibrate(duration: 50);
    }

    final DateTime now = DateTime.now();
    if (_lastTap == null || now.difference(_lastTap!) > widget.tapWindow) {
      _tapCount = 0;
    }
    _lastTap = now;
    _tapCount++;

    if (_tapCount >= widget.tapsToTrigger) {
      _tapCount = 0;
      _lastTap = null;
      widget.onTriggered();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(angle: _shakeAnimation.value, child: child);
        },
        child: widget.child,
      ),
    );
  }
}
