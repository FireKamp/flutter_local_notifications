import 'package:meta/meta.dart';

@immutable
abstract class NotificationSettingEvent {}

class FetchNotificationData extends NotificationSettingEvent {}
