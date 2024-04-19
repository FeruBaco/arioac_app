import 'package:arioac_app/features/shared/screens/screens.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SponsorQRScreen extends ConsumerStatefulWidget {
  const SponsorQRScreen({super.key});

  @override
  SponsorQRScreenState createState() => SponsorQRScreenState();
}

class SponsorQRScreenState extends ConsumerState<SponsorQRScreen> {
  List<Barcode> qrs = [];
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    autoStart: false,
  );

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (capture) async {
              qrs = capture.barcodes;
              String? qr = qrs[0].rawValue;
              ref.read(sponsorListProvider.notifier).addUserToList(qr!);
              context.pop();
            },
          ),
          Positioned(
            top: 60,
            left: 10,
            child: IconButton(
              onPressed: () {
                controller.dispose();
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
