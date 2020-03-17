// counter_page.dart
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/switch_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class Panel extends StatefulWidget {
  final Function(int, bool) onSegmentChange;
  final bool defaultPencilValue;
  final bool isPaused;
  final int hintValue;

  Panel(
      {@required this.onSegmentChange,
      this.defaultPencilValue,
      this.isPaused,
      this.hintValue});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.isPaused,
      child: Container(
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
              icon: Image(
                image: AssetImage('assets/images/ic_erase.png'),
              ),
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
            IconButton(
              icon: Stack(
                children: <Widget>[
                  Positioned.fill(child: Icon(Icons.lightbulb_outline)),
                  Positioned(
                      right: 4.0,
                      top: 4.0,
                      child: Container(
                        height: 12.0,
                        width: 12.0,
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${widget.hintValue >= 0 ? widget.hintValue : 0}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ))
                ],
              ),
              onPressed: () {
                widget.onSegmentChange(3, false);
              },
            ),
            SwitchButton(
              value: 4,
              defaultPValue: widget.defaultPencilValue,
              iconActive: Icons.edit,
              iconInActive: Icons.edit,
              onClick: (int val, bool isSel) {
                widget.onSegmentChange(val, isSel);
              },
            ),
          ],
        ),
      ),
    );
  }
}
