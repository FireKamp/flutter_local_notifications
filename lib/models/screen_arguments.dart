import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sudoku_brain/utils/Enums.dart';

class ScreenArguments {
  LevelTYPE levelTYPE;
  String levelName;
  String bestTime;
  int index;

  int hour;
  int min;
  int pausedLevelTime;
  bool isPlayed;
  bool isContinued;
  List<Day> selectedDays;

  ScreenArguments(
      {this.levelTYPE,
      this.levelName,
      this.index,
      this.hour,
      this.min,
      this.bestTime,
      this.isPlayed,
      this.isContinued,
      this.pausedLevelTime,
      this.selectedDays});
}
