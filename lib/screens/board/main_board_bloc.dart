import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sudoku_brain/models/board_data.dart';
import 'package:sudoku_brain/models/row_col.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';
import '../../utils/Board.dart';

class MainBoardBloc extends Bloc<MainBoardEvent, MainBoardState> {
  Timer _timer;
  int _currentTimerValue = 0;
  bool _isPaused = false;
  bool _isFullScreen = true;
  List<List<BoardData>> _solution;
  String _timerText;

  StreamController<String> _timerController =
      StreamController<String>.broadcast();

  StreamSink<String> get _tickValue => _timerController.sink;

  Stream<String> get outCounter => _timerController.stream.asBroadcastStream();

  @override
  MainBoardState get initialState => InitialMainBoardState();

  @override
  Stream<MainBoardState> mapEventToState(
    MainBoardEvent event,
  ) async* {
    if (event is BoardInitISCalled) {
      yield FetchingLevel();
      final hintCount = await _getHintCount(event.levelName, event.index);
      yield GetHintVState(val: hintCount);
      final list =
          await _readJson(event.context, event.levelName, event.index, false);
      yield LevelFetched(boardList: list);

      final listNew =
          await _readJson(event.context, event.levelName, event.index, false);
      yield InitStateFetched(boardList: listNew);

      _solution =
          await _readJson(event.context, event.levelName, event.index, true);
    } else if (event is ChangeConflictsCalled) {
      final conflicts = _changeConflicts(event.list);
      final gameFinished = _gameFinished(event.list);
      yield ConflictsChanged(conflicts: conflicts);
      if (gameFinished) {
        final isWon = compareLists(event.list);
        yield GameFinishedState(isWon: isWon, time: _timerText);
      }
    } else if (event is CursorChanged) {
      final cursor = _changeCursor(event.val);
      yield CursorChangedState(val: cursor);
    } else if (event is UpdateCellValue) {
      final value = _changeCellValue(event.val);
      yield UpdateCellState(val: value);
    } else if (event is UpdateRowCol) {
      final list = _changeRowCol(event.row, event.col, event.list);
      if (list != null) yield UpdateRowColState(row: list[0], col: list[1]);
    } else if (event is StartTimer) {
      _startTimer();
      _isPaused = false;
      yield (PauseTimerState(isPaused: _isPaused));
    } else if (event is PauseTimer) {
      _stopTimer();
      _isPaused = true;
      yield (PauseTimerState(isPaused: _isPaused));
    } else if (event is ResetBoard) {
      final list = await _readJson(
          event.buildContext, event.levelName, event.index, false);
      yield ResetState(boardList: list);
    } else if (event is FullScreen) {
      final full = fullScreen();
      yield FullScreenState(isFull: full);
    } else if (event is Hint) {
      yield PencilState(isPencilEnabled: event.isPencilMode);
      if (!event.isPencilMode) {
        int hintCount = await _getHintCount(event.levelName, event.index);
        String key = getDBKey(event.levelName, event.index);

        hintCount = hintCount - 1;

        if (hintCount >=0) {
          LocalDB.setInt(key, hintCount);
          int value = getHint(event.row, event.col);
          yield UpdateCellState(val: value);
        }
        yield GetHintVState(val: hintCount);

      }
    } else if (event is PlayAgain) {
      yield PlayAgainState();
    } else if (event is PencilMode) {
      yield PencilState(isPencilEnabled: event.isPencilMode);
    } else if (event is AdRewarded) {
      String key = getDBKey(event.levelName, event.index);
      LocalDB.setInt(key, 1);
      yield GetHintVState(val: 2);
    }
  }

  Future<int> _getHintCount(String levelName, int index) async {
    String key = getDBKey(levelName, index);
    int hintCount = await LocalDB.getInt(key);

    if (hintCount == null) {
      int value = 0;
      if (levelName == 'easy') {
        value = 2;
      } else if (levelName == 'medium') {
        value = 1;
      } else if (levelName == 'hard') {
        value = 1;
      }
      LocalDB.setInt(key, value);
      return value;
    } else {
      return hintCount;
    }
  }

