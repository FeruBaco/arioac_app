import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/widgets.dart';

class MainSemiCirle extends StatelessWidget {
  final double diameter;

  const MainSemiCirle({super.key, this.diameter = 180});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            painter: CirclePainter(),
            size: Size(diameter, diameter / 2),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 14),
            child: Image.asset(
              'images/asset_2.png',
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color.fromRGBO(7, 139, 122, 1),
          Color.fromRGBO(73, 71, 122, 1),
        ],
      ).createShader(
        Rect.fromLTRB(0, 0, size.width, size.height * 2),
      );
    canvas.drawArc(
        Rect.fromCenter(
            center: Offset(size.width / 2, 0),
            width: size.width,
            height: size.height * 2),
        0,
        math.pi,
        true,
        paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
