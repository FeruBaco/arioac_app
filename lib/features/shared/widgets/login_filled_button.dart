import 'package:flutter/material.dart';

class LoginFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final double? width;

  const LoginFilledButton({super.key, this.onPressed, this.width});

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(10);

    final style = FilledButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      backgroundColor: Colors.white,
      foregroundColor: const Color.fromRGBO(62, 98, 124, 1),
      shape:
          const RoundedRectangleBorder(borderRadius: BorderRadius.all(radius)),
    );

    return ButtonTheme(
        child: FilledButton(
            style: style, onPressed: onPressed, child: const Text('Ingresar')));
  }
}
