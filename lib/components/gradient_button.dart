import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class RaisedGradientButton extends StatelessWidget {
  final Gradient gradient;
  final Gradient circleGradient;
  final double width;
  final double height;
  final Function onPressed;
  final String text;
  final String icon;
  final Color shadowColor;

  const RaisedGradientButton(
      {Key key,
      this.gradient,
      this.circleGradient,
      this.shadowColor,
      this.width = double.infinity,
      this.height = 50.0,
      this.onPressed,
      this.text,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 80.0,
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: gradient,
          boxShadow: [
            BoxShadow(
              color: kPrimaryColor,
              offset: Offset(0.0, 1.5),
              blurRadius: 1.5,
            ),
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: ListTile(
            title: Center(
              child: Text(
                text,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Staatliches',
                    fontSize: 28.0),
              ),
            ),
            leading: circleGradient == null
                ? null
                : Container(
                    height: double.infinity,
                    decoration: new BoxDecoration(
                      gradient: circleGradient,
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          blurRadius: 1.5,
                        ),
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: Image(
                      image: AssetImage(icon),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
