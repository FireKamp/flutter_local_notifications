import 'package:sudoku_brain/utils/Enums.dart';

class ScreenArguments {
  LevelTYPE levelTYPE;
  String levelName;
  String bestTime;
  int index;
  bool isPlayed;

  ScreenArguments({this.levelTYPE, this.levelName, this.index, this.bestTime,this.isPlayed});
}
