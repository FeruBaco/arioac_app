import 'package:flutter/material.dart';

class CrossesBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double crossSize = 20.0; // Adjust the size of the cross
    const double spacing = 45.0; // Adjust the spacing between crosses

    final Paint paint = Paint()
      ..color = Colors.grey.shade200
      ..strokeWidth = 4.0;

    // Draw crosses
    for (double x = 26; x < size.width; x += spacing) {
      for (double y = 20; y < size.height; y += spacing) {
        canvas.drawLine(
            Offset(x - crossSize / 2, y), Offset(x + crossSize / 2, y), paint);
        canvas.drawLine(
            Offset(x, y - crossSize / 2), Offset(x, y + crossSize / 2), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