  String getDBKey(String levelName, int index) {
    String key = '${levelName}_hint_${index + 1}';
    print('key: $key');
    return key;
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  int getHint(int row, int col) {
    return _solution[row][col].value;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTimerValue = _currentTimerValue + 1;
      final df = new DateFormat('mm:ss');
      _timerText = df.format(
          new DateTime.fromMillisecondsSinceEpoch((_currentTimerValue) * 1000));
      _handleLogic(_timerText);
    });
  }

  void _handleLogic(data) {
    _tickValue.add(data);
  }

  void dispose() {
    _timerController.close();
    _tickValue.close();
  }

  bool fullScreen() {
    if (_isFullScreen) {
      _isFullScreen = false;
    } else {
      _isFullScreen = true;
    }

    return _isFullScreen;
  }

  bool compareLists(List<List<BoardData>> list) {
    bool isGameWon = true;
    for (int i = 0; i < list.length; i++) {
      List innerList = list[i];
      for (int j = 0; j < innerList.length; j++) {
        if (list[i][j].value != _solution[i][j].value) {
          isGameWon = false;
        }
      }
    }

    _stopTimer();
    return isGameWon;
  }

// Read data from JSON File
  Future<List<List<BoardData>>> _readJson(
      BuildContext context, String objName, int index, bool isSol) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");

    var decodedData = jsonDecode(data);
    List list = decodedData['difficulty'][objName]['level'][index]
        [isSol == true ? 'solution' : 'board'];

    // just for testing. TODO: remove later just for testing
//    List list;
//    if (isSol) {
//      list = List.from(dummyList1);
//    } else {
//      list = List.from(dummyList);
//    }

    List<List<BoardData>> test = [];
    for (int i = 0; i < list.length; i++) {
      List innerList = list[i];
      List<BoardData> dataList = [];
      for (int j = 0; j < innerList.length; j++) {
        dataList.add(BoardData(value: innerList[j], mode: PlayMode.PLAY));
      }
      test.add(dataList);
    }

    return test;
  }

// Change conflicts
  HashSet<RowCol> _changeConflicts(List<List<BoardData>> boardList) {
    HashSet<RowCol> _conflicts = Conflict.getConflicts(boardList);
    return _conflicts;
  }

  bool _gameFinished(List<List<BoardData>> boardList) {
    bool isFinished = Conflict.computeFinishGame(boardList);
    return isFinished;
  }

// Change cursor
  int _changeCursor(int val) {
    return val;
  }

// Change cell value
  int _changeCellValue(int val) {
    return val;
  }

//
  List<int> _changeRowCol(int row, int col, List<List<BoardData>> list) {
    List<int> retList = List();
    if (list[row][col].value == 0) {
      retList.add(row);
      retList.add(col);
    }
    return retList;
  }

//
  List<List<BoardData>> reset(List<List<BoardData>> _initBoardList) {
    List<List<BoardData>> list = new List<List<BoardData>>.generate(
        9, (i) => new List<BoardData>.from(_initBoardList[i]));

    return list;
  }
}

// showRow Border or Not
bool isShowRowBorder(int r) {
  if (r == 3 || r == 6) {
    return true;
  } else {
    return false;
  }
}

double getTopLeftRadius(int c, int r) {
  if (c == 0 && r == 0) {
    return 10.0;
  } else {
    return 0.0;
  }
}

double getTopRightRadius(int c, int r) {
  if (c == 8 && r == 0) {
    return 10.0;
  } else {
    return 0.0;
  }
}

double getBottomRightRadius(int c, int r) {
  if (c == 8 && r == 8) {
    return 10.0;
  } else {
    return 0.0;
  }
}

double getBottomLeftRadius(int c, int r) {
  if (c == 0 && r == 8) {
    return 10.0;
  } else {
    return 0.0;
  }
}

bool isShowColBorder(int c) {
  if (c == 3 || c == 6) {
    return true;
  } else {
    return false;
  }
}
