import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class TutorialScreen extends StatelessWidget {
  static final String id = 'tutorial_screen';
  final double spaceBTText = 15.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            text: 'HELP',
            imagePath: 'assets/images/ic_help_orange.png',
            gradient: LinearGradient(
              colors: <Color>[Color(0xFFFC8D4A), Color(0xFFFE3E16)],
            ),
            circleGradient: LinearGradient(
              colors: <Color>[Color(0xFFFFC8AD), Color(0xFFFF7154)],
            ),
            color: Color(0xFFFFC8AD),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: spaceBTText,
                    ),
                    Text(
                      'TUTORIAL',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Staatliches',
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                          decoration: TextDecoration.none),
                    ),
                    GradientLine(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFC8D4A), Color(0xFFFE3E16)],
                      ),
                    ),
                    HeaderText(
                      text: kTutHeadOne,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialWIOne,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialWITwo,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    HeaderText(
                      text: kTutHeadTwo,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialHTPOne,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialHTPTwo,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialHTPThree,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    HeaderText(
                      text: kTutHeadThree,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SmallText(
                      text: kTutorialGFB,
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  SmallText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 15.0,
          color: Colors.white,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.none),
    );
  }
}

