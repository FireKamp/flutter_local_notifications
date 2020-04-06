import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
import 'package:sudoku_brain/screens/notifications/dayselection/dayselection_screen.dart';
import 'package:sudoku_brain/screens/notifications/timeselection/bloc.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class NotificationTimeSelection extends StatefulWidget {
  static String id = 'notification_timeselection_screen';

  @override
  _NotificationTimeSelectionState createState() =>
      _NotificationTimeSelectionState();
}

class _NotificationTimeSelectionState extends State<NotificationTimeSelection> {
  final double sizedBoxHeight = 10.0;
  NotificationTimeSelectionBloc _timeSelectionBloc;
  int _hours = 6;
  int _minutes = 30;
  bool _isBack = false;
  List<Day> _list = [Day.Everyday];

  @override
  void initState() {
    _timeSelectionBloc =
        BlocProvider.of<NotificationTimeSelectionBloc>(context);
    _timeSelectionBloc.add(InitNotification());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getData();
    return BlocListener(
      bloc: BlocProvider.of<NotificationTimeSelectionBloc>(context),
      listener: (BuildContext context, state) {
        if (state is NotiSettingSavedState) {
          _exitScreen();
        }
      },
      child: BlocBuilder<NotificationTimeSelectionBloc,
          NotificatioTimeSelectionState>(builder: (context, state) {
        return Material(
          color: kPrimaryColor,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                  child: ListView(children: <Widget>[
                Column(children: <Widget>[
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: MaterialButton(
                          onPressed: () {
                            _exitScreen();
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontFamily: 'Rubik'),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        alignment: Alignment.topLeft,
                        child: MaterialButton(
                          onPressed: () {
                            if (_list == null || _list.isEmpty) {
                            } else {
                              _timeSelectionBloc.add(SaveNotificationData(
                                  hour: _hours, min: _minutes, list: _list));
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                fontSize: 22.0,
                                color: _list == null || _list.isEmpty
                                    ? Colors.grey
                                    : Colors.white,
                                fontFamily: 'Rubik'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Image.asset(
                    'assets/images/ic_alarm.png',
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Text(
                    kNotiHeader,
                    style: TextStyle(
                        letterSpacing: 1.5,
                        fontSize: 40.0,
                        fontWeight: FontWeight.w400,
                        color: lightYellow,
                        fontFamily: 'Staatliches'),
                  ),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        kNotiTextOne,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rubik'),
                      )),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  _timer(),
                ]),
              ])),
              Positioned(
                bottom: 20.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                  color: Color(0xFF71658B),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _navigateAndDisplaySelection(context);
                        },
                        child: Text(
                          'Repeat',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w200,
                              color: Colors.white,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
//                        Navigator.pushNamed(context, DaySelectionScreen.id);
                          _navigateAndDisplaySelection(context);
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Everyday',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.white,
                                  fontFamily: 'Rubik'),
                            ),
                            Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _timeSelectionBloc.dispose();
    super.dispose();
  }

  Widget _timer() {
    Duration initialTimer = new Duration(hours: _hours, minutes: _minutes);
    return CupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      backgroundColor: kPrimaryColor,
      minuteInterval: 1,
      initialTimerDuration: initialTimer,
      onTimerDurationChanged: (Duration value) {
        List<String> time = value.toString().split(":");

        if (time.isNotEmpty) {
          _hours = int.parse(time[0]);
          _minutes = int.parse(time[1]);
        }
      },
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, DaySelectionScreen.id,
        arguments: ScreenArguments(hour: _hours, min: _minutes));
    _isBack = true;
    if (result != null) {
      ScreenArguments arguments = result;
      _hours = arguments.hour;
      _minutes = arguments.min;

      List<Day> list = List.from(arguments.selectedDays);
      if (list.contains(Day.Everyday)) {
        list.clear();
        list.add(Day.Everyday);
      }
      _list = List.from(list);
    }
  }

  void _getData() {
    if (!_isBack) {
      final ScreenArguments args = ModalRoute.of(context).settings.arguments;

      _hours = args.hour == 0 ? 18 : args.hour;
      _minutes = args.min == 0 ? 30 : args.min;
    }
  }

  void _exitScreen() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushNamed(context, HomeScreen.id);
    }
  }
}
