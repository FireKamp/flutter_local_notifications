import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/num_pad.dart';
import 'package:sudoku_brain/components/panel.dart';
import 'package:sudoku_brain/components/play_pause_widget.dart';
import 'package:sudoku_brain/components/timer_widget.dart';
import 'package:sudoku_brain/models/board_data.dart';
import 'package:sudoku_brain/models/row_col.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/Strings.dart';

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
  bool _isPencilON = false;

  List<List<BoardData>> _boardList = [];
  List<List<BoardData>> _initBoardList = [];
  HashSet<RowCol> _conflicts = new HashSet<RowCol>();

  @override
  void initState() {
    super.initState();
    _mainBoardBloc = BlocProvider.of<MainBoardBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    initBoardData();
    return BlocListener(
      bloc: BlocProvider.of<MainBoardBloc>(context),
      listener: (BuildContext context, state) {
        if (state is InitialMainBoardState) {
        } else if (state is FetchingLevel) {
        } else if (state is LevelFetched) {
          _boardList = List.from(state.boardList);
        } else if (state is InitStateFetched) {
          _initBoardList = List.from(state.boardList);
        } else if (state is ConflictsChanged) {
          _conflicts = state.conflicts;
        } else if (state is CursorChangedState) {
          _cursor = state.val;
          _cursorCopy = state.val;
          if (state.val == 0) {
            _cursorCopy = -1;
          }
        } else if (state is UpdateCellState) {
          if (_isPencilON) {
            bool isConflict = _conflicts.contains(new RowCol(_row, _col));
            _boardList[_row][_col].mode = PlayMode.PENCIL;
            _boardList[_row][_col].pencilValues[state.val - 1] = state.val;
          } else {
            _boardList[_row][_col].mode = PlayMode.PLAY;
            _boardList[_row][_col].value = state.val;
          }
        } else if (state is UpdateRowColState) {
          _row = state.row;
          _col = state.col;
        } else if (state is PauseTimerState) {
          _isTimerPaused = state.isPaused;
          _dynamicText = kPauseText;
        } else if (state is ResetState) {
          _cursorCopy = -1;
          _boardList = List.from(state.boardList);
          _changeConflicts();
        } else if (state is FullScreenState) {
          _animatedHeight != 0.0
              ? _animatedHeight = 0.0
              : _animatedHeight = 40.0;
        } else if (state is GameFinishedState) {
          print('game won: ${state.isWon}');
          _isTimerPaused = true;
          if (state.isWon) {
            _dynamicText = kWinText;
          } else {
            _dynamicText = kLooseText;
          }
        }
      },
      child:
          BlocBuilder<MainBoardBloc, MainBoardState>(builder: (context, state) {
        return SafeArea(
          child: Scaffold(
              backgroundColor: kPrimaryColor,
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
                              Navigator.pop(context);
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
                            child: _buildTable(),
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
                  onSegmentChange: (int segmentValue, bool isSelected) {
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
                        case 3:
                          _mainBoardBloc.add(Hint(row: _row, col: _col));
                          break;
                        case 4:
                          _isPencilON = isSelected;
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
                      if (!_isTimerPaused) _numPadButtonClick(val);
                    }),
              ])),
        );
      }),
    );
  }

  Table _buildTable() {
    return Table(
      children: _getTableBoardRow(), // main board
      border: new TableBorder.all(color: kBorderTest, width: 1.0),
    );
  }

  void _numPadButtonClick(int value) {
    if (_isPencilON) {
      _mainBoardBloc.add(UpdateCellValue(val: value));
    } else {
      _changeCursor(value);
      _mainBoardBloc.add(UpdateCellValue(val: value));
      _changeConflicts();
    }
  }

//  Methods

  void _changeConflicts() {
    _mainBoardBloc.add(ChangeConflictsCalled(list: _boardList));
  }

  void _changeCursor(i) {
    _mainBoardBloc.add(CursorChanged(val: i));
  }

  Color _getHighlightColor(int r, int c) {
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
      else if (isToHighlight && !_isPencilON)
        return Color(kBoardPreFilled);
      else
        return Color(kBoardCellEmpty);
    } else {
      return Color(kBoardCellEmpty);
    }
  }

  Color _getTextColor(int r, int c) {
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

  List<TableRow> _getTableBoardRow() {
    List<TableRow> lst = new List<TableRow>();
    for (int r = 0; r < 9; r++) {
      lst.add(_getTableRow(r));
    }
    return lst;
  }

  TableRow _getTableRow(r) {
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
          color: _getHighlightColor(r, c),
          child: Column(
            children: <Widget>[
              Visibility(
                visible: isShowRowBorder(r),
                child: Divider(
                  color: kPrimaryColor,
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
                      color: kPrimaryColor,
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: (_boardList.isEmpty
                        ? false
                        : _boardList[r][c].mode == PlayMode.PENCIL
                            ? false
                            : true),
                    child: Text(
                      _getText(r, c),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: _getTextColor(r, c),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: (_boardList.isEmpty
                        ? false
                        : _boardList[r][c].mode == PlayMode.PENCIL
                            ? true
                            : false),
                    child: _buildItemsList(_boardList.isNotEmpty
                        ? _boardList[r][c].pencilValues
                        : null),
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

  String _getText(int r, int c) {
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

  Widget _buildItemsList(List<int> pencilValues) {
    List items = [1, 2, 3, 0, 5, 6, 0, 8, 9];
    if (pencilValues != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 30.0,
            height: 30.0,
            child: GridView.count(
                primary: false,
                crossAxisCount: 3,
                children: List.generate(pencilValues.length, (index) {
                  return Container(
                    width: 30.0,
                    height: 30.0,
                    child: Text(
                      '${pencilValues[index] == 0 ? '' : pencilValues[index]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black, fontSize: 10.0),
                    ),
                  );
                })),
          ),
        ],
      );
    } else {
      return Container(
        width: 30.0,
        height: 30.0,
      );
    }
  }

  void initBoardData() {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    _mainBoardBloc
        .add(BoardInitISCalled(context: context, levelTYPE: args.levelTYPE));
    _mainBoardBloc.add(StartTimer());
  }
}
