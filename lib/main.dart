import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';
import 'package:sudoku_brain/screens/home/bloc.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
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
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => BlocProvider<HomeBloc>(
              create: (BuildContext context) => HomeBloc(),
              child: HomeScreen(),
            ),
        MainBoard.id: (context) => BlocProvider<MainBoardBloc>(
              create: (BuildContext context) => MainBoardBloc(),
              child: MainBoard(),
            ),
      },
    );
  }
}
