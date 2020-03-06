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
          height: MediaQuery.of(context).size.height * 0.06,
          decoration: new BoxDecoration(
              color: Colors.transparent,
              border: Border.all(width: 2.0, color: Color(kNumPadBorder))),
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
      return Text(
        '$value',
        style: TextStyle(
            fontSize: 20.0,
            color: Color(kNumPadBorder),
            fontWeight: FontWeight.bold),
      );
    }
  }
}
