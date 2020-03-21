import 'package:flutter/material.dart';

class PanelButton extends StatefulWidget {
  final int value;
  final Function(int) onClick;
  final IconData icon;
  final Color color;

  PanelButton(
      {@required this.value,
      @required this.icon,
      this.color,
      @required this.onClick});

  @override
  _PanelButtonState createState() => _PanelButtonState();
}

class _PanelButtonState extends State<PanelButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        widget.icon,
        color: widget.color,
      ),
      onPressed: () {
        widget.onClick(widget.value);
      },
    );
  }
}
