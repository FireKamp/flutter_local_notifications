import 'dart:collection';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:sudoku_brain/screens/gameend/gameend_screen.dart';
import 'package:sudoku_brain/screens/settings/settings_screen.dart';
import 'package:sudoku_brain/utils/AdManager.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';
import 'package:sudoku_brain/utils/Strings.dart';

import 'main_board_bloc.dart';
import 'main_board_event.dart';
import 'main_board_state.dart';

class MainBoard extends StatefulWidget {
  static final String id = 'main_board';

  @override
  _MainBoardState createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> with WidgetsBindingObserver {
  MainBoardBloc _mainBoardBloc;
  Function(bool) onHintSelected;

  int _row = -1;
  int _col = -1;
  int _cursor = 0;
  int hintCount = -1;
  int _cursorCopy = -1;
  int _levelIndex = 0;

  String _dynamicText;
  String _dynamicTextFB;
  String _levelName;

  double _animatedHeight = 50.0;

  bool _isTimerPaused = false;
  bool _isPausedForAd = false;
  bool _isPencilON = false;

  List<List<BoardData>> _boardList = [];
  List<List<BoardData>> _initBoardList = [];
  HashSet<RowCol> _conflicts = new HashSet<RowCol>();

  @override
  void initState() {
    setupAds();
    Analytics.logEvent('screen_gameboard');

    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mainBoardBloc = BlocProvider.of<MainBoardBloc>(context);
  }

  setupAds() {
    AdManager.rewardEvents = ((RewardAdStatus status) {
      var shouldReward = (status == RewardAdStatus.notFetched || status == RewardAdStatus.failed || status == RewardAdStatus.reward);
      if (shouldReward) {
        // If they saw the ad, reward them and they need to tap on hint again to trigger
        if (status == RewardAdStatus.reward) {
          _mainBoardBloc
              .add(AdRewarded(levelName: _levelName, index: _levelIndex));
          AdManager.precacheRewardAd();
        } else {
          // TODO: Zahid - This block means no ad was shown, we should just immediately put the hint in the box in this case so they don't have to tap twice, otherwise seems broken
          _mainBoardBloc
              .add(AdRewarded(levelName: _levelName, index: _levelIndex));
        }
      }
      // TODO: Zahid - There's some issue with the timer now it goes much faster after a failed reward ad
      _mainBoardBloc.add(StartTimer());
    });
    AdManager.startListening();
    AdManager.precacheRewardAd();
    AdManager.precacheInterstitialAd();
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
            _changeConflicts();
          }
        } else if (state is UpdateRowColState) {
          _row = state.row;
          _col = state.col;
        } else if (state is PauseTimerState) {
          print('_isPausedForAd: ${state.isPausedForAd}');
          _isTimerPaused = state.isPaused;
          _isPausedForAd = state.isPausedForAd;
          _dynamicText = kPauseText;
          _dynamicTextFB = kEndText;
        } else if (state is ResetState) {
          _cursorCopy = -1;
          _boardList = List.from(state.boardList);
          _changeConflicts();
        } else if (state is FullScreenState) {
          _animatedHeight != 0.0
              ? _animatedHeight = 0.0
              : _animatedHeight = 40.0;
        } else if (state is GameFinishedState) {
          AdManager.showInterstitialAd();
          if (state.isWon) {
            MediaPlayer.loadPlayAudio(5);
            Navigator.pushReplacementNamed(context, GameEndScreen.id,
                arguments: ScreenArguments(
                    levelName: _levelName,
                    index: _levelIndex + 1,
                    bestTime: state.time,
                    isPlayed: true));
          } else {
            _isTimerPaused = true;
            _dynamicText = kLoseText;
            _dynamicTextFB = kLoseBText;
          }
        } else if (state is PlayAgainState) {
          _isTimerPaused = false;
        } else if (state is PencilState) {
          _isPencilON = state.isPencilEnabled;
        } else if (state is GetHintVState) {
          hintCount = state.val;
          if (hintCount < 0) {
            // due to pre decrement its less than 0
            _mainBoardBloc.add(PauseTimer(isPausedForAd: true));
            AdManager.showRewardAd();
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
                              Navigator.pushNamed(context, SettingsScreen.id);
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
                          margin: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 2.0, bottom: 2.0),
                          child: _buildTable(),
                        ),
                      ),
                      Positioned(
                        child: Visibility(
                          visible: _isPausedForAd == true
                              ? !_isPausedForAd
                              : _isTimerPaused,
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.55,
                            color: transparent,
                            child: Column(
                              children: <Widget>[
                                Spacer(
                                  flex: 1,
                                ),
                                Center(
                                    child: Text(
                                  '$_dynamicText',
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow),
                                )),
                                Spacer(
                                  flex: 1,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (_dynamicText == kPauseText) {
                                      Navigator.pop(context);
                                    } else {
                                      _resetBoard();
                                      _mainBoardBloc.add(PlayAgain());
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF7EC1FF),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    height: 50.0,
                                    child: AutoSizeText(
                                      _dynamicTextFB == null
                                          ? ''
                                          : _dynamicTextFB,
                                      style: TextStyle(
                                          fontFamily: 'Staatliches',
                                          fontSize: 80.0,
                                          letterSpacing: 2.0,
                                          color: Colors.purple[900],
                                          fontWeight: FontWeight.w800,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 50.0,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Panel(
                  hintValue: hintCount,
                  isPaused: _isTimerPaused,
                  defaultPencilValue: _isPencilON == true ? false : true,
                  onSegmentChange: (int segmentValue, bool isSelected) {
                    if (!_isTimerPaused) {
                      switch (segmentValue) {
                        case 0:
                          Analytics.logEvent('tap_full_screen');
                          _mainBoardBloc.add(FullScreen());
                          break;
                        case 1:
                          Analytics.logEvent('tap_erase');
                          _numPadButtonClick(0);
                          break;
                        case 2:
                          Analytics.logEvent('tap_undo');
                          _resetBoard();
                          break;
                        case 3:
                          Analytics.logEvent('tap_hint');
                          _mainBoardBloc.add(Hint(
                              row: _row,
                              col: _col,
                              levelDetails: '$_levelName-$_levelIndex',
                              isPencilMode: _isPencilON,
                              levelName: _levelName,
                              index: _levelIndex));
                          break;
                        case 4:
                          Analytics.logEvent('tap_edit');

                          _mainBoardBloc
                              .add(PencilMode(isPencilMode: isSelected));
                          break;
                      }
                    }
                  },
                ),
                NumPad(
                  isPencilOn: _isPencilON,
                  values: [1, 2, 3, 4, 5],
                  marginTop: MediaQuery.of(context).size.height * 0.02,
                  marginRight: MediaQuery.of(context).size.height * 0.045,
                  marginLeft: MediaQuery.of(context).size.height * 0.045,
                  marginBottom: 0.0,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  onValueChanged: (int val) {
                    if (!_isTimerPaused) _numPadButtonClick(val);
                  },
                ),
                NumPad(
                    isPencilOn: _isPencilON,
                    values: [6, 7, 8, 9],
                    marginTop: MediaQuery.of(context).size.height * 0.02,
                    marginRight: MediaQuery.of(context).size.height * 0.07,
                    marginLeft: MediaQuery.of(context).size.height * 0.07,
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
      _mainBoardBloc.add(UpdateCellValue(val: value, row: _row, col: _col));
    } else {
      _changeCursor(value);
      _mainBoardBloc.add(UpdateCellValue(val: value, row: _row, col: _col));
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
          _mainBoardBloc
              .add(UpdateRowCol(row: r, col: c, list: _initBoardList));
        },
        child: Container(
          height: (MediaQuery.of(context).size.height / 2) / 8.8,
          width: (MediaQuery.of(context).size.width / 2) / 8.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                getTopLeftRadius(c, r),
              ),
              topRight: Radius.circular(
                getTopRightRadius(c, r),
              ),
              bottomLeft: Radius.circular(
                getBottomLeftRadius(c, r),
              ),
              bottomRight: Radius.circular(
                getBottomRightRadius(c, r),
              ),
            ),
            color: _getHighlightColor(r, c),
          ),
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
                          ((MediaQuery.of(context).size.height / 2) / 8.8) - 1,
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
                    child: AutoSizeText(
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
    _mainBoardBloc.add(BoardInitISCalled(
        context: context, levelName: args.levelName, index: args.index));
    _mainBoardBloc.add(StartTimer());

    _levelIndex = args.index;
    _levelName = args.levelName;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state: ${state.toString()}');
    if (state == AppLifecycleState.paused) {
//      var json = jsonEncode(_boardList, toEncodable: (e) => e.toJsonAttr());
      var json = jsonEncode(_boardList.map((e) => e.toString()).toList());
      LocalDB.setString(LocalDB.keyBoardList, json);
    } else if (state == AppLifecycleState.resumed) {
      LocalDB.getString(LocalDB.keyBoardList).then((value) async {
//        if (value != null && value.isNotEmpty) {
//          List data = json.decode(value);
//
//          List<List<BoardData>> test = [];
//          for (int i = 0; i < data.length; i++) {
//            List innerList = data[i];
//            List<BoardData> dataList = [];
//            for (int j = 0; j < innerList.length; j++) {
////              var value=decodedData['${innerList[j]}'];
//
////              dataList.add(BoardData(
////                  value: boardData.value, mode: boardData.mode));
//            }
//            test.add(dataList);
//          }
//        }
      });
    }
  }

  void _resetBoard() {
    _mainBoardBloc.add(ResetBoard(
        list: _initBoardList,
        buildContext: context,
        index: _levelIndex,
        levelName: _levelName));
  }

  @override
  void dispose() {
    AdManager.rewardEvents = null;
    AdManager.stopListening();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
