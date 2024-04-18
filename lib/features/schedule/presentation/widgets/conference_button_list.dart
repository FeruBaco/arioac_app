import 'dart:ui';
import 'dart:isolate';
import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:arioac_app/features/shared/infrastructure/services/downloading_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class ConferenceButtonList extends StatefulWidget {
  final Conference conference;
  final Function changeScreen;
  const ConferenceButtonList({
    super.key,
    required this.conference,
    required this.changeScreen,
  });

  @override
  State<StatefulWidget> createState() => ConferenceButtonListState();
}

class ConferenceButtonListState extends State<ConferenceButtonList> {
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

  void _downloadFile(String materialURL) async {
    try {
      await DownloadingService.createDownloadTask(
        materialURL,
      );
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final conference = widget.conference;

    return Column(
      children: [
        ConferenceButton(
          onPressed: () async {
            widget.changeScreen(1);
          },
          size: Size(size.width * .8, 40),
          child: Text(
            'Realizar pregunta',
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
        if (conference.hasSurvey)
          ConferenceButton(
            onPressed: () {
              widget.changeScreen(2);
            },
            size: Size(size.width * .8, 40),
            child: Text(
              'Realizar encuesta',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
          ),
        if (conference.materialUrl.length > 1)
          ConferenceButton(
            onPressed: () async {
              _downloadFile(conference.materialUrl);
            },
            size: Size(size.width * .8, 40),
            bColor: const Color.fromRGBO(44, 95, 231, 1),
            child: Wrap(
              children: [
                Text(
                  'Descargar material',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.download)
              ],
            ),
          ),
        const Padding(padding: EdgeInsets.only(bottom: 30))
      ],
    );
  }
}
