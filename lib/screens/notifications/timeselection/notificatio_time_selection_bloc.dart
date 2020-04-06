import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sudoku_brain/models/received_notification.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';

final BehaviorSubject<ReceivedNotification> didReceiveLocalNotificationSubject =
    BehaviorSubject<ReceivedNotification>();

final BehaviorSubject<String> selectNotificationSubject =
    BehaviorSubject<String>();

class NotificationTimeSelectionBloc extends Bloc<NotificationTimeSelectionEvent,
    NotificatioTimeSelectionState> {
  @override
  NotificatioTimeSelectionState get initialState =>
      InitialNotificatioTimeSelectionState();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  NotificationAppLaunchDetails notificationAppLaunchDetails;

  @override
  Stream<NotificatioTimeSelectionState> mapEventToState(
    NotificationTimeSelectionEvent event,
  ) async* {
    if (event is InitNotification) {
      _initNotification();
    } else if (event is SaveNotificationData) {
      LocalDB.setInt(LocalDB.keyNotificationHour, event.hour);
      LocalDB.setInt(LocalDB.keyNotificationMinutes, event.min);

      List<Day> list = List.from(event.list);
      List<int> finalList = List();

      if (list.contains(Day.Everyday)) {
        finalList.add(list[0].value);
        _showDailyAtTime(event.hour, event.min, Day.Everyday);
      } else {
        for (int i = 0; i < list.length; i++) {
          finalList.add(list[i].value);

          _showDailyAtTime(event.hour, event.min, list[i]);
        }
      }
      List<String> stringsList = finalList.map((i) => i.toString()).toList();
      LocalDB.setList(LocalDB.keyNotificationRepList, stringsList);

      _showNotification();
      yield NotiSettingSavedState();
    }
  }

  void dispose() {
    didReceiveLocalNotificationSubject.close();
    selectNotificationSubject.close();
  }

  Future<void> _initNotification() async {
    WidgetsFlutterBinding.ensureInitialized();

    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification:
            (int id, String title, String body, String payload) async {
          didReceiveLocalNotificationSubject.add(ReceivedNotification(
              id: id, title: title, body: body, payload: payload));
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> _showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Sudoku Brain',
        'Your notification setting has been saved.', platformChannelSpecifics,
        payload: '');
  }

  Future<void> _showDailyAtTime(int hour, int min, Day day) async {
    var time = Time(hour, min, 0);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'id', 'SudokuBrainChannel', 'description',
        icon: 'secondary_icon',
        largeIcon: DrawableResourceAndroidBitmap('sample_large_icon'),
        enableLights: true,
        color: const Color.fromARGB(255, 255, 0, 0),
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500,
        importance: Importance.Max,
        priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    if (day == Day.Everyday) {
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          0,
          'Sudoku Brain Challange',
          'Can you solve a new puzzle today? Try it!',
          time,
          platformChannelSpecifics);
    } else {
      await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
          0,
          'Sudoku Brain Challange',
          'Can you solve this puzzle without hints?',
          day,
          time,
          platformChannelSpecifics);
    }
  }
}
