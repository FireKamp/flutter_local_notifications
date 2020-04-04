import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationTimeSelectionEvent {}

class InitNotification extends NotificationTimeSelectionEvent {}

class SaveNotificationData extends NotificationTimeSelectionEvent {
  final int hour;
  final int min;
  final List<Day> list;

  SaveNotificationData({this.hour, this.min, this.list});
}
