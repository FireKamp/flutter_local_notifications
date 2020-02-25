import 'package:meta/meta.dart';
import 'package:sudoku_brain/utils/Enums.dart';

@immutable
abstract class LevelState {}

class InitialLevelState extends LevelState {}

class SelectedLevelState extends LevelState {
  final LevelTYPE levelTYPE;

  SelectedLevelState({this.levelTYPE});
}
