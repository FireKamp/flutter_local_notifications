import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class NumPadButton extends StatelessWidget {
  final int value;
  final Function(int) onClick;

  NumPadButton({@required this.value, @required this.onClick});

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
          child: Center(
            child: getWidget(value),
          )),
    );
  }

  Widget getWidget(int value) {
    if (value == 10) {
      return Image(
        image: AssetImage('assets/images/ic_stars.png'),
      );
    } else {
      return AutoSizeText(
        '$value',
        style: TextStyle(
            fontFamily: 'Staatliches',
            fontSize: 23.0,
            color: Color(kNumPadBorder),
            fontWeight: FontWeight.w900),
      );
    }
  }
}
