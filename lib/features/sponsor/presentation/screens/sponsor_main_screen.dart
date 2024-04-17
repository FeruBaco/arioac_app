
import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SponsorMainScreen extends StatefulWidget {
  final Function changeScreen;
  const SponsorMainScreen({super.key, required this.changeScreen});

  @override
  State<SponsorMainScreen> createState() => _SponsorMainScreenState();
}

class _SponsorMainScreenState extends State<SponsorMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.down,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PATROCINADORES',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ],
        ),
        SponsorsBanner(changeScreen: widget.changeScreen),
        const SponsorGrid()
      ],
    );
  }
}
