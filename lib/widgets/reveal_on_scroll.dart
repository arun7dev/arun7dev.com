import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final String id;
  final Duration delay;
  final double slideOffset;
  final double slideOffsetHorizontal;
  final Curve curve;
  final Duration duration;

  const RevealOnScroll({
    Key? key,
    required this.child,
    required this.id,
    this.delay = Duration.zero,
    this.slideOffset = 30.0,
    this.slideOffsetHorizontal = 0.0,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 700),
  }) : super(key: key);

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.id),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.05 && !_isVisible) {
          if (mounted) {
            setState(() => _isVisible = true);
          }
        }
      },
      child: widget.child
          .animate(target: _isVisible ? 1 : 0)
          .fadeIn(duration: widget.duration, delay: widget.delay, curve: widget.curve)
          .move(
            begin: Offset(widget.slideOffsetHorizontal, widget.slideOffset),
            end: Offset.zero,
            duration: widget.duration,
            delay: widget.delay,
            curve: widget.curve,
          ),
    );
  }
}
