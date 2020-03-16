import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sudoku_brain/models/board_data.dart';

@immutable
abstract class MainBoardEvent {}

class BoardInitISCalled extends MainBoardEvent {
  final BuildContext context;
  final String levelName;
  final int index;

  BoardInitISCalled(
      {@required this.context, @required this.levelName, @required this.index});
}

class ChangeConflictsCalled extends MainBoardEvent {
  final List<List<BoardData>> list;

  ChangeConflictsCalled({this.list});
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

  UpdateCellValue({this.val});
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
  final String levelName;
  final int index;

  Hint(
      {this.row,
      this.col,
      this.levelDetails,
      this.isPencilMode,
      this.levelName,
      this.index});
}

class ResetBoard extends MainBoardEvent {
  final List<List<BoardData>> list;
  final BuildContext buildContext;
  final int index;
  final String levelName;

  ResetBoard({this.list, this.buildContext, this.index, this.levelName});
}

class FullScreen extends MainBoardEvent {}

class PlayAgain extends MainBoardEvent {}

//================================== TIMER =========================================//
class StartTimer extends MainBoardEvent {}

class PauseTimer extends MainBoardEvent {}

class RestartTimer extends MainBoardEvent {}

class TimerTick extends MainBoardEvent {
  final int tickValue;

  TimerTick({this.tickValue});
}
