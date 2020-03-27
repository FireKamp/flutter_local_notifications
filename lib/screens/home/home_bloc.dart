import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchPauseBoard) {
      var isBoardPaused = await _checkIsGamePaused();
      var levelName = await _getLevelName();
      var levelNumber = await _getLevelNumberATime(LocalDB.keyBoardLevelNumber);
      var levelTime = await _getLevelNumberATime(LocalDB.keyBoardLevelTime);

      yield FetchedPausedState(
          isPaused: isBoardPaused,
          levelName: levelName,
          levelNumber: levelNumber,
          levelTime: levelTime);
    }
  }

  Future<bool> _checkIsGamePaused() async {
    var res = await LocalDB.getString(LocalDB.keyBoardList);
    print('res: $res');
    if (res == null || res.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> _getLevelName() async {
    String val = await LocalDB.getString(LocalDB.keyBoardLevelName);
    return val;
  }

  Future<int> _getLevelNumberATime(String key) async {
    int val = await LocalDB.getInt(key);
    return val;
  }
}
