import 'package:arioac_app/features/sponsor/presentation/screens/sponsor_main_screen.dart';
import 'package:arioac_app/features/sponsor/presentation/screens/winners_screen.dart';
import 'package:flutter/material.dart';

class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SponsorsScreen();
}

class _SponsorsScreen extends State<SponsorsScreen> {
  PageController _pageController = PageController();

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changeScreen(int i) {
    setState(() {
      _pageController.animateToPage(i,
          duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        SponsorMainScreen(changeScreen: changeScreen),
        WinnersScreen(
          changeScreen: changeScreen,
        )
      ],
    );
  }
}
