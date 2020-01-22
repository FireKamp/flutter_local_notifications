import 'package:flutter/material.dart';

import 'numpad_button.dart';

class NumPad extends StatelessWidget {
  final List<int> values;
  final double marginTop;
  final double marginRight;
  final double marginBottom;
  final double marginLeft;
  final MainAxisAlignment mainAxisAlignment;
  final Function(int) onValueChanged;

  NumPad(
      {@required this.values,
      this.marginBottom,
      this.marginLeft,
      this.marginRight,
      this.marginTop,
      this.mainAxisAlignment,
      @required this.onValueChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: marginTop,
          right: marginRight,
          left: marginLeft,
          bottom: marginBottom),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: generateButtons(values),
      ),
    );
  }

  List<Widget> generateButtons(List<int> values) {
    List<Widget> list = [];
    for (int i = 0; i < values.length; i++) {
      list.add(
        NumPadButton(
          value: values[i],
          onClick: (int val) {
            onValueChanged(val);
          },
        ),
      );
    }
    return list;
  }
}
