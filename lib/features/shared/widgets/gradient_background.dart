import 'package:flutter/material.dart';

class GradientBackground {
  static BoxDecoration gradientBackground(Alignment begin, Alignment end) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: begin,
        end: end,
        colors: const [
          Color.fromRGBO(41, 140, 122, 1),
          Color.fromRGBO(94, 90, 156, 1)
        ],
      ),
    );
  }
}
