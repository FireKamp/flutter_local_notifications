import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_button.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class HelpScreen extends StatelessWidget {
  static final String id = 'help_screen';
  final double sizedBoxHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            onPressed: (){

            },
            imagePath: 'assets/images/ic_help_pick.orange/',
            text: 'HELP',
            color: kPrimaryColor,
            gradient: LinearGradient(
              colors: <Color>[kPrimaryColor, kPrimaryColor],
            ),
            circleGradient: LinearGradient(
              colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: kPrimaryColor,
              child: Column(
                children: <Widget>[
                  RaisedGradientButton(
                      text: 'TUTORIAL',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFABB69), Color(0xFFFE3E16)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'CONTACT US',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF82FFF4), Color(0xFF05AB9C)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButton(
                      text: 'TERMS OF USE',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFBEE4FF), Color(0xFF1E9FFE)],
                      ),
                      onPressed: () {
                        print('button clicked');
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
