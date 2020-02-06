import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/num_pad.dart';
import 'package:sudoku_brain/components/panel.dart';
import 'package:sudoku_brain/components/play_pause_widget.dart';
import 'package:sudoku_brain/components/timer_widget.dart';
import 'package:sudoku_brain/models/board_data.dart';
import 'package:sudoku_brain/models/row_col.dart';
import 'package:sudoku_brain/utils/Constants.dart';

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

  int _row = -1;
  int _col = -1;
  int _cursor = 0;
  int _cursorCopy = -1;

  String _dynamicText;

  double _animatedHeight = 50.0;

  bool _isTimerPaused = false;

  List<List<BoardData>> _boardList = [];
  List<List<BoardData>> _initBoardList = [];
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
//          _boardList = List.from(dummyList);
          _boardList = List.from(state.boardList);
//          _initList.clear(); TODO: copy list to another list without same reference
//          _initList.addAll(state.boardList.map((element) => element).toList());
          print('imgList: $_boardList');
        } else if (state is ConflictsChanged) {
          print('ConflictsChanged');
          _conflicts = state.conflicts;
        } else if (state is CursorChangedState) {
          _cursor = state.val;
          _cursorCopy = state.val;
          if (state.val == 0) {
            _cursorCopy = -1;
          }
          print('cursor: $_cursor');
        } else if (state is UpdateCellState) {
          _boardList[_row][_col].value = state.val;
          print('_boardList: ${state.val}');
        } else if (state is UpdateRowColState) {
          print('UpdateRowColState');
          _row = state.row;
          _col = state.col;
        } else if (state is PauseTimerState) {
          _isTimerPaused = state.isPaused;
          _dynamicText = 'PAUSE';
        } else if (state is ResetState) {
          print('ResetState');
          print('ResetState: ${state.boardList}');
          _cursorCopy = -1;
          _boardList = List.from(state.boardList);
          changeConflicts();
        } else if (state is FullScreenState) {
          print('state.isFull ${state.isFull}');
//          _isFullScreen = state.isFull;

          _animatedHeight != 0.0
              ? _animatedHeight = 0.0
              : _animatedHeight = 40.0;
        } else if (state is GameFinishedState) {
          print('game finished hurry');
          print('game won: ${state.isWon}');
          _isTimerPaused = true;
          if (state.isWon) {
            _dynamicText = 'You Won!';
          } else {
            _dynamicText = 'You Lost!';
          }
        }
      },
      child:
          BlocBuilder<MainBoardBloc, MainBoardState>(builder: (context, state) {
        print('BlocBuilder');
        return SafeArea(
          child: Scaffold(
              backgroundColor: Color(kPrimaryColor),
              body: Column(children: [
                AnimatedContainer(
                  height: _animatedHeight,
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    margin: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InkWell(
                            onTap: () {
                              print('settings');
                              readJson();
                            },
                            child: Icon(Icons.settings, size: 25.0)),
                        CounterWidget(mainBoardBloc: _mainBoardBloc),
                        PlayPauseWidget(
                            isTimerPaused: _isTimerPaused,
                            mainBoardBloc: _mainBoardBloc),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        child: Container(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: buildTable(),
                          ),
                        ),
                      ),
                      Positioned(
                        child: Visibility(
                          visible: _isTimerPaused,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.55,
                            color: transparent,
                            child: Center(
                                child: Text(
                              '$_dynamicText',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow),
                            )),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Panel(
                  onSegmentChange: (int segmentValue) {
                    print('segmentValue: $segmentValue');

                    if (!_isTimerPaused) {
                      switch (segmentValue) {
                        case 0:
                          _mainBoardBloc.add(FullScreen());
                          break;
                        case 1:
                          _numPadButtonClick(0);
                          break;
                        case 2:
                          _mainBoardBloc.add(ResetBoard(
                              list: _initBoardList, buildContext: context));
                          break;
                      }
                    }
                  },
                ),
                NumPad(
                  values: [1, 2, 3, 4, 5],
                  marginTop: 20.0,
                  marginRight: 30.0,
                  marginLeft: 30.0,
                  marginBottom: 0.0,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  onValueChanged: (int val) {
                    print('NumPad: $val');

                    if (!_isTimerPaused) _numPadButtonClick(val);
                  },
                ),
                NumPad(
                    values: [6, 7, 8, 9],
                    marginTop: 15.0,
                    marginRight: 35.0,
                    marginLeft: 35.0,
                    marginBottom: 0.0,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    onValueChanged: (int val) {
                      print('NumPad: $val');
                      if (!_isTimerPaused) _numPadButtonClick(val);
                    }),
              ])),
        );
      }),
    );
  }

  Table buildTable() {
    return Table(
      children: getTableBoardRow(), // main board
      border: new TableBorder.all(color: kBorderTest, width: 1.0),
    );
  }

  void _numPadButtonClick(int value) {
    changeCursor(value);
    _mainBoardBloc.add(UpdateCellValue(val: value));
    changeConflicts();
  }

