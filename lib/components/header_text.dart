import 'package:flutter/material.dart';

class HeaderText extends StatelessWidget {
  final String text;

  HeaderText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Staatliches',
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.none),
    );
  }
}
