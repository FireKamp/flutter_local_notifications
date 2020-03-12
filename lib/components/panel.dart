// counter_page.dart
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/switch_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class Panel extends StatefulWidget {
  final Function(int, bool) onSegmentChange;

  Panel({@required this.onSegmentChange});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.height * 0.05,
          MediaQuery.of(context).size.height * 0.02,
          MediaQuery.of(context).size.height * 0.05,
          MediaQuery.of(context).size.height * 0.01),
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
      decoration: BoxDecoration(
        color: Color(kPanelBg),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SwitchButton(
            value: 0,
            iconActive: Icons.fullscreen_exit,
            iconInActive: Icons.fullscreen,
            onClick: (int val, bool isSel) {
              widget.onSegmentChange(val, isSel);
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              widget.onSegmentChange(1, false);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              widget.onSegmentChange(2, false);
            },
          ),
          SwitchButton(
            value: 3,
            iconActive: Icons.lightbulb_outline,
            iconInActive: Icons.lightbulb_outline,
            onClick: (int val, bool isSel) {
              widget.onSegmentChange(val, isSel);
            },
          ),
          SwitchButton(
            value: 4,
            iconActive: Icons.edit,
            iconInActive: Icons.edit,
            onClick: (int val, bool isSel) {
              widget.onSegmentChange(val, isSel);
            },
          ),
        ],
      ),
    );
  }
}
