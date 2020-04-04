import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class EveryButtonButton extends StatefulWidget {
  final Function(bool) onClick;
  bool defaultValue;

  EveryButtonButton({@required this.onClick, this.defaultValue});

  @override
  _EveryButtonButtonState createState() => _EveryButtonButtonState();
}

class _EveryButtonButtonState extends State<EveryButtonButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.defaultValue == true) {
            widget.defaultValue = false;
          } else {
            widget.defaultValue = true;
          }
        });

        widget.onClick(widget.defaultValue);
      },
      child: Container(
        color: Color(0xFF71658B),
        height: 60.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: AutoSizeText(
                'Every Day',
                style: TextStyle(
                    fontSize: 20.0, color: Colors.white, fontFamily: 'Rubik'),
              ),
            ),
            Spacer(),
            Visibility(
                visible: widget.defaultValue,
                child: Icon(Icons.check, size: 30.0))
          ],
        ),
      ),
    );
  }
}
