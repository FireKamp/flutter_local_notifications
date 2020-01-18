import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/play_pause_widget.dart';
import 'package:sudoku_brain/components/timer_widget.dart';
import 'package:sudoku_brain/utils/Constants.dart';

import '../../Board.dart';
import 'main_board_bloc.dart';
import 'main_board_event.dart';
import 'main_board_state.dart';

class MainBoard extends StatefulWidget {
  static final String id = 'main_board';

  @override
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  MainBoardBloc _mainBoardBloc;

  int _row = 0;
  int _col = 0;

  int _cursor = 0;

  bool _isTimerPaused = false;

  List<List<int>> _boardList = constantList;
  List<List<int>> _initBoardList = constantList;
  HashSet<RowCol> _conflicts = new HashSet<RowCol>();

  @override
  void initState() {
    super.initState();

    // init main screens.board bloc here
    _mainBoardBloc = BlocProvider.of<MainBoardBloc>(context);
    _mainBoardBloc.add(BoardInitISCalled(context: context));
    _mainBoardBloc.add(StartTimer());

    readJson().then((value) {
      // TODO remove this method later
      _initBoardList = List.from(value);

      print('_initList: $_initBoardList');
    }, onError: (error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<MainBoardBloc>(context),
      listener: (BuildContext context, state) {
        if (state is InitialMainBoardState) {
          print('state: ${state.error}');
        } else if (state is FetchingLevel) {
          print('FetchingLevel');
        } else if (state is LevelFetched) {
          print('LevelFetched: ${state.boardList}');
          _boardList = List.from(state.boardList);
//          _initList.clear(); TODO: copy list to another list without same reference
//          _initList.addAll(state.boardList.map((element) => element).toList());
          print('imgList: $_boardList');
        } else if (state is ConflictsChanged) {
          print('ConflictsChanged');
          _conflicts = state.conflicts;
        } else if (state is CursorChangedState) {
          _cursor = state.val;
          print('cursor: $_cursor');
        } else if (state is UpdateCellState) {
          _boardList[_row][_col] = state.val;
          print('_boardList: ${state.val}');
        } else if (state is UpdateRowColState) {
          print('UpdateRowColState');
          _row = state.row;
          _col = state.col;
        } else if (state is PauseTimerState) {
          _isTimerPaused = state.isPaused;
        }
      },
      child:
          BlocBuilder<MainBoardBloc, MainBoardState>(builder: (context, state) {
        print('BlocBuilder');
        return SafeArea(
          child: Scaffold(
              backgroundColor: Color(kPrimaryColor),
              body: Column(children: [
                Container(
                  height: 40.0,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            print('settings');
                          },
                          child: Icon(Icons.settings, size: 25.0)),
                      CounterWidget(mainBoardBloc: _mainBoardBloc),
                      PlayPauseWidget(
                          isTimerPaused: _isTimerPaused,
                          mainBoardBloc: _mainBoardBloc),
                    ],
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: buildTable(),
                ),
                Padding(
                    padding: new EdgeInsets.only(top: 40.0),
                    child: new Table(
                      children: getKeyRowlst(),
                      border: new TableBorder.all(
                        color: Color(kNumPadBorder),
                      ),
                    ))
              ])),
        );
      }),
    );
  }

  Table buildTable() {
    return Table(
      children: getTableBoardRow(), // main board
      border: new TableBorder.all(color: Color(kPrimaryColor)),
    );
  }

//  Methods

  void changeConflicts() {
    _mainBoardBloc.add(ChangeConflictsCalled(list: _boardList));
  }

  void changeCursor(i) {
    _mainBoardBloc.add(CursorChanged(val: i));
  }

  Color getHighlightColor(int r, int c) {
    bool isConflict = _conflicts.contains(new RowCol(r, c));
    bool isChangeAble = _initBoardList[r][c] == 0;

    if (r == _row && c == _col) {
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

  List<TableRow> getTableBoardRow() {
    List<TableRow> lst = new List<TableRow>();
    for (int r = 0; r < 9; r++) {
      lst.add(getTableRow(r));
    }
    return lst;
  }

  TableRow getTableRow(r) {
    List<Widget> lst = new List<Widget>();
    for (int c = 0; c < 9; c++) {
      lst.add(InkWell(
        onTap: () {
          print('screens.board cell:[$r][$c]');
          _mainBoardBloc
              .add(UpdateRowCol(row: r, col: c, list: _initBoardList));
        },
        child: new Container(
          height: 36.0,
          color: getHighlightColor(r, c),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: isShowRowBorder(r),
                child: Divider(
                  color: Color(kPrimaryColor),
                  height: 1.0,
                  thickness: 2.0,
                ),
              ),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: isShowColBorder(c),
                    child: Container(
                      height: 35.0,
                      width: 2.0,
                      color: Color(kPrimaryColor),
                    ),
                  ),
                  Text(
                    _boardList[r][c] == 0 ? '' : '${_boardList[r][c]}',
                    style: TextStyle(
                        fontSize: 20.0, color: Color(kBoardTextColor)),
                  )
                ],
              ),
            ],
          ),
        ),
      ));
    }
    return new TableRow(children: lst);
  }

  List<TableRow> getKeyRowlst() {
    List<TableRow> lst = new List<TableRow>();
    lst.add(getKeyRow(0));
    lst.add(getKeyRow(5));
    return lst;
  }

  TableRow getKeyRow(int c) {
    List<Widget> lst = new List<Widget>();
    for (int i = 0; i <= 4; i++) {
      Color containerColor = Color(kPrimaryColor);
      if (_cursor == i + c) containerColor = Color(kNumPadBorder);
      lst.add(
        new Container(
          color: containerColor,
          child: InkWell(
            onTap: () {
              print((i + c).toString());
              changeCursor(i + c);
              _mainBoardBloc.add(UpdateCellValue(val: i + c));
              changeConflicts();
            },
            child: Center(
              child: Text(
                '${(i + c).toString()}',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
        ),
      );
    }
    return new TableRow(children: lst);
  }

  // TODO: remove it later
  Future<List<List<int>>> readJson() async {
    print('readJson');

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");
//    print('data: $data');

    var decodedData = jsonDecode(data);
    List list = decodedData['easy'];
    print('list: $list');

    List<List<int>> ques = [];
    for (int i = 0; i < list.length; i++) {
      ques.add(list[i].cast<int>());
    }
    return ques;
  }

  // Resets the whole screens.board. TODO: move it to bloc class
  void reset() {
    setState(() {
      _boardList = new List<List<int>>.generate(
          9, (i) => new List<int>.from(_initBoardList[i]));
      changeConflicts();
    });
  }
}
