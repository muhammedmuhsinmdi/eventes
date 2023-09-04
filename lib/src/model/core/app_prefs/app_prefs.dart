import 'dart:developer';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static String? token = "";

  static Future<void> writeLocalCaches() async {
    if (Platform.isAndroid || Platform.isIOS) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token!);
    }
  }

  static Future<void> readLocalCaches() async {
    final prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid || Platform.isIOS) {
      if (prefs.getString('token') != null) {
        token = prefs.getString('token');
      }
    }
    log(token ?? 'No Token');
  }
}
