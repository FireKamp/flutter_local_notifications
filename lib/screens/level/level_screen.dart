import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class LevelScreen extends StatelessWidget {
  static final String id = 'level_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/ic_logo.png'),
            ),
            RaisedGradientButton(
                text: 'EASY',
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                ),
                onPressed: () {
                  print('button clicked');
                }),
            RaisedGradientButton(
                text: 'MEDIUM',
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF1E9FFE), Color(0xFF4F5FFE)],
                ),
                onPressed: () {
                  print('button clicked');
                }),
            RaisedGradientButton(
                text: 'HARD',
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFA193FF), Color(0xFF6442FD)],
                ),
                onPressed: () {
                  print('button clicked');
                }),
            RaisedGradientButton(
                text: 'EXPERT',
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                ),
                onPressed: () {
                  print('button clicked');
                }),
          ],
        ),
      ),
    );
  }
}
