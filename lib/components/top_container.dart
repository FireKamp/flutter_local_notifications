import 'package:flutter/material.dart';

class TopContainer extends StatelessWidget {
  final String text;
  final String imagePath;
  final Color color;
  final Gradient gradient;
  final Gradient circleGradient;
  final double width;
  final double height;

  TopContainer(
      {this.text,
      this.imagePath,
      this.color,
      this.width,
      this.height,
      this.gradient,
      this.circleGradient});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: new BoxDecoration(
          gradient: gradient,
        ),
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
              height: 500.0,
              width: 130.0,
              padding: EdgeInsets.all(30.0),
              decoration: new BoxDecoration(
                gradient: circleGradient,
                boxShadow: [
                  BoxShadow(
                    color: color,
                    blurRadius: 1.5,
                  ),
                ],
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                imagePath,
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
