import 'package:meta/meta.dart';
import 'package:sudoku_brain/utils/Enums.dart';

@immutable
abstract class LevelEvent {}

class LevelSelected extends LevelEvent {
  final LevelTYPE levelTYPE;

  LevelSelected({this.levelTYPE});
}
