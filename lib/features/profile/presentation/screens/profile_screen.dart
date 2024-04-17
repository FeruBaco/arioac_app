import 'package:arioac_app/features/profile/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  final BuildContext scaffoldContext;
  const ProfileScreen({super.key, required this.scaffoldContext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientBackground.gradientBackground(
          Alignment.centerLeft, Alignment.centerRight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: ProfileTopContent(scaffoldContext: scaffoldContext),
          ),
          const Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: ProfileBottomContent(),
          )
        ],
      ),
    );
  }
}
