import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter/material.dart';

class WaveBackground extends StatelessWidget {
  final Widget child;
  const WaveBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF298C7A),
                  Color.fromRGBO(94, 90, 156, 1),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: FloatingBubbles.alwaysRepeating(
              noOfBubbles: 35,
              colorsOfBubbles: const [
                Color.fromRGBO(39, 134, 120, 1),
                Color.fromRGBO(48, 132, 140, 1),
                Color.fromRGBO(69, 104, 150, 1),
                Color.fromRGBO(81, 95, 153, 1),
                Color.fromRGBO(97, 94, 156, 1)
              ],
              sizeFactor: .18,
              speed: BubbleSpeed.slow,
            ),
          ),
          Container(
            child: child,
          ),
        ],
      ),
    ));
  }
}
