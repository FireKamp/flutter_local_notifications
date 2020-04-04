import 'package:meta/meta.dart';

@immutable
abstract class NotidayselectionState {}

class InitialNotidayselectionState extends NotidayselectionState {}

class NotidayselectedListState extends NotidayselectionState {
  final List<int> list;

  NotidayselectedListState({this.list});
}

class EverydayState extends NotidayselectionState {
  final bool value;

  EverydayState({this.value});
}
