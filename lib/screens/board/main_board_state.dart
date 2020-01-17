import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../Board.dart';

@immutable
abstract class MainBoardState {}

class InitialMainBoardState extends MainBoardState {
  final String error;

  InitialMainBoardState({this.error});
}

class FetchingLevel extends MainBoardState {}

class LevelFetched extends MainBoardState {
  final List<List<int>> boardList;

  LevelFetched({this.boardList});
}

class SolutionFetched extends MainBoardState {}

class ErrorFetched extends MainBoardState {
  final String error;

  ErrorFetched({this.error});
}

class ConflictsChanged extends MainBoardState {
  final HashSet<RowCol> conflicts;

  ConflictsChanged({this.conflicts});
}

class CursorChangedState extends MainBoardState {
  final int val;

  CursorChangedState({this.val});
}

class UpdateCellState extends MainBoardState {
  final int val;

  UpdateCellState({this.val});
}

class UpdateRowColState extends MainBoardState {
  final int row;
  final int col;

  UpdateRowColState({this.row, this.col});
}

// ========================= TIMER ============================= //
class StartTimerState extends MainBoardState {}

class PauseTimerState extends MainBoardState {}

class RestartTimerState extends MainBoardState {}

class TimerTickState extends MainBoardState {
  final String tickValue;

  TimerTickState({this.tickValue});
}
