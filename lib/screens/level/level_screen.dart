import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/components/gradient_button_wi.dart';
import 'package:sudoku_brain/components/logo_header.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/level/bloc.dart';
import 'package:sudoku_brain/screens/levelselection/levelselection_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/Logs.dart';

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
        print('BlocBuilder');
        return SafeArea(
          child: Container(
            color: kPrimaryColor,

            child: ListView(
              children: <Widget>[
                LogoHeader(),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.EASY)}',
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                    ),
                    onPressed: () {
                      print('button clicked');
                      _levelBloc.add(LevelSelected(levelTYPE: LevelTYPE.EASY));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.MEDIUM)}',
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF1E9FFE), Color(0xFF4F5FFE)],
                    ),
                    onPressed: () {
                      _levelBloc
                          .add(LevelSelected(levelTYPE: LevelTYPE.MEDIUM));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButtonWI(
                    text: '${EnumToString.parse(LevelTYPE.HARD)}',
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFA193FF), Color(0xFF6442FD)],
                    ),
                    onPressed: () {
                      _levelBloc.add(LevelSelected(levelTYPE: LevelTYPE.HARD));
                    }),
                SizedBox(
                  height: sizedBoxHeight,
                ),
            RaisedGradientButtonWI(
                      text: '${EnumToString.parse(LevelTYPE.EXPERT)}',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                      ),
                      onPressed: () {
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
