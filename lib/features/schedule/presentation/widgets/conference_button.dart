import 'package:flutter/material.dart';

class ConferenceButton extends StatelessWidget {
  final String? text;
  final Size? size;
  final TextStyle? style;
  final Color? bColor;
  final Color? fColor;
  final Widget? child;
  final Function()? onPressed;

  const ConferenceButton(
      {super.key,
      this.text,
      this.size,
      this.style,
      this.bColor,
      this.fColor,
      this.child,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color.fromRGBO(76, 174, 116, 1);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            minimumSize: size,
            shape: const StadiumBorder(),
            backgroundColor: bColor ?? greenColor,
            foregroundColor: fColor ?? Colors.white,
          ),
          child: child),
    );
  }
}
