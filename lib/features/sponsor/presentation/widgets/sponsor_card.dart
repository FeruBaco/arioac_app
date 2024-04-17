import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class SponsorCard extends StatelessWidget {
  final Sponsor sponsor;
  const SponsorCard({
    super.key,
    required this.sponsor,
  });

  @override
  Widget build(BuildContext context) {
    return _ImageViewer(
      image: sponsor.logo,
    );
  }
}

class _ImageViewer extends StatelessWidget {
  final String image;

  const _ImageViewer({required this.image});

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty || !image.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'images/no-image.jpg',
          fit: BoxFit.cover,
          height: 250,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: FadeInImage(
        image: NetworkImage(image),
        fadeInDuration: const Duration(milliseconds: 200),
        fadeOutDuration: const Duration(milliseconds: 100),
        fit: BoxFit.contain,
        placeholderFit: BoxFit.scaleDown,
        placeholder: const AssetImage('images/placeholder.gif'),
      ),
    );
  }
}
