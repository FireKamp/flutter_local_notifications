import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sudoku_brain/models/row_col.dart';
import 'package:sudoku_brain/utils/Constants.dart';

import './bloc.dart';
import '../../utils/Board.dart';

class MainBoardBloc extends Bloc<MainBoardEvent, MainBoardState> {
  Timer _timer;
  int _currentTimerValue = 0;
  bool _isPaused = false;

  StreamController<String> _timerController = StreamController<String>();

  StreamSink<String> get _tickValue => _timerController.sink;

  Stream<String> get outCounter => _timerController.stream;

  @override
  MainBoardState get initialState => InitialMainBoardState();

  @override
  Stream<MainBoardState> mapEventToState(
    MainBoardEvent event,
  ) async* {
    if (event is BoardInitISCalled) {
      yield FetchingLevel();
      final list = await _readJson(event.context);
      yield LevelFetched(boardList: list);
    } else if (event is ChangeConflictsCalled) {
      final conflicts = _changeConflicts(event.list);
      yield ConflictsChanged(conflicts: conflicts);
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
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _currentTimerValue = _currentTimerValue + 1;
      final df = new DateFormat('mm:ss');
      String _timerText = df.format(
          new DateTime.fromMillisecondsSinceEpoch((_currentTimerValue) * 1000));
      _handleLogic(_timerText);
    });
  }

  void _handleLogic(data) {
    _tickValue.add(data);
  }

  void dispose() {
    _timerController.close();
  }
}

// Read data from JSON File
Future<List<List<int>>> _readJson(BuildContext context) async {
  print('readJson');

  List<List<List<int>>> finalList = List();

  String data =
      await DefaultAssetBundle.of(context).loadString("assets/brain.json");
//    print('data: $data');

  var decodedData = jsonDecode(data);
  List list = decodedData['easy'];
  print('list: $list');

  List<List<int>> ques = [];
  List<List<int>> ans = [];
  for (int i = 0; i < list.length; i++) {
    ques.add(list[i].cast<int>());
  }
  for (int i = 0; i < ques.length; i++) {
    ans.add(list[i].cast<int>());
  }

  finalList.add(ques);
  return ques;
}

// Change conflicts
HashSet<RowCol> _changeConflicts(List<List<int>> boardList) {
  HashSet<RowCol> _conflicts = Conflict.getConflicts(boardList);
  return _conflicts;
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
List<int> _changeRowCol(int row, int col, List<List<int>> list) {
  List<int> retList = List();
  if (list[row][col] == 0) {
    retList.add(row);
    retList.add(col);
  }
  return retList;
}

//

//
Color getHighlightColorBloc(int selRow, int selCol, int row, int col,
    HashSet<RowCol> conflicts, List<List<int>> initBoardList) {
  bool isConflict = conflicts.contains(new RowCol(row, col));
  bool isChangeAble = initBoardList[row][col] == 0;

  if (row == selCol && col == selCol) {
    return Color(kBoardCellSelected);
  }

  if (isConflict && !isChangeAble)
    return Colors.red[900];
  else if (isConflict)
    return Colors.red[100];
  else if (!isChangeAble)
    return Color(kBoardPreFilled);
  else
    return Color(kBoardCellEmpty);
}

// showRow Border or Not
bool isShowRowBorder(int r) {
  if (r == 3 || r == 6) {
    return true;
  } else {
    return false;
  }
}

bool isShowColBorder(int c) {
  if (c == 3 || c == 6) {
    return true;
  } else {
    return false;
  }
}
