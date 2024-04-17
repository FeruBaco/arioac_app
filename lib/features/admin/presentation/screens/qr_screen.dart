import 'package:arioac_app/features/admin/presentation/screens/user_show_screen.dart';
import 'package:arioac_app/features/auth/presentation/providers/providers.dart';
import 'package:arioac_app/features/shared/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QRScreen extends ConsumerStatefulWidget {
  const QRScreen({super.key});

  @override
  QRScreenState createState() => QRScreenState();
}

class QRScreenState extends ConsumerState<QRScreen> {
  bool isDetected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QRScanner(
          onChanged: (cameraController) {
            cameraController.scannedDataStream.listen((scanData) async {
              isDetected = true;
              await cameraController.pauseCamera();
              String? code = scanData.code;

              if (code != null && isDetected) {
                if (context.mounted) {
                  ref.watch(authProvider.notifier).getUserById(code);
                  // print('AAA $userState');
                  // print('${userState}');
                  // (userState.isUserCheckLoading) ? print('p12') : print('p13');

                  showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (BuildContext context) {
                      return const FractionallySizedBox(
                        heightFactor: 0.7,
                        child: UserShowScreen(),
                      );
                    },
                  ).whenComplete(() {
                    cameraController.resumeCamera();
                    isDetected = false;
                  });
                }
              }
            });
          },
        ),
      ],
    );
  }
}
