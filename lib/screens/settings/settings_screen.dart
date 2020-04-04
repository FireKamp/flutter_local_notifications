import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/notification_settings_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

class SettingsScreen extends StatefulWidget {
  static final String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final double spaceBTText = 15.0;

  bool _isSoundsOn;
  bool _isHapticsOn;
  bool _isHideDuplicates;
  bool _isMistakeLimit;
  bool _isHighDuplicates;
  bool _isNotificationEnabled;

  @override
  Widget build(BuildContext context) {
    getData();
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
                            context, NotificationsSettingsScreen.id,
                            arguments: ScreenArguments(
                                isNotiEnabled: _isNotificationEnabled));
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
                      defaultValue: _isSoundsOn,
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(LocalDB.keyTurnOnSound, value);
                      },
                      text: 'Turn On Sounds',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      defaultValue: _isHapticsOn,
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(LocalDB.keyTurnOnHaptics, value);
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
                      defaultValue: _isHideDuplicates,
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(LocalDB.keyHideDuplicate, value);
                      },
                      text: 'Hide Duplicates',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      defaultValue: _isMistakeLimit,
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(LocalDB.keyMistakeLimit, value);
                      },
                      text: 'Mistake Limit',
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    SettingsItem(
                      defaultValue: _isHighDuplicates,
                      isArrow: false,
                      onChanged: (bool value) {
                        updateLocalDB(LocalDB.keyHighDuplicate, value);
                      },
                      text: 'Highlight Duplicates',
                    ),
                    SizedBox(
                      height: 60.0,
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

  void getData() async {
    print('getData');
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    _isSoundsOn = args.isSoundsOn;
    _isHapticsOn = args.isHapticsOn;
    _isMistakeLimit = args.isMistakeLimit;
    _isHighDuplicates = args.isHighDuplicates;
    _isHideDuplicates = args.isHideDuplicates;

    _isNotificationEnabled =
        await LocalDB.getBool(LocalDB.keyNotificationAllowed);
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final Function(bool) onChanged;
  final bool isArrow;
  final bool defaultValue;

  SettingsItem(
      {@required this.text,
      @required this.onChanged,
      @required this.isArrow,
      this.defaultValue});

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
            value: defaultValue == null ? false : defaultValue,
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
