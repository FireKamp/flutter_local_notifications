import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/level/bloc.dart';
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
          Navigator.pushNamed(context, MainBoard.id,
              arguments: ScreenArguments(levelTYPE: state.levelTYPE));
        }
      },
      child: BlocBuilder<LevelBloc, LevelState>(builder: (context, state) {
        print('BlocBuilder');
        return SafeArea(
          child: Container(
            color: kPrimaryColor,

            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Row(
                    children: <Widget>[
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          print('back level');
                          Navigator.pop(context);
                        },
                        child: Image(
                          image: AssetImage('assets/images/ic_back.png'),
                        ),
                      ),
                      Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                      Spacer(),
                      Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    children: <Widget>[
                      RaisedGradientButton(
                          text: '${EnumToString.parse(LevelTYPE.EASY)}',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF91E786),
                              Color(0xFF0AB8AD)
                            ],
                          ),
                          onPressed: () {
                            print('button clicked');
                            _levelBloc
                                .add(LevelSelected(levelTYPE: LevelTYPE.EASY));
                          }),
                      SizedBox(
                        height: sizedBoxHeight,
                      ),
                      RaisedGradientButton(
                          text: '${EnumToString.parse(LevelTYPE.MEDIUM)}',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF1E9FFE),
                              Color(0xFF4F5FFE)
                            ],
                          ),
                          onPressed: () {
                            _levelBloc.add(
                                LevelSelected(levelTYPE: LevelTYPE.MEDIUM));
                          }),
                      SizedBox(
                        height: sizedBoxHeight,
                      ),
                      RaisedGradientButton(
                          text: '${EnumToString.parse(LevelTYPE.HARD)}',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFA193FF),
                              Color(0xFF6442FD)
                            ],
                          ),
                          onPressed: () {
                            _levelBloc
                                .add(LevelSelected(levelTYPE: LevelTYPE.HARD));
                          }),
                      SizedBox(
                        height: sizedBoxHeight,
                      ),
                      RaisedGradientButton(
                          text: '${EnumToString.parse(LevelTYPE.EXPERT)}',
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFFFE23A7),
                              Color(0xFFE2297E)
                            ],
                          ),
                          onPressed: () {
                            _levelBloc.add(
                                LevelSelected(levelTYPE: LevelTYPE.EXPERT));
                          }),
                    ],
                  ),
                ),
              ],
            ),

//
          ),
        );
      }),
    );
  }
}
