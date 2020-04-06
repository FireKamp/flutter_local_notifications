import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/help/help_screen.dart';
import 'package:sudoku_brain/screens/home/bloc.dart';
import 'package:sudoku_brain/screens/level/level_screen.dart';
import 'package:sudoku_brain/screens/settings/settings_screen.dart';
import 'package:sudoku_brain/utils/AdManager.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';

class HomeScreen extends StatefulWidget {
  static final String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  final double _sizedBoxHeight = 25.0;
  final double _sizedBoxTop = 10.0;

  HomeBloc _homeBloc;
  bool _isBoardPaused;
  bool _isSoundsOn;
  bool _isHapticsOn;
  bool _isHideDuplicates;
  bool _isMistakeLimit;
  bool _isHighDuplicates;
  String _levelName;
  int _levelNumber;
  int _levelTime;

  @override
  void initState() {
    print('initState');
    AdManager.showBannerAd();
    _homeBloc = BlocProvider.of<HomeBloc>(context);

    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    _homeBloc.add(FetchPauseBoard());

    Analytics.logEvent('screen_landing');
    return BlocListener(
      bloc: BlocProvider.of<HomeBloc>(context),
      listener: (BuildContext context, state) {
        if (state is FetchedPausedState) {
          _isBoardPaused = state.isPaused;
          _levelName = state.levelName;
          _levelNumber = state.levelNumber;
          _levelTime = state.levelTime;
          _isSoundsOn = state.isSoundsOn;
          _isHapticsOn = state.isHapticsOn;
          _isMistakeLimit = state.isMistakeLimit;
          _isHideDuplicates = state.isHideDuplicates;
          _isHighDuplicates = state.isHighDuplicates;
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return SafeArea(
          child: Container(
            color: kPrimaryColor,
            child: ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('assets/images/ic_logo.png'),
                      ),
                      SizedBox(
                        height: _sizedBoxTop,
                      ),
                      Image(
                        image: AssetImage('assets/images/header.png'),
                      ),
                      SizedBox(
                        height: 7.0,
                      ),
                      Image(
                        image: AssetImage('assets/images/subheader.png'),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Visibility(
                      visible: _isBoardPaused == null ? false : _isBoardPaused,
                      child: RaisedGradientButton(
                          text: 'CONTINUE',
                          icon: 'assets/images/ic_board.png',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF1E9FFE),
                              Color(0xFF4F5FFE)
                            ],
                          ),
                          circleGradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF8497FF),
                              Color(0xFFBDDAFF)
                            ],
                          ),
                          shadowColor: Color(0xFF8497FF),
                          onPressed: () {
                            MediaPlayer.loadPlayAudio(
                                SoundValues.getEnum(Sounds.BUTTON_TAP));
                            Navigator.pushReplacementNamed(
                                context, MainBoard.id,
                                arguments: ScreenArguments(
                                    levelName: _levelName.toLowerCase(),
                                    index: _levelNumber,
                                    pausedLevelTime: _levelTime,
                                    isContinued: true));
                          }),
                    ),
                    SizedBox(
                      height: _sizedBoxHeight,
                    ),
                    RaisedGradientButton(
                        text: 'NEW GAME',
                        icon: 'assets/images/pencil.png',
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFFA193FF), Color(0xFF6442FD)],
                        ),
                        circleGradient: LinearGradient(
                          colors: <Color>[Color(0xFFB9ACFF), Color(0xFF6B4CFD)],
                        ),
                        shadowColor: Color(0xFFB9ACFF),
                        onPressed: () {
                          MediaPlayer.loadPlayAudio(
                              SoundValues.getEnum(Sounds.BUTTON_TAP));
                          Navigator.pushNamed(context, LevelScreen.id);
                        }),
                    SizedBox(
                      height: _sizedBoxHeight,
                    ),
                    Visibility(
                      visible: true,
                      child: RaisedGradientButton(
                          text: 'SETTINGS',
                          icon: 'assets/images/ic_setting_large.png',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF91E786),
                              Color(0xFF0AB8AD)
                            ],
                          ),
                          circleGradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF8DFDC4),
                              Color(0xFF32C6A2)
                            ],
                          ),
                          shadowColor: Color(0xFF8DFDC4),
                          onPressed: () {
                            MediaPlayer.loadPlayAudio(
                                SoundValues.getEnum(Sounds.BUTTON_TAP));
                            Navigator.pushNamed(context, SettingsScreen.id,
                                arguments: ScreenArguments(
                                    isSoundsOn: _isSoundsOn,
                                    isHapticsOn: _isHapticsOn,
                                    isMistakeLimit: _isMistakeLimit,
                                    isHighDuplicates: _isHighDuplicates,
                                    isHideDuplicates: _isHideDuplicates));
                          }),
                    ),
                    SizedBox(
                      height: _sizedBoxHeight,
                    ),
                    RaisedGradientButton(
                        text: 'HELP',
                        icon: 'assets/images/ic_help_pink.png',
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                        ),
                        circleGradient: LinearGradient(
                          colors: <Color>[Color(0xFFFFC7E7), Color(0xFFFF3AA0)],
                        ),
                        shadowColor: Color(0xFFFFC7E7),
                        onPressed: () {
                          MediaPlayer.loadPlayAudio(
                              SoundValues.getEnum(Sounds.BUTTON_TAP));
                          Navigator.pushNamed(context, HelpScreen.id);
                        }),
                    SizedBox(
                      height: 60.0,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      AdManager.stopBannerRefresh();
    } else if (state == AppLifecycleState.resumed) {
      AdManager.resumeBannerRefresh();
    }
  }
}
