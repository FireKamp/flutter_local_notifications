import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sudoku_brain/models/board_data.dart';

@immutable
abstract class MainBoardEvent {}

class BoardInitISCalled extends MainBoardEvent {
  final BuildContext context;

  BoardInitISCalled({this.context});
}

class ChangeConflictsCalled extends MainBoardEvent {
  final List<List<BoardData>> list;

  ChangeConflictsCalled({this.list});
}

class CursorChanged extends MainBoardEvent {
  final int val;

  CursorChanged({this.val});
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

class ResetBoard extends MainBoardEvent {
  final List<List<BoardData>> list;
  final BuildContext buildContext;


  ResetBoard({this.list,this.buildContext});
}

class FullScreen extends MainBoardEvent {}

//================================== TIMER =========================================//
class StartTimer extends MainBoardEvent {}

class PauseTimer extends MainBoardEvent {}

class RestartTimer extends MainBoardEvent {}

class TimerTick extends MainBoardEvent {
  final int tickValue;

  TimerTick({this.tickValue});
}
