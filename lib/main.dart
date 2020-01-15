import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/board/bloc.dart';
import 'package:sudoku_brain/utils/Constants.dart';

import 'board/board_screen.dart';

void main() => runApp(new MyApp());

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
