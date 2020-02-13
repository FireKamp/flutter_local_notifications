import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final String text;
  final Color color;
  final Gradient gradient;
  final Gradient circleGradient;
  final double width;
  final double height;

  TopContainer({this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        color: color,

        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 30.0),
                  child: Image.asset('assets/images/ic_back.png'),
                ),
                Text(
                  text,
                  style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            Container(
              height: 100.0,
              padding: EdgeInsets.all(10.0),
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFFE23A7),
                    blurRadius: 1.5,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/ic_help.png',
                width: 70.0,
                height: 70.0,
                fit: BoxFit.fitWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
