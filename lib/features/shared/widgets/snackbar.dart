import 'package:flutter/material.dart';

SnackBar AppSnackBar(
    {required String content,
    required BuildContext context,
    Color? backgroundColor}) {
  return SnackBar(
    content: Text(
      content,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
          ),
    ),
    backgroundColor: backgroundColor ?? Colors.green,
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    elevation: 200,
  );
}
