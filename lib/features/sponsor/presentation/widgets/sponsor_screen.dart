import 'package:arioac_app/features/shared/widgets/widgets.dart';
import 'package:arioac_app/features/sponsor/domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets.dart';

class SponsorScreen extends ConsumerStatefulWidget {
  final Sponsor sponsor;

  const SponsorScreen({super.key, required this.sponsor});

  @override
  SponsorScreenState createState() => SponsorScreenState();
}

class SponsorScreenState extends ConsumerState<SponsorScreen> {
  @override
  Widget build(BuildContext context) {
    final Sponsor sponsor = widget.sponsor;
    final size = MediaQuery.of(context).size;
    final topMargin = size.height / 5;

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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(top: topMargin / 5),
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6,
                          offset: Offset(0, 8),
                          color: Color.fromRGBO(38, 120, 135, 1),
                        )
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 110,
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: FadeInImage(
                          image: NetworkImage(sponsor.logo),
                          fit: BoxFit.scaleDown,
                          placeholderFit: BoxFit.scaleDown,
                          placeholder:
                              const AssetImage('images/placeholder.gif'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxHeight: 100, minHeight: 50, maxWidth: size.width),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  itemCount: sponsor.socialMedia.length,
                  itemBuilder: (BuildContext context, index) {
                    final socialMedia = sponsor.socialMedia[index];
                    return SponsorSocial(
                        url: socialMedia.url, platform: socialMedia.platform);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.topRight,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(10),
                  itemCount: sponsor.phones.length,
                  itemBuilder: (BuildContext context, index) {
                    final phone = sponsor.phones[index];
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () async {
                          final Uri url = Uri.parse('tel:$phone');
                          if (!await launchUrl(url)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.phone,
                              size: 35,
                            ),
                            Center(
                              child: Text(
                                phone,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                        color: Colors.black,
                                        letterSpacing: 1.5,
                                        fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
