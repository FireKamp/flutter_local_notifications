import 'package:meta/meta.dart';

@immutable
abstract class NotificatioTimeSelectionState {}

class InitialNotificatioTimeSelectionState
    extends NotificatioTimeSelectionState {}

class NotiSettingSavedState extends NotificatioTimeSelectionState {}
