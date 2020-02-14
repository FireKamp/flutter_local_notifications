import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';
import 'package:sudoku_brain/screens/help/bloc.dart';
import 'package:sudoku_brain/screens/help/help_screen.dart';
import 'package:sudoku_brain/screens/home/bloc.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
import 'package:sudoku_brain/screens/level/bloc.dart';
import 'package:sudoku_brain/screens/level/level_screen.dart';
import 'package:sudoku_brain/screens/settings/bloc.dart';
import 'package:sudoku_brain/screens/settings/settings_screen.dart';
import 'package:sudoku_brain/screens/tutorial/bloc.dart';
import 'package:sudoku_brain/screens/tutorial/tutorial_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
      ),
      initialRoute: SettingsScreen.id,
      routes: {
        HomeScreen.id: (context) => BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(),
            ),
        MainBoard.id: (context) => BlocProvider<MainBoardBloc>(
              create: (BuildContext context) => MainBoardBloc(),
              child: MainBoard(),
            ),
        LevelScreen.id: (context) => BlocProvider<LevelBloc>(
              create: (BuildContext context) => LevelBloc(),
              child: LevelScreen(),
            ),
        HelpScreen.id: (context) => BlocProvider<HelpBloc>(
              create: (BuildContext context) => HelpBloc(),
              child: HelpScreen(),
            ),
        TutorialScreen.id: (context) => BlocProvider<TutorialBloc>(
              create: (BuildContext context) => TutorialBloc(),
              child: TutorialScreen(),
            ),
        SettingsScreen.id: (context) => BlocProvider<SettingsBloc>(
              create: (BuildContext context) => SettingsBloc(),
              child: SettingsScreen(),
            ),
      },
    );
  }
}
