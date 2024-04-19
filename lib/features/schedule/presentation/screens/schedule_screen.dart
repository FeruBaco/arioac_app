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
    final Size size = MediaQuery.of(context).size;
    return const Column(
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(bottom: 4),
        // ),
        Expanded(
          child: ScheduleList(),
        )
      ],
    );
  }
}
