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
  bool isSoundsOn;
  bool isHapticsOn;
  bool isHideDuplicates;
  bool isMistakeLimit;
  bool isHighDuplicates;
  bool isNotiEnabled;
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
      this.selectedDays,
      this.isHighDuplicates,
      this.isHideDuplicates,
      this.isMistakeLimit,
      this.isHapticsOn,
      this.isSoundsOn,
      this.isNotiEnabled});
}
