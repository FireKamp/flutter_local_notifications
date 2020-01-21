// counter_page.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Count extends StatelessWidget {
  final Function(int) onCountChange;
  final Color activeColor;
  final Color inactiveColor;

  Count(
      {Key key,
      @required this.onCountChange,
      this.activeColor,
      this.inactiveColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      margin: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.update,
              color: activeColor,
            ),
            onPressed: () {
              onCountChange(2);
            },
          ),
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              onCountChange(3);
            },
          ),
        ],
      ),
    );
  }
}


