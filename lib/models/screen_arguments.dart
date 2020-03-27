import 'package:sudoku_brain/utils/Enums.dart';

class ScreenArguments {
  LevelTYPE levelTYPE;
  String levelName;
  String bestTime;
  int index;
  int pausedLevelTime;
  bool isPlayed;
  bool isContinued;

  ScreenArguments(
      {this.levelTYPE,
      this.levelName,
      this.index,
      this.bestTime,
      this.isPlayed,
      this.isContinued,
      this.pausedLevelTime});
}
