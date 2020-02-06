import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';
import 'package:sudoku_brain/test.dart';
import 'package:sudoku_brain/utils/Constants.dart';

void main() => runApp(Test());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(kPrimaryColor),
        scaffoldBackgroundColor: Color(kPrimaryColor),
      ),
      initialRoute: MainBoard.id,
      routes: {
        MainBoard.id: (context) => BlocProvider<MainBoardBloc>(
              create: (BuildContext context) => MainBoardBloc(),
              child: MainBoard(),
            ),
      },
    );
  }
}
