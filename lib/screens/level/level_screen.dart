import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class LevelScreen extends StatelessWidget {
  static final String id = 'level_screen';
  final double sizedBoxHeight = 25.0;

  @override
  Widget build(BuildContext context) {
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
                      text: 'EASY',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'MEDIUM',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF1E9FFE), Color(0xFF4F5FFE)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'HARD',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFA193FF), Color(0xFF6442FD)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
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
          ],
        ),

//
      ),
    );
  }
}
