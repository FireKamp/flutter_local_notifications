import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {

  static Future<bool> requestPermissions() async {
    if (Platform.isIOS) {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();
      var result = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return result;
    } else {
      return true;
    }
  }
}
