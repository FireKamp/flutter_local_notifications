import 'package:meta/meta.dart';

@immutable
abstract class LevelSelectionState {}

class InitialLevelSelectionState extends LevelSelectionState {}

class LevelListState extends LevelSelectionState {
  List levelList;

  LevelListState({this.levelList});
}
