import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SponsorSocial extends StatelessWidget {
  final String url;
  final String platform;

  const SponsorSocial({super.key, required this.url, required this.platform});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final Uri browserUrl = Uri.parse(url);
        if (!await launchUrl(browserUrl)) {
          throw ('Error loading URL');
        }
      },
      child: CircleAvatar(
        radius: 25,
        backgroundColor: const Color.fromRGBO(38, 120, 135, 1),
        child: Center(child: _selectIcon(platform)),
      ),
    );
  }

  Icon _selectIcon(platform) {
    const double iconSize = 24;

    Icon selectedIcon = const Icon(
      FontAwesomeIcons.notdef,
      size: iconSize,
      color: Colors.white,
    );

    if (platform == 'twitter' || platform == 'x') {
      return const Icon(
        FontAwesomeIcons.xTwitter,
        size: iconSize,
        color: Colors.white,
      );
    }
    if (platform == 'facebook') {
      return const Icon(
        FontAwesomeIcons.facebookF,
        size: iconSize,
        color: Colors.white,
      );
    }
    if (platform == 'linkedin') {
      return const Icon(
        FontAwesomeIcons.linkedinIn,
        size: iconSize,
        color: Colors.white,
      );
    }
    if (platform == 'instagram') {
      return const Icon(
        FontAwesomeIcons.instagram,
        size: iconSize,
        color: Colors.white,
      );
    }
    if (platform == 'web') {
      return const Icon(
        FontAwesomeIcons.globe,
        size: iconSize,
        color: Colors.white,
      );
    }

    if (platform == 'youtube') {
      return const Icon(
        FontAwesomeIcons.youtube,
        size: iconSize,
        color: Colors.white,
      );
    }

    return selectedIcon;
  }
}
