import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:xlive_switch/xlive_switch.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = 'settings_screen';

  final double spaceBTText = 15.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            onPressed: (){
              Navigator.pop(context);
            },
            text: 'SETTINGS',
            imagePath: 'assets/images/ic_setting_large.png',
            gradient: LinearGradient(
              colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
            ),
            circleGradient: LinearGradient(
              colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
            ),
            color: Color(0xFF8DFDC4),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: spaceBTText,
                    ),
                    HeaderText(
                      text: 'Sounds & Haptics',
                    ),
                    GradientLine(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                    ),
                    SettingsItem()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SmallText(
          text: 'Turn On Sounds',
        ),
        XlivSwitch(
          unActiveColor: Color(0xFFD0D0D0),
          activeColor: Color(0xFF0AB8AD),
          value: false,
          onChanged: (bool val) {},
        ),
      ],
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;

  SmallText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 14.0,
          color: Colors.white,
          fontWeight: FontWeight.w200,
          decoration: TextDecoration.none),
    );
  }
}
