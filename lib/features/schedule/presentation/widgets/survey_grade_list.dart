import 'package:flutter/material.dart';

class SurveyGradeList extends StatelessWidget {
  final String? groupValue;
  final Function(String?) onChanged;
  const SurveyGradeList(
      {super.key, required this.groupValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const greenColor = Color.fromRGBO(111, 181, 132, 1);

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        RadioListTile(
          title: const Text("Excelente 🤩"),
          value: "excelent",
          groupValue: groupValue,
          activeColor: greenColor,
          onChanged: onChanged,
        ),
        RadioListTile(
          title: const Text("Buena 😊"),
          value: "good",
          groupValue: groupValue,
          activeColor: greenColor,
          onChanged: onChanged,
        ),
        RadioListTile(
          title: const Text("Regular 😐"),
          value: "regular",
          groupValue: groupValue,
          activeColor: greenColor,
          onChanged: onChanged,
        ),
        RadioListTile(
          title: const Text("Mala 🙃"),
          value: "bad",
          groupValue: groupValue,
          activeColor: greenColor,
          onChanged: onChanged,
        )
      ],
    );
  }
}
