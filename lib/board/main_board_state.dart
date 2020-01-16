import 'package:meta/meta.dart';

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
