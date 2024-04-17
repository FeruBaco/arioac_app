import 'package:flutter/material.dart';

class DottedBacgrkound extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromRGBO(230, 243, 242, 1) // Color of the dots
      ..style = PaintingStyle.fill;

    const double dotSpacing = 23.0; // Spacing between dots
    const double minDotRadius = 6.0; // Minimum radius of each dot
    const double maxDotRadius = 2.0; // Maximum radius of each dot
    final double maxOffsetY = size.height; // Maximum offset in y-direction

    for (double x = 0; x < size.width; x += dotSpacing) {
      for (double y = 0; y < size.height; y += dotSpacing) {
        double offsetYFactor =
            (y / maxOffsetY).clamp(0.0, 1.0); // Normalize y-coordinate
        double dotRadius =
            minDotRadius + (maxDotRadius - minDotRadius) * offsetYFactor;
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
