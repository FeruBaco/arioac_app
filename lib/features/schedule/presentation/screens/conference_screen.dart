import 'package:arioac_app/features/schedule/presentation/widgets/conference_button_list.dart';
import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class ConferenceScreen extends ConsumerStatefulWidget {
  final Function changeScreen;
  final Conference conference;

  const ConferenceScreen({
    super.key,
    required this.changeScreen,
    required this.conference,
  });

  @override
  ConferenceScreenState createState() => ConferenceScreenState();
}

class ConferenceScreenState extends ConsumerState<ConferenceScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final speakers = widget.conference.speakers;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: size.height * .14),
              height: size.height - size.height * .14,
              child: CarouselSlider.builder(
                itemCount: speakers.length,
                options: CarouselOptions(
                  height: size.height,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: (speakers.length > 1) ? true : false,
                ),
                itemBuilder: (context, index, realIndex) {
                  final speaker = speakers[index];
                  return Column(
                    children: [
                      Flexible(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 90,
                              backgroundColor: Colors.transparent,
                              child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color.fromRGBO(84, 174, 105, 1),
                                      Color.fromRGBO(13, 106, 80, 1),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(speaker.photo),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        speaker.name,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        speaker.jobTitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Flexible(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Html(
                                data: speaker.semblance,
                                style: {
                                  "p": Style(
                                    fontSize: FontSize(15),
                                    textAlign: TextAlign.justify,
                                    fontFamily: GoogleFonts.arimo().toString(),
                                  )
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 80),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: ConferenceButtonList(
                conference: widget.conference,
                changeScreen: widget.changeScreen,
              ),
            ),
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
          ],
        ),
      ],
    );
  }
}
