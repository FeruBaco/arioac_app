import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:arioac_app/features/profile/presentation/widgets/certificate_rectangle.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../../../shared/infrastructure/services/downloading_service.dart';
import '../../../shared/widgets/widgets.dart';

class ProfileBottomContent extends ConsumerStatefulWidget {
  const ProfileBottomContent({super.key});

  @override
  ProfileBottomContentState createState() => ProfileBottomContentState();
}

class ProfileBottomContentState extends ConsumerState<ProfileBottomContent> {
  final _receivePort = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _receivePort.sendPort, DownloadingService.downloadingPortName);
    FlutterDownloader.registerCallback(DownloadingService.downloadingCallBack);
    _receivePort.listen((message) {});
  }

  @override
  void dispose() {
    _receivePort.close();
    super.dispose();
  }

  void _downloadFile(String userId) async {
    try {
      final url = await ref.read(authProvider.notifier).getCertificate();
      if (url.length > 1) await DownloadingService.createDownloadTask(url);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authProvider).user!;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: CustomPaint(
        painter: CrossesBackground(),
        child: Container(
          padding: const EdgeInsets.all(60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  ref.read(authProvider).user?.userName ?? 'err: NO_NAME',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Flexible(
                flex: 3,
                child: QrImageView(
                    // size: 250,
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                    data: ref.read(authProvider).user?.id ?? 'err: NO_ID_CODE'),
              ),
              Flexible(
                flex: 1,
                child: GestureDetector(
                  child: const CertificateRectangle(),
                  onTap: () async {
                    _downloadFile(user.id);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
