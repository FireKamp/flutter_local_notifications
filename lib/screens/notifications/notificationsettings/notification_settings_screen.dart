import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/gradient_line.dart';
import 'package:sudoku_brain/components/header_text.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/bloc.dart';
import 'package:sudoku_brain/screens/notifications/timeselection/notificatio_time_selection_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';
import 'package:sudoku_brain/utils/NotificationManager.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  static final String id = 'noti_settings_screen';

  @override
  _NotificationsSettingsScreenState createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  final double spaceBTText = 15.0;
  String _time = '00:00';
  bool _isAllowed = false;
  int hour = 0;
  int min = 0;

  NotificationSettingBloc _settingBloc;

  @override
  void initState() {
    _settingBloc = BlocProvider.of<NotificationSettingBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _settingBloc.add(FetchNotificationData());
    return BlocListener(
      bloc: BlocProvider.of<NotificationSettingBloc>(context),
      listener: (BuildContext context, state) {
        if (state is NotificationDataState) {
          _isAllowed = state.isAllowed;

          if (state.hour != null && state.min != null) {
            _time = '${state.hour}:${state.min}';

            hour = state.hour;
            min = state.min;
          }
        }
      },
      child: BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
          builder: (context, state) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              TopContainer(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'NOTIFICATIONS SETTINGS',
                imagePath: 'assets/images/ic_bell.png',
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFFFD746C), Color(0xFFCC2C23)],
                ),
                circleGradient: LinearGradient(
                  colors: <Color>[Color(0xFFFD746C), Color(0xFFFF554B)],
                ),
                color: Color(0xFFFD746C),
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
                          text: 'Set Reminders',
                        ),
                        GradientLine(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF8DFDC4),
                              Color(0xFF32C6A2)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SettingsItem(
                          defaultValue: _isAllowed,
                          onChanged: (bool value) {
                            if (value == true) {
                              NotificationManager.requestPermissions().then((onValue) {
                                print("Permissions set from settings: $onValue");
                              });
                            }
                            updateLocalDB(
                                LocalDB.keyNotificationAllowed, value);
                          },
                          text: 'Turn On Notifications',
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        HeaderText(
                          text: 'SELECT TIME',
                        ),
                        GradientLine(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF8DFDC4),
                              Color(0xFF32C6A2)
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, NotificationTimeSelection.id,
                                arguments:
                                    ScreenArguments(hour: hour, min: min));
                          },
                          child: Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  AutoSizeText(
                                    _time,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 35.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w100),
                                  ),
                                  AutoSizeText(
                                    'Every day',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 13.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.none,
                                        fontWeight: FontWeight.w100),
                                  )
                                ],
                              ),
                              Spacer(),
                              Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void updateLocalDB(String key, bool value) {
    LocalDB.setBool(key, value);
  }
}

class SettingsItem extends StatelessWidget {
  final String text;
  final Function(bool) onChanged;
  final bool defaultValue;

  SettingsItem(
      {@required this.text, @required this.onChanged, this.defaultValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SmallText(
          text: text,
        ),
        CustomSwitch(
          activeColor: Color(0xFF0AB8AD),
          value: defaultValue,
          onChanged: (value) {
            onChanged(value);
          },
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
