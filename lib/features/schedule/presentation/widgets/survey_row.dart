import 'package:flutter/material.dart';

class SurveyRow extends StatelessWidget {
  final String? number;
  final String text;
  final Color? color;
  const SurveyRow({super.key, required this.text, this.number, this.color});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color.fromRGBO(111, 181, 132, 1);

    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color ?? greenColor,
          ),
          child: Center(
            child: Text(
              number ?? '',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            text,
            maxLines: 3,
            softWrap: true,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: color ?? Colors.black),
          ),
        )
      ],
    );
  }
}
