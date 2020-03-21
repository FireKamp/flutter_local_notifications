import 'package:meta/meta.dart';

@immutable
abstract class LevelSelectionState {}

class InitialLevelSelectionState extends LevelSelectionState {}

class LevelListState extends LevelSelectionState {
  List<bool> levelList;

  LevelListState({this.levelList});
}
