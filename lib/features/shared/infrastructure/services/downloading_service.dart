import 'dart:io';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadingService {
  static const downloadingPortName = 'downloading';

  static Future<void> createDownloadTask(String url) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      int sdk = androidInfo.version.sdkInt;
      final storagePermission = await _permissionGranted(sdk);
      PermissionStatus status;
      if (!storagePermission) {
        if (sdk >= 33) {
          status = await Permission.manageExternalStorage.request();
        } else {
          status = await Permission.storage.request();
        }
        if (!status.isGranted) {
          return;
        }
      }
    }

    final path = await _getPath();

    if (path == null) {
      return;
    }

    final taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true,
      // click on notification to open downloaded file (for Android)
      saveInPublicStorage: true,
    );

    if (taskId != null) {
      await FlutterDownloader.open(taskId: taskId);
    }
  }

  static Future<bool> _permissionGranted(int sdk) async {
    if (Platform.isAndroid) {
      if (sdk >= 33) {
        return await Permission.manageExternalStorage.isGranted;
      } else {
        return await Permission.storage.isGranted;
      }
    }
    return await Permission.storage.isGranted;
  }

  static Future<String?> _getPath() async {
    if (Platform.isAndroid) {
      final externalDir = await getExternalStorageDirectory();
      return externalDir?.path;
    }

    return (await getApplicationDocumentsDirectory()).absolute.path;
  }

  static downloadingCallBack(id, status, progress) {
    final sendPort = IsolateNameServer.lookupPortByName(downloadingPortName);

    if (sendPort != null) {
      sendPort.send([id, status, progress]);
    } else {}
  }
}
