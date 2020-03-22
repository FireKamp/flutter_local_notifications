import 'package:auto_size_text/auto_size_text.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/logo_header.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/gameend/gameend_screen.dart';
import 'package:sudoku_brain/screens/levelselection/bloc.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';

class LevelSelection extends StatefulWidget {
  static String id = 'level_selection';

  @override
  _LevelSelectionState createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  LevelSelectionBloc _levelselectionBloc;
  String _levelName;
  List<bool> _levelList;
  Gradient _gradient;

  @override
  void initState() {
    super.initState();
    Analytics.logEvent('screen_level_details');
    _levelselectionBloc = BlocProvider.of<LevelSelectionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    return BlocListener(
      bloc: BlocProvider.of<LevelSelectionBloc>(context),
      listener: (BuildContext context, state) {
        if (state is LevelListState) {
          _levelList = List.from(state.levelList);
        }
      },
      child: BlocBuilder<LevelSelectionBloc, LevelSelectionState>(
          builder: (context, state) {
        return SafeArea(
          child: Container(
            color: kPrimaryColor,
            child: Column(
              children: <Widget>[
                LogoHeader(),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 10.0),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                      ),
                      gradient: _gradient,
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: AutoSizeText(
                            '${_levelName == null ? '' : _levelName.toUpperCase()}',
                            style: TextStyle(
                                fontFamily: 'Staatliches',
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        _buildItemsList(_levelList),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildItemsList(List<bool> items) {
    if (items != null) {
      return Expanded(
        flex: 1,
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.61,
          child: GridView.count(
              primary: false,
              crossAxisCount: 3,
              children: List.generate(items.length, (index) {
                return GestureDetector(
                  onTap: () {
                    MediaPlayer.loadPlayAudio(0);
                    if (items[index]) {
                      Navigator.pushReplacementNamed(context, GameEndScreen.id,
                          arguments: ScreenArguments(
                              levelName: _levelName.toLowerCase(),
                              index: index + 1,
                              isPlayed: false));
                    } else {
                      Navigator.pushNamed(context, MainBoard.id,
                          arguments: ScreenArguments(
                              levelName: _levelName.toLowerCase(),
                              index: index));
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        color: items[index] == true
                            ? Color(0xFF006360)
                            : Color(0xFF003D4D),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 30.0,
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                            child: Center(
                          child: AutoSizeText(
                            'Level ${index + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Viga',
                                decoration: TextDecoration.none),
                            maxLines: 1,
                          ),
                        )),
                        Positioned(
                          right: 0.0,
                          child: Visibility(
                            visible: items[index],
                            child: Image(
                              image: AssetImage('assets/images/ic_played.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              })),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(10.0),
        width: double.maxFinite,
      );
    }
  }

  void getArguments() {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    _levelName = EnumToString.parse(args.levelTYPE);
    getGradient(_levelName);
    _levelselectionBloc.add(
        LevelListEvent(context: context, levelName: _levelName.toLowerCase()));
    Analytics.logEventWithParameter(
        'choose_level', 'level', _levelName.toLowerCase());
  }

  void getGradient(String levelName) {
    switch (levelName) {
      case 'EASY':
        _gradient = kEasyLevelGrad;
        break;
      case 'MEDIUM':
        _gradient = kMediumLevelGrad;
        break;
      case 'HARD':
        _gradient = kHardLevelGrad;
        break;
      case 'EXPERT':
        _gradient = kExpertLevelGrad;
        break;
    }
  }
}
