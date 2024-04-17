import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SponsorsBanner extends StatelessWidget {
  final Function changeScreen;
  const SponsorsBanner({super.key, required this.changeScreen});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeScreen(1);
      },
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black54.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 10),
            )
          ],
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(237, 176, 42, 1),
              Color.fromRGBO(223, 141, 41, 1)
            ],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RichText(
                    maxLines: 2,
                    textAlign: TextAlign.justify,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                      text: 'PREMIOS DE ',
                      children: [
                        TextSpan(
                            text: 'PATROCINADORES \n',
                            style: TextStyle(color: Colors.red)),
                        TextSpan(
                            text: 'VERIFICA SI FUISTE SELECCIONADO',
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_outlined,
                    weight: 500,
                    size: 34,
                  )
                ],
              ),
            ),
            Positioned(
              right: -50,
              top: -26,
              child: Transform(
                transform: Matrix4.rotationZ(pi / 7),
                child: SvgPicture.asset(
                  'images/gift.svg',
                  colorFilter: const ColorFilter.mode(
                    Color.fromRGBO(251, 193, 19, .8),
                    BlendMode.srcIn,
                  ),
                  width: 110,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
