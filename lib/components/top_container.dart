import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class TopContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  TopContainer({this.text, this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: kPrimaryColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 30.0),
                    child: Icon(Icons.backspace)),
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 25.0,
                      color: Colors.white,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            Icon(
              icon,
              size: 150.0,
              color: Colors.pink[500],
            )
          ],
        ),
      ),
    );
  }
}