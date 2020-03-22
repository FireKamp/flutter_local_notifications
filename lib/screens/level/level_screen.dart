import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/gradient_button_wi.dart';
import 'package:sudoku_brain/components/logo_header.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/level/bloc.dart';
import 'package:sudoku_brain/screens/levelselection/levelselection_screen.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/Logs.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';

class LevelScreen extends StatefulWidget {
  static final String id = 'level_screen';

  @override
  _LevelScreenState createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  LevelBloc _levelBloc;
  final double sizedBoxHeight = 25.0;

  @override
  void initState() {
    super.initState();
    Analytics.logEvent('screen_levels');

    _levelBloc = BlocProvider.of<LevelBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: BlocProvider.of<LevelBloc>(context),
      listener: (BuildContext context, state) {
        if (state is SelectedLevelState) {
          Logs.printLogs('${EnumToString.parse(state.levelTYPE)}');
          Navigator.pushNamed(context, LevelSelection.id,
              arguments: ScreenArguments(levelTYPE: state.levelTYPE));
        }
      },
      child: BlocBuilder<LevelBloc, LevelState>(builder: (context, state) {
        return SafeArea(
          child: Container(
            color: kPrimaryColor,

            child: ListView(
              children: <Widget>[
                LogoHeader(),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.EASY)}',
                    gradient: kEasyLevelGrad,
                    onPressed: () {
                      MediaPlayer.loadPlayAudio(0);
                      _levelBloc.add(LevelSelected(levelTYPE: LevelTYPE.EASY));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.MEDIUM)}',
                    gradient: kMediumLevelGrad,
                    onPressed: () {
                      MediaPlayer.loadPlayAudio(0);
                      _levelBloc
                          .add(LevelSelected(levelTYPE: LevelTYPE.MEDIUM));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.HARD)}',
                    gradient: kHardLevelGrad,
                    onPressed: () {
                      MediaPlayer.loadPlayAudio(0);
                      _levelBloc.add(LevelSelected(levelTYPE: LevelTYPE.HARD));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.EXPERT)}',
                    gradient: kExpertLevelGrad,
                    onPressed: () {
                      MediaPlayer.loadPlayAudio(0);
                      _levelBloc
                          .add(LevelSelected(levelTYPE: LevelTYPE.EXPERT));
                    }),
              ],
            ),

//
          ),
        );
      }),
    );
  }
}
