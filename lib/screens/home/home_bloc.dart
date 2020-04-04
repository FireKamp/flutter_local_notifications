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
      var isSound = await _getSettings(LocalDB.keyTurnOnSound);
      var isHaptic = await _getSettings(LocalDB.keyTurnOnHaptics);
      var isHide = await _getSettings(LocalDB.keyHideDuplicate);
      var isHighLight = await _getSettings(LocalDB.keyHighDuplicate);
      var isMistake = await _getSettings(LocalDB.keyMistakeLimit);

      yield FetchedPausedState(
          isPaused: isBoardPaused,
          levelName: levelName,
          levelNumber: levelNumber,
          levelTime: levelTime,
          isSoundsOn: isSound,
          isHapticsOn: isHaptic,
          isHideDuplicates: isHide,
          isHighDuplicates: isHighLight,
          isMistakeLimit: isMistake);
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

  Future<bool> _getSettings(String key) async {
    bool val = await LocalDB.getBool(key);
    return val;
  }
}
