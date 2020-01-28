// counter_page.dart
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/panel_button.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class Panel extends StatefulWidget {
  final Function(int) onSegmentChange;

  Panel({@required this.onSegmentChange});

  @override
  _PanelState createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  final List<IconData> _icons = [
    Icons.fullscreen,
    Icons.delete,
    Icons.refresh,
    Icons.lightbulb_outline,
    Icons.edit
  ];

  List<Color> _selectedImageColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white
  ];

  int _segmentedControlValue = -1;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(140.0),
      child: Container(
        color: Color(kPanelBg),
        margin: EdgeInsets.fromLTRB(40.0, 20.0, 40.0, 10.0),
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: generateIcons(),
        ),
      ),
    );
  }

  List<Widget> generateIcons() {
    List<Widget> list = [];

    for (int i = 0; i < _icons.length; i++) {
      list.add(
        PanelButton(
          value: i,
          icon: _icons[i],
          color: _selectedImageColor[i],
          onClick: (int val) {
            _segmentedControlValue = i;
            print('val: $val');
            setState(() {
              widget.onSegmentChange(val);
              changeSelectionColor();
            });
          },
        ),
      );
    }
    return list;
  }

  void changeSelectionColor() {
    for (int i = 0; i < _selectedImageColor.length; i++) {
      if (_segmentedControlValue == i) {
        _selectedImageColor[i] = kBoardCellSelected;
      } else {
        _selectedImageColor[i] = Colors.white;
      }
    }
  }
}
