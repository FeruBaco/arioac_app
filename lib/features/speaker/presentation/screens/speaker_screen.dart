import 'package:arioac_app/features/speaker/presentation/screens/screens.dart';
import 'package:flutter/material.dart';

class SpeakerScreen extends StatefulWidget {
  const SpeakerScreen({super.key});

  @override
  State<SpeakerScreen> createState() => _SpeakerScreenState();
}

class _SpeakerScreenState extends State<SpeakerScreen> {
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
      children: [QuestionsScreen(changeScreen: changeScreen)],
    );
  }
}
