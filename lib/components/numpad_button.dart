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
          width: 40.0,
          height: 40.0,
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2.0, color: Color(kNumPadBorder))),
          child: Center(
            child: Text(
              '$value',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Color(kNumPadBorder),
                  fontWeight: FontWeight.bold),
            ),
          )),
    );
  }
}
