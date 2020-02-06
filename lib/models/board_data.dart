import 'package:sudoku_brain/utils/Constants.dart';

class BoardData {
  int value;
  PlayMode mode;
  List pencilValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  BoardData({this.value, this.mode});
}
