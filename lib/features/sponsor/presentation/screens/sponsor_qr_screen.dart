import 'package:arioac_app/features/shared/screens/screens.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SpeakerQRScreen extends ConsumerStatefulWidget {
  const SpeakerQRScreen({super.key});

  @override
  SpeakerQRScreenState createState() => SpeakerQRScreenState();
}

class SpeakerQRScreenState extends ConsumerState<SpeakerQRScreen> {
  bool isDetected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // QRScanner(
        //   onChanged: (cameraController) {
        //     cameraController.scannedDataStream.listen((scanData) async {
        //       isDetected = true;
        //       await cameraController.pauseCamera();
        //       String? code = scanData.code;

        //       if (code != null && isDetected) {
        //         if (context.mounted) {
        //           ref.read(sponsorListProvider.notifier).addUser(code);
        //           context.pop();
        // showModalBottomSheet(
        //   isScrollControlled: true,
        //   context: context,
        //   builder: (BuildContext context) {
        //     return const FractionallySizedBox(
        //       heightFactor: 0.7,
        //       child: UserShowScreen(),
        //     );
        //   },
        // ).whenComplete(() {
        //   cameraController.resumeCamera();
        //   isDetected = false;
        // });
        // }
        // }
        // });
        // },
        // ),
      ],
    );
  }
}
