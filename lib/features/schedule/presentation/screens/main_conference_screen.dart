import 'package:arioac_app/features/schedule/presentation/providers/conference_provider.dart';
import 'package:arioac_app/features/schedule/presentation/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MainConferenceScreen extends ConsumerStatefulWidget {
  final String conferenceId;
  const MainConferenceScreen({super.key, required this.conferenceId});

  @override
  MainConferenceScreenState createState() => MainConferenceScreenState();
}

class MainConferenceScreenState extends ConsumerState<MainConferenceScreen> {
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
      _pageController.jumpToPage(i);
      // _pageController.animateToPage(i,
      //     duration: const Duration(milliseconds: 500), curve: Curves.linear);
    });
  }

  @override
  Widget build(BuildContext context) {
    final conferenceState = ref.watch(conferenceProvider(widget.conferenceId));
    final conference = conferenceState.conference;
    final size = MediaQuery.of(context).size;
    final topMargin = size.height * .25;

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: topMargin),
          decoration: const BoxDecoration(
            shape: BoxShape.rectangle,
            color: Color.fromRGBO(240, 248, 248, 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child:
                CustomPaint(size: Size.infinite, painter: DottedBacgrkound()),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: Stack(
                children: [
                  // Transparent background
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: size.height * .25,
                      color: Colors.transparent,
                    ),
                  ),
                  Container(
                    child: conferenceState.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: [
                              ConferenceScreen(
                                changeScreen: changeScreen,
                                conference: conferenceState.conference!,
                              ),
                              QAScreen(
                                changeScreen: changeScreen,
                                conferenceId: conference!.id,
                              ),
                              SurveyScreen(
                                changeScreen: changeScreen,
                                conferenceId: conference.id,
                                conferenceTitle: conference.title,
                              ),
                              QuestionScreen(
                                changeScreen: changeScreen,
                                conferenceId: conference.id,
                              )
                            ],
                          ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
