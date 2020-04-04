import 'package:meta/meta.dart';

@immutable
abstract class NotificationSettingState {}

class InitialNotificationSettingState extends NotificationSettingState {}

class NotificationDataState extends NotificationSettingState {
  final bool isAllowed;
  final int hour;
  final int min;

  NotificationDataState({this.isAllowed, this.hour, this.min});
}
