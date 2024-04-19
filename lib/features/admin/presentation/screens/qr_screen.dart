import 'package:arioac_app/features/auth/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/material.dart';

class QRScreen extends ConsumerStatefulWidget {
  const QRScreen({super.key});

  @override
  QRScreenState createState() => QRScreenState();
}

class QRScreenState extends ConsumerState<QRScreen> {
  List<Barcode> qrs = [];
  MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    autoStart: false,
  );
  bool onFocus = true;

  activeCamera() {
    setState(() {
      controller.start();
    });
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Focus(
        autofocus: true,
        onFocusChange: (focus) {
          (focus) ? controller.start() : controller.stop();
        },
        child: Stack(
          children: [
            MobileScanner(
                controller: controller,
                onDetect: (capture) async {
                  qrs = capture.barcodes;
                  String? qr = qrs[0].rawValue;
                  ref.read(authProvider.notifier).getUserById(qr!);
                  context.push('/admin_show_user');
                }),
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
