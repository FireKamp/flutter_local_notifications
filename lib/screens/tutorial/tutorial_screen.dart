import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class TutorialScreen extends StatelessWidget {
  static final String id = 'tutorial_screen';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            text: 'HELP',
            color: Color(0xFFE2297E),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
