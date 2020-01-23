import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {
        onClick(value);
      },
    );
  }
}
