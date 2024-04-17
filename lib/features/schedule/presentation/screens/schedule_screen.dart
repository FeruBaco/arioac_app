import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ScheduleScreen();
}

class _ScheduleScreen extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PROGRAMA',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'DÍA 1',
                  style: TextStyle(
                      backgroundColor: Color(0xFFF8F7F7),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Color.fromRGBO(85, 176, 106, 1)),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(bottom: 4),
        ),
        const Expanded(
          child: ScheduleList(),
        )
      ],
    );
  }
}
