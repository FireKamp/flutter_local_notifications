import 'package:flutter/material.dart';

class GradientLine extends StatelessWidget {
  final Gradient gradient;

  GradientLine({this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 3.0,
      margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
      decoration: new BoxDecoration(
        gradient: gradient,
      ),
    );
  }
}
