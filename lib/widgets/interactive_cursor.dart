import 'package:flutter/material.dart';

class InteractiveCursor extends StatefulWidget {
  final Widget child;

  const InteractiveCursor({Key? key, required this.child}) : super(key: key);

  @override
  State<InteractiveCursor> createState() => _InteractiveCursorState();
}

class _InteractiveCursorState extends State<InteractiveCursor> {
  Offset _mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.position;
        });
      },
      child: Stack(
        children: [
          widget.child,
          // The glowing orb following the cursor
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOutCubic,
            left: _mousePosition.dx - 150, // Center the 300px orb
            top: _mousePosition.dy - 150,
            child: IgnorePointer(
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.15),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
          ),
          // The tiny dot exactly on the cursor
          Positioned(
            left: _mousePosition.dx - 4, // Center the 8px dot
            top: _mousePosition.dy - 4,
            child: IgnorePointer(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
