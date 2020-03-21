import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class NumPadButton extends StatelessWidget {
  final int value;
  final Function(int) onClick;
  final bool isHint;

  NumPadButton({@required this.value, @required this.onClick, this.isHint});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onClick(value);
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.11,
          height: MediaQuery.of(context).size.width * 0.11,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              color: Colors.transparent,
              border: Border.all(width: 1.5, color: Color(kNumPadBorder))),
          child: getWidget(value)),
    );
  }

  Widget getWidget(int value) {
    if (isHint) {
      return Padding(
        padding: EdgeInsets.only(right: 5.0),
        child: ButtonText(
          value: value,
          fontWeight: FontWeight.w100,
          fontSize: 20.0,
          textAlign: TextAlign.right,
        ),
      );
    } else {
      return Center(
        child: ButtonText(
          value: value,
          fontWeight: FontWeight.w600,
          fontSize: 23.0,
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}

class ButtonText extends StatelessWidget {
  final int value;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  ButtonText({this.textAlign, this.value, this.fontWeight, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      '$value',
      textAlign: textAlign,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: fontSize,
          color: Color(kNumPadBorder),
          fontWeight: fontWeight),
    );
  }
}