//  Methods

  void changeConflicts() {
    _mainBoardBloc.add(ChangeConflictsCalled(list: _boardList));
  }

  void changeCursor(i) {
    _mainBoardBloc.add(CursorChanged(val: i));
  }

  Color getHighlightColor(int r, int c) {
    if (_boardList.isNotEmpty && _initBoardList.isNotEmpty) {
      bool isConflict = _conflicts.contains(new RowCol(r, c));
      bool isChangeAble = _initBoardList[r][c].value == 0;
      bool isToHighlight = _boardList[r][c].value == _cursorCopy;

      if (r == _row && c == _col) {
        return kBoardCellSelected;
      }

      if (r == _row && !isConflict) {
        return lightBlue;
      } else if (r == _row && isConflict) {
        return Colors.red[100];
      }

      if (c == _col && !isConflict) {
        return lightBlue;
      } else if (c == _col && isConflict) {
        return Colors.red[100];
      }

      if (isConflict && !isChangeAble)
        return Colors.red[100];
      else if (isConflict)
        return Color(kBoardCellEmpty);
      else if (isToHighlight)
        return Color(kBoardPreFilled);
      else
        return Color(kBoardCellEmpty);
    } else {
      return Color(kBoardCellEmpty);
    }
  }

  Color getTextColor(int r, int c) {
    if (_initBoardList.isNotEmpty) {
      bool isConflict = _conflicts.contains(new RowCol(r, c));
      bool isChangeAble = _initBoardList[r][c].value == 0;

      if (r == _row && c == _col && !isConflict) {
        return Colors.black;
      }

      if (isConflict && !isChangeAble)
        return Colors.black;
      else if (isConflict)
        return Colors.red;
      else if (!isChangeAble)
        return Colors.black;
      else
        return Colors.black;
    } else {
      return Colors.black;
    }
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
          height: (MediaQuery.of(context).size.height / 2) / 9,
          width: (MediaQuery.of(context).size.width / 2) / 9,
          color: getHighlightColor(r, c),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: isShowRowBorder(r),
                child: Divider(
                  color: Color(kPrimaryColor),
                  height: 1.0,
                  thickness: 3.0,
                ),
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Visibility(
                    visible: isShowColBorder(c),
                    child: Container(
                      height:
                          ((MediaQuery.of(context).size.height / 2) / 9) - 1,
                      width: 3.0,
                      color: Color(kPrimaryColor),
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: false,
                    child: Text(
                      getText(r, c),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: getTextColor(r, c),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _buildItemsList(),
                  ),
                  Spacer(),
                ],
              ),
              Spacer(),
            ],
          ),
        ),
      ));
    }
    return new TableRow(children: lst);
  }

  // TODO: remove it later
  Future<List<List<BoardData>>> readJson() async {
    print('readJson');

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");
//    print('data: $data');

    var decodedData = jsonDecode(data);
    List list = decodedData['easy'];
    print('main list: $list');

    List<List<BoardData>> test = [];
    for (int i = 0; i < list.length; i++) {
      List innerList = list[i];
      List<BoardData> dataList = [];
      for (int j = 0; j < innerList.length; j++) {
        dataList.add(BoardData(value: innerList[j], mode: PlayMode.PLAY));
      }
      test.add(dataList);
    }

    print('================ List ===============');
    print('list: ${test[1][1].value}');
    print('list: ${test[0][0].mode}');
    print('================ List ===============');

    return test;
  }

  String getText(int r, int c) {
    if (_boardList.isEmpty) {
      return '';
    } else {
      if (_boardList[r][c].value == 0) {
        return '';
      } else {
        return '${_boardList[r][c].value}';
      }
    }
  }

//  =========
  Widget _buildItemsList() {
    Widget itemCards;
    List items = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          child: const Text('abc'),
          color: Colors.teal[100],
        ),
        Container(
          child: const Text('400'),
          color: Colors.teal[200],
        )
      ],
    );
  }
}
