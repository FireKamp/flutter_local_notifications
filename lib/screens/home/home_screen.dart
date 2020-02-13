import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';
  final double sizedBoxHeight = 25.0;
  final double sizedBoxTop = 10.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kPrimaryColor,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/ic_logo.png'),
                  ),
                  SizedBox(
                    height: sizedBoxTop,
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
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  Visibility(
                    visible: true,
                    child: RaisedGradientButton(
                        text: 'CONTINUE',
                        icon: 'assets/images/ic_board.png',
                        gradient: LinearGradient(
                          colors: <Color>[Color(0xFF1E9FFE), Color(0xFF4F5FFE)],
                        ),
                        circleGradient: LinearGradient(
                          colors: <Color>[Color(0xFF8497FF), Color(0xFFBDDAFF)],
                        ),
                        shadowColor: Color(0xFF8497FF),
                        onPressed: () {
                          print('button clicked');
                        }),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
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
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'SETTINGS',
                      icon: 'assets/images/ic_setting.png',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                      ),
                      circleGradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                      shadowColor: Color(0xFF8DFDC4),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'HELP',
                      icon: 'assets/images/ic_help.png',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                      ),
                      circleGradient: LinearGradient(
                        colors: <Color>[Color(0xFFFFC7E7), Color(0xFFFF3AA0)],
                      ),
                      shadowColor: Color(0xFFFFC7E7),
                      onPressed: () {
                        print('button clicked');
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
