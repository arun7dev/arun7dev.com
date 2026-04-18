import 'package:flutter/material.dart';

import '../main.dart';

class PerspectiveGrid extends StatefulWidget {
  final Widget child;
  final Color? opacityColor;

  const PerspectiveGrid({
    Key? key,
    required this.child,
    this.opacityColor,
  }) : super(key: key);

  @override
  State<PerspectiveGrid> createState() => _PerspectiveGridState();
}

class _PerspectiveGridState extends State<PerspectiveGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ValueListenableBuilder<String>(
            valueListenable: gridSymbolNotifier,
            builder: (context, symbol, _) {
              return AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  return CustomPaint(
                    painter: _PerspectiveGridPainter(
                      gridColor:
                          Theme.of(context).primaryColor.withOpacity(0.15),
                      animationValue: _controller.value,
                      symbol: symbol,
                    ),
                  );
                },
              );
            },
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _PerspectiveGridPainter extends CustomPainter {
  final Color gridColor;
  final double animationValue;
  final String symbol;

  _PerspectiveGridPainter({
    required this.gridColor,
    required this.animationValue,
    required this.symbol,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    final vanishingPoint = Offset(size.width / 2, size.height / 2);

    // 1. Draw the "back wall" shape
    final backWallSize = size * 0.4;
    _drawShape(
        canvas, vanishingPoint, backWallSize.width, backWallSize.height, paint);

    // 2. Draw lines from corners of screen to corners of back wall
    // (Only if it's a rectangle, otherwise it looks messy)
    if (symbol == 'rect') {
      final backWallRect = Rect.fromCenter(
        center: vanishingPoint,
        width: backWallSize.width,
        height: backWallSize.height,
      );
      canvas.drawLine(Offset.zero, backWallRect.topLeft, paint);
      canvas.drawLine(Offset(size.width, 0), backWallRect.topRight, paint);
      canvas.drawLine(Offset(0, size.height), backWallRect.bottomLeft, paint);
      canvas.drawLine(
          Offset(size.width, size.height), backWallRect.bottomRight, paint);
    }

    // 3. Draw depth lines (converging lines) - keep these simple for context
    const lineCount = 10;
    if (symbol == 'rect') {
      final backWallRect = Rect.fromCenter(
        center: vanishingPoint,
        width: backWallSize.width,
        height: backWallSize.height,
      );
      for (int i = 1; i < lineCount; i++) {
        double x = (size.width / lineCount) * i;
        canvas.drawLine(
            Offset(x, 0),
            Offset(backWallRect.left + (backWallRect.width / lineCount) * i,
                backWallRect.top),
            paint);
        canvas.drawLine(
            Offset(x, size.height),
            Offset(backWallRect.left + (backWallRect.width / lineCount) * i,
                backWallRect.bottom),
            paint);

        double y = (size.height / lineCount) * i;
        canvas.drawLine(
            Offset(0, y),
            Offset(backWallRect.left,
                backWallRect.top + (backWallRect.height / lineCount) * i),
            paint);
        canvas.drawLine(
            Offset(size.width, y),
            Offset(backWallRect.right,
                backWallRect.top + (backWallRect.height / lineCount) * i),
            paint);
      }
    }

    // 4. Draw cross-sections (the "rings" of the tunnel) with animation
    const rings = 12;
    for (int i = 0; i < rings; i++) {
      double t = (i / rings + (animationValue * (1 / rings))) % 1.0;
      double w = size.width + (backWallSize.width - size.width) * t;
      double h = size.height + (backWallSize.height - size.height) * t;

      paint.color = gridColor.withOpacity(gridColor.opacity * (1 - t));
      _drawShape(canvas, vanishingPoint, w, h, paint);
    }
  }

  void _drawShape(
      Canvas canvas, Offset center, double width, double height, Paint paint) {
    if (symbol == 'heart') {
      _drawHeart(canvas, center, width, height, paint);
    } else if (symbol == 'rect') {
      canvas.drawRect(
          Rect.fromCenter(center: center, width: width, height: height), paint);
    } else if (symbol == 'circle') {
      canvas.drawOval(
          Rect.fromCenter(center: center, width: width, height: height), paint);
    } else if (symbol == 'diamond') {
      _drawDiamond(canvas, center, width, height, paint);
    } else {
      // It's an emoji
      final textPainter = TextPainter(
        text: TextSpan(
          text: symbol,
          style: TextStyle(
            fontSize: height * 0.8,
            color: paint.color.withOpacity(paint.color.opacity * 0.5),
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(canvas,
          center - Offset(textPainter.width / 2, textPainter.height / 2));
    }
  }

  void _drawDiamond(Canvas canvas, Offset center, double width, double height, Paint paint) {
    final Path path = Path();
    path.moveTo(center.dx, center.dy - height / 2); // Top
    path.lineTo(center.dx + width / 2, center.dy); // Right
    path.lineTo(center.dx, center.dy + height / 2); // Bottom
    path.lineTo(center.dx - width / 2, center.dy); // Left
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawHeart(
      Canvas canvas, Offset center, double width, double height, Paint paint) {
    final Path path = Path();
    final double w = width * 0.8;
    final double h = height * 0.8;

    path.moveTo(center.dx, center.dy + h / 4);

    // Left side
    path.cubicTo(center.dx - w / 2, center.dy - h / 2, center.dx - w,
        center.dy + h / 4, center.dx, center.dy + h);

    // Right side
    path.cubicTo(center.dx + w, center.dy + h / 4, center.dx + w / 2,
        center.dy - h / 2, center.dx, center.dy + h / 4);

    // Adjust the heart to be centered better
    final rect = path.getBounds();
    final offset = center - rect.center;
    canvas.drawPath(path.shift(offset), paint);
  }

  @override
  bool shouldRepaint(covariant _PerspectiveGridPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.gridColor != gridColor ||
      oldDelegate.symbol != symbol;
}
