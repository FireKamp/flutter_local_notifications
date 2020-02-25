import 'package:sudoku_brain/utils/Enums.dart';

class BoardData {
  int value;
  PlayMode mode;
  List<int> pencilValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  BoardData({this.value, this.mode});
}
