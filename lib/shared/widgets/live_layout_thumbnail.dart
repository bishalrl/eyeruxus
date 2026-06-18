import 'package:flutter/material.dart';

/// Mini grid preview for live seat layouts (1, 2, 4, 8, 16, …).
class LiveLayoutThumbnail extends StatelessWidget {
  const LiveLayoutThumbnail({
    super.key,
    required this.seats,
    this.size = 40,
    this.cellColor,
    this.borderColor,
  });

  final int seats;
  final double size;
  final Color? cellColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _GridLayoutPainter(
          seats: seats,
          cellColor: cellColor ?? Colors.white24,
          borderColor: borderColor ?? Colors.white70,
        ),
      ),
    );
  }
}

class _GridLayoutPainter extends CustomPainter {
  _GridLayoutPainter({
    required this.seats,
    required this.cellColor,
    required this.borderColor,
  });

  final int seats;
  final Color cellColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final fill = Paint()..color = cellColor;

    void drawCell(Rect rect) {
      canvas.drawRect(rect, fill);
      canvas.drawRect(rect, stroke);
    }

    final w = size.width;
    final h = size.height;

    if (seats <= 1) {
      drawCell(Rect.fromLTWH(0, 0, w, h));
      return;
    }
    if (seats == 2) {
      drawCell(Rect.fromLTWH(0, 0, w * 0.48, h));
      drawCell(Rect.fromLTWH(w * 0.52, 0, w * 0.48, h));
      return;
    }
    if (seats == 3) {
      drawCell(Rect.fromLTWH(0, 0, w, h * 0.48));
      drawCell(Rect.fromLTWH(0, h * 0.52, w * 0.48, h * 0.48));
      drawCell(Rect.fromLTWH(w * 0.52, h * 0.52, w * 0.48, h * 0.48));
      return;
    }

    final cols = seats <= 4 ? 2 : 4;
    final rows = (seats / cols).ceil();
    final cw = w / cols - 2;
    final ch = h / rows - 2;
    var drawn = 0;
    for (var row = 0; row < rows && drawn < seats; row++) {
      for (var col = 0; col < cols && drawn < seats; col++) {
        drawCell(Rect.fromLTWH(col * (cw + 2), row * (ch + 2), cw, ch));
        drawn++;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridLayoutPainter oldDelegate) =>
      oldDelegate.seats != seats;
}
