import 'package:flutter/material.dart';

class SwitchButton extends StatefulWidget {
  final int value;
  final Function(int, bool) onClick;
  final IconData iconActive;
  final IconData iconInActive;
  final Color color;

  SwitchButton(
      {@required this.value,
      @required this.iconActive,
      @required this.iconInActive,
      this.color,
      @required this.onClick});

  @override
  _SwitchButtonState createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isSelected == true ? widget.iconActive : widget.iconInActive,
        color: _isSelected == true ? Colors.blue[200] : Colors.white,
      ),
      onPressed: () {
        setState(() {
          if (_isSelected) {
            _isSelected = false;
          } else {
            _isSelected = true;
          }
        });

        widget.onClick(widget.value, _isSelected);
      },
    );
  }
}
