import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class SingleButton extends StatefulWidget {
  final String text;
  final Function(bool) onClick;
  bool defaultValue;
  bool isAllDayEnabled;

  SingleButton(
      {@required this.text,
      @required this.onClick,
      this.defaultValue,
      this.isAllDayEnabled});

  @override
  _SingleButtonState createState() => _SingleButtonState();
}

class _SingleButtonState extends State<SingleButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isAllDayEnabled) {
          setState(() {
            if (widget.defaultValue) {
              widget.defaultValue = false;
            } else {
              widget.defaultValue = true;
            }
          });
          widget.onClick(widget.defaultValue);
        }
      },
      child: Container(
        color: Color(0xFF71658B),
        height: 60.0,
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 25.0),
              child: AutoSizeText(
                'Every ${widget.text}',
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
