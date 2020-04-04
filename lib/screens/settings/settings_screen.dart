import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/notification_settings_screen.dart';
import 'package:sudoku_brain/screens/notifications/timeselection/notificatio_time_selection_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class SettingsScreen extends StatelessWidget {
  static final String id = 'settings_screen';

  final double spaceBTText = 15.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            onPressed: () {
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
                      text: 'Notifications',
                    ),
                    GradientLine(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                    ),
                    SizedBox(
                      height: spaceBTText,
                    ),
                    SettingsItem(
                      isArrow: true,
                      onChanged: (bool value) {
                        Navigator.pushNamed(
                            context, NotificationsSettingsScreen.id);
                      },
                      text: 'Turn on Notifications',
                    ),
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
                    SizedBox(
                      height: 10.0,
                    ),
                    SettingsItem(
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(turn_on_sound, value);
                      },
                      text: 'Turn On Sounds',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(turn_on_haptics, value);
                      },
                      text: 'Turn On Haptics',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    HeaderText(
                      text: 'GAME SETTINGS',
                    ),
                    GradientLine(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF8DFDC4), Color(0xFF32C6A2)],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    SettingsItem(
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(hide_duplicate, value);
                      },
                      text: 'Hide Duplicates',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(mistake_limit, value);
                      },
                      text: 'Mistake Limit',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(highlight_duplicate, value);
                      },
                      text: 'Highlight Duplicates',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateLocalDB(String key, bool value) {
    LocalDB.setBool(key, value);
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final Function(bool) onChanged;
  final bool isArrow;

  SettingsItem(
      {@required this.text, @required this.onChanged, @required this.isArrow});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SmallText(
          text: text,
        ),
        Spacer(),
        Visibility(
          visible: !isArrow,
          child: CustomSwitch(
            activeColor: Color(0xFF0AB8AD),
            value: false,
            onChanged: (value) {
              onChanged(value);
            },
          ),
        ),
        Visibility(
          visible: isArrow,
          child: GestureDetector(
            onTap: () {
              onChanged(true);
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        )
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
