import 'package:meta/meta.dart';

@immutable
abstract class NotidayselectionEvent {}

class GetSelectedDays extends NotidayselectionEvent {}

class EverydayClicked extends NotidayselectionEvent {
  final bool isEnabled;

  EverydayClicked({this.isEnabled});
}
