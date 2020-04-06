import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sudoku_brain/models/board_data.dart';

@immutable
abstract class MainBoardEvent {}

class BoardInitISCalled extends MainBoardEvent {
  final BuildContext context;
  final String levelName;
  final int index;
  final int pausedLevelTime;
  final bool isContinued;

  BoardInitISCalled(
      {@required this.context,
      @required this.levelName,
      @required this.index,
      this.pausedLevelTime,
      this.isContinued});
}

class ChangeConflictsCalled extends MainBoardEvent {
  final List<List<BoardData>> list;
  final bool isContinued;

  ChangeConflictsCalled({this.list, this.isContinued});
}

class CursorChanged extends MainBoardEvent {
  final int val;

  CursorChanged({this.val});
}

class GetHintCount extends MainBoardEvent {
  final int val;

  GetHintCount({this.val});
}

class PencilMode extends MainBoardEvent {
  final bool isPencilMode;

  PencilMode({this.isPencilMode});
}

class UpdateCellValue extends MainBoardEvent {
  final int val;
  final int row;
  final int col;
  final bool isPencilMode;

  UpdateCellValue({this.val, this.row, this.col,this.isPencilMode});
}

class UpdateRowCol extends MainBoardEvent {
  final int row;
  final int col;
  final List<List<BoardData>> list;

  UpdateRowCol({this.row, this.col, this.list});
}

class Hint extends MainBoardEvent {
  final int row;
  final int col;
  final levelDetails;
  final bool isPencilMode;
  final bool isForFailedAd;
  final String levelName;
  final int index;

  Hint(
      {this.row,
      this.col,
      this.levelDetails,
      this.isPencilMode,
      this.levelName,
      this.index,
      this.isForFailedAd});
}

class ResetBoard extends MainBoardEvent {
  final List<List<BoardData>> list;
  final BuildContext buildContext;
  final int index;
  final String levelName;

  ResetBoard({this.list, this.buildContext, this.index, this.levelName});
}

class FullScreen extends MainBoardEvent {}
class ConflictEvent extends MainBoardEvent {}

class AdRewarded extends MainBoardEvent {
  final int index;
  final String levelName;

  AdRewarded({this.levelName, this.index});
}

class PlayAgain extends MainBoardEvent {}

//================================== TIMER =========================================//
class StartTimer extends MainBoardEvent {}

class PauseTimer extends MainBoardEvent {
  final bool isPausedForAd;

  PauseTimer({this.isPausedForAd});
}

class RestartTimer extends MainBoardEvent {}

class TimerTick extends MainBoardEvent {
  final int tickValue;

  TimerTick({this.tickValue});
}
