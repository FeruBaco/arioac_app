import 'package:flutter/material.dart';

// class AppSnackBar extends StatelessWidget {
//   final Widget content;
//   const AppSnackBar({
//     super.key,
//     required this.content,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SnackBar(
//       content: content,
//       backgroundColor: Colors.green,
//       elevation: 10,
//     );
//   }
// }

SnackBar AppSnackBar({required String content, required BuildContext context}) {
  return SnackBar(
    content: Text(
      content,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: Colors.white,
          ),
    ),
    backgroundColor: Colors.green,
    elevation: 10,
    duration: const Duration(seconds: 5),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  );
}
