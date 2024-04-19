import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class CertificateRectangle extends StatelessWidget {
  const CertificateRectangle({super.key});

  final Color blueAccent = const Color.fromRGBO(44, 95, 231, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 80,
      color: const Color.fromRGBO(
          198, 213, 243, 1), // Blue background with 50% opacity
      child: CustomPaint(
        painter: DashedRectPainter(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: SvgPicture.asset(
                  'images/certificate.svg',
                  colorFilter: ColorFilter.mode(
                    blueAccent,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    'DESCARGAR \n RECONOCIMIENTO',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: blueAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashedRectPainter extends CustomPainter {
  final Color? color;
  final double strokeWidth;
  final double dashLength;
  final double dashSpace;
  final double borderRadius;

  DashedRectPainter({
    this.color,
    this.strokeWidth = 2.0,
    this.dashLength = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color.fromRGBO(44, 95, 231, 1)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Path path = Path();

    // Draw top side with rounded corners
    path.moveTo(borderRadius, 0);
    for (double i = 0;
        i < size.width - borderRadius * 2;
        i += dashLength + dashSpace) {
      path.moveTo(i, 0);
      path.lineTo(i + dashLength, 0);
    }
    path.lineTo(size.width - borderRadius * 2, 0);

    // Draw right side with rounded corners
    path.moveTo(size.width, borderRadius);
    // path.lineTo(size.width, size.height - borderRadius);
    for (double i = 0;
        i < size.height - borderRadius * 2;
        i += dashLength + dashSpace) {
      path.moveTo(size.width, i + borderRadius);
      path.lineTo(size.width, i + borderRadius + dashLength);
    }

    // // Draw bottom side with rounded corners
    path.moveTo(size.width - borderRadius, size.height);
    // path.lineTo(borderRadius, size.height);
    for (double i = size.width;
        i > borderRadius * 2;
        i -= dashLength + dashSpace) {
      path.moveTo(i - borderRadius, size.height);
      path.lineTo(i - borderRadius - dashLength, size.height);
    }

    // // Draw left side with rounded corners
    path.moveTo(0, size.height - borderRadius);
    // path.lineTo(0, borderRadius);
    for (double i = size.height;
        i > borderRadius * 2;
        i -= dashLength + dashSpace) {
      path.moveTo(0, i - borderRadius);
      path.lineTo(0, i - borderRadius - dashLength);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
