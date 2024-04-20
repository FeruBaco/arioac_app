import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: '.env');
    } else {
      await dotenv.load(fileName: '.env.dev');
    }
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'Missing API_URL variable';
}
