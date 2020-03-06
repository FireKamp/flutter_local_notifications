import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class GameEndScreen extends StatelessWidget {
  static String id = 'game_end';
  final bool isGameEnded = false;

//  GameEndScreen({this.isGameEnded});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kPrimaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .13),
              child: GradientText('EASY',
                  gradient: LinearGradient(colors: [
                    Color(0xFF71DC8F),
                    Color(0xFF0BB9AD),
                  ]),
                  style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 53.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
            ),
            CommonText(
              text: 'Level 1',
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05),
              child: Image(
                image: AssetImage('assets/images/ic_win.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  bottom: MediaQuery.of(context).size.height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CommonText(
                    text: isGameEnded == true ? 'Total Time' : 'Best Time',
                  ),
                  CommonText(
                    text: '20:45',
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isGameEnded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CommonText(
                    text: 'New Best Time',
                  ),
                  CommonText(
                    text: '20:45',
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .04),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                color: Color(0xFF7EC1FF),
                child: Text(isGameEnded == true ? 'NEXT' : 'PLAY AGAIN',
                    style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 30.0,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommonText extends StatelessWidget {
  final String text;

  CommonText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.w100,
          decoration: TextDecoration.none),
    );
  }
}
