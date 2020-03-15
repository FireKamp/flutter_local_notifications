import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/screens/help/help_screen.dart';
import 'package:sudoku_brain/screens/level/level_screen.dart';
import 'package:sudoku_brain/screens/settings/settings_screen.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class HomeScreen extends StatelessWidget {
  static final String id = 'home_screen';
  final double sizedBoxHeight = 25.0;
  final double sizedBoxTop = 10.0;

  @override
  Widget build(BuildContext context) {
    Analytics.logEvent('screen_landing');
    return SafeArea(
      child: Container(
        color: kPrimaryColor,
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
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
            Column(
              children: <Widget>[
                Visibility(
                  visible: false,
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
                      print('New Game');
                      Navigator.pushNamed(context, LevelScreen.id);
                    }),
                Visibility(
                  visible: false,
                  child: RaisedGradientButton(
                      text: 'SETTINGS',
                      icon: 'assets/images/ic_setting_large.png',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                      ),
                      circleGradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                      shadowColor: Color(0xFF8DFDC4),
                      onPressed: () {
                        print('Settings');
                        Navigator.pushNamed(context, SettingsScreen.id);
                      }),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                RaisedGradientButton(
                    text: 'HELP',
                    icon: 'assets/images/ic_help_pink.png',
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                    ),
                    circleGradient: LinearGradient(
                      colors: <Color>[Color(0xFFFFC7E7), Color(0xFFFF3AA0)],
                    ),
                    shadowColor: Color(0xFFFFC7E7),
                    onPressed: () {
                      print('Help');
                      Navigator.pushNamed(context, HelpScreen.id);
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
