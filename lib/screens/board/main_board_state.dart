import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:sudoku_brain/models/board_data.dart';
import 'package:sudoku_brain/models/row_col.dart';

@immutable
abstract class MainBoardState {}

class InitialMainBoardState extends MainBoardState {
  final String error;

  InitialMainBoardState({this.error});
}

class FetchingLevel extends MainBoardState {}

class PlayAgainState extends MainBoardState {}

class LevelFetched extends MainBoardState {
  final List<List<BoardData>> boardList;

  LevelFetched({this.boardList});
}

class InitStateFetched extends MainBoardState {
  final List<List<BoardData>> boardList;

  InitStateFetched({this.boardList});
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

class GameFinishedState extends MainBoardState {
  final bool isWon;
  final String time;

  GameFinishedState({this.isWon, this.time});
}

class CursorChangedState extends MainBoardState {
  final int val;

  CursorChangedState({this.val});
}

class UpdateCellState extends MainBoardState {
  final int val;

  UpdateCellState({this.val});
}

class FullScreenState extends MainBoardState {
  final bool isFull;

  FullScreenState({this.isFull});
}

class HintState extends MainBoardState {
  final bool isHintEnabled;

  HintState({this.isHintEnabled});
}

class PencilState extends MainBoardState {
  final bool isPencilEnabled;

  PencilState({this.isPencilEnabled});
}

class UpdateRowColState extends MainBoardState {
  final int row;
  final int col;

  UpdateRowColState({this.row, this.col});
}

class ResetState extends MainBoardState {
  final List<List<BoardData>> boardList;

  ResetState({this.boardList});
}

// ========================= TIMER ============================= //
class StartTimerState extends MainBoardState {}

class PauseTimerState extends MainBoardState {
  final bool isPaused;

  PauseTimerState({this.isPaused});
}

class RestartTimerState extends MainBoardState {}

class TimerTickState extends MainBoardState {
  final String tickValue;

  TimerTickState({this.tickValue});
}
