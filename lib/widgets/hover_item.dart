import 'package:flutter/material.dart';

class HoverItem extends StatefulWidget {
  final Widget child;
  final double scale;
  final Offset translate;
  final Duration duration;

  const HoverItem({
    Key? key,
    required this.child,
    this.scale = 1.05,
    this.translate = const Offset(0, -5),
    this.duration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  State<HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<HoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: widget.duration,
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(_isHovered ? widget.translate.dx : 0.0, _isHovered ? widget.translate.dy : 0.0)
          ..scale(_isHovered ? widget.scale : 1.0),
        child: widget.child,
      ),
    );
  }
}
