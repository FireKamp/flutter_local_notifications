import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sudoku_brain/components/everyday_button.dart';
import 'package:sudoku_brain/components/singleday_button.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/notifications/dayselection/bloc.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Strings.dart';

class DaySelectionScreen extends StatefulWidget {
  static String id = 'day_selection_screen';

  @override
  _DaySelectionScreenState createState() => _DaySelectionScreenState();
}

class _DaySelectionScreenState extends State<DaySelectionScreen> {
  List<bool> selectedDays = [false, false, false, false, false, false, false];
  List<Day> _listSelection = List();
  bool _isEverydayEnabled = false;
  bool _isEverydayDefault = false;
  int _hours = 0;
  int _minutes = 0;

  NotidayselectionBloc _notidayselectionBloc;

  @override
  void initState() {
    _notidayselectionBloc = BlocProvider.of<NotidayselectionBloc>(context);
    super.initState();
    _notidayselectionBloc.add(GetSelectedDays());
  }

  @override
  Widget build(BuildContext context) {
    _getScreenData();

    return BlocListener(
      bloc: BlocProvider.of<NotidayselectionBloc>(context),
      listener: (BuildContext context, state) {
        if (state is NotidayselectedListState) {
          if (state.list != null || state.list.isNotEmpty) {
            List<int> list = List.from(state.list);
            for (int i = 0; i < list.length; i++) {
              switch (list[i]) {
                case 8:
                  _updateList(true, Day.Everyday);
                  _isEverydayDefault = true;
                  _isEverydayEnabled = true;
                  break;
                case 1:
                  selectedDays[6] = true;
                  _updateList(true, Day.Sunday);
                  break;
                case 2:
                  selectedDays[0] = true;
                  _updateList(true, Day.Monday);
                  break;
                case 3:
                  selectedDays[1] = true;
                  _updateList(true, Day.Tuesday);
                  break;
                case 4:
                  _updateList(true, Day.Wednesday);
                  selectedDays[2] = true;
                  break;
                case 5:
                  _updateList(true, Day.Thursday);
                  selectedDays[3] = true;
                  break;
                case 6:
                  _updateList(true, Day.Friday);
                  selectedDays[4] = true;
                  break;
                case 7:
                  _updateList(true, Day.Saturday);
                  selectedDays[5] = true;
                  break;
              }
            }
          }
        } else if (state is EverydayState) {
          if (!state.value) {
            selectedDays = [false, false, false, false, false, false, false];
            _listSelection = [];
          } else {
            selectedDays = [true, true, true, true, true, true, true];
            _listSelection = [
              Day.Everyday,
              Day.Monday,
              Day.Tuesday,
              Day.Wednesday,
              Day.Thursday,
              Day.Friday,
              Day.Saturday,
              Day.Sunday
            ];
          }
          _isEverydayEnabled = state.value;
          _isEverydayDefault = state.value;
        }
      },
      child: BlocBuilder<NotidayselectionBloc, NotidayselectionState>(
          builder: (context, state) {
        return Material(
            color: kPrimaryColor,
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          print('listback: $_listSelection');

                          ScreenArguments args = ScreenArguments(
                              selectedDays: _listSelection,
                              hour: _hours,
                              min: _minutes);
                          Navigator.pop(context, args);
                        },
                        child: Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '     Repeat',
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontFamily: 'Rubik'),
                        ),
                      ),
                      SizedBox(
                        width: 50.0,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 80.0,
                ),
                Column(
                  children: <Widget>[
                    EveryButtonButton(
                      defaultValue: _isEverydayDefault,
                      onClick: (bool value) {
                        _notidayselectionBloc
                            .add(EverydayClicked(isEnabled: value));
                        _updateList(value, Day.Everyday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[0],
                      text: monday,
                      onClick: (bool val) {
                        _updateList(val, Day.Monday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[1],
                      text: tuesday,
                      onClick: (bool val) {
                        _updateList(val, Day.Tuesday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[2],
                      text: wednesday,
                      onClick: (bool val) {
                        _updateList(val, Day.Wednesday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[3],
                      text: thursday,
                      onClick: (bool val) {
                        _updateList(val, Day.Thursday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[4],
                      text: friday,
                      onClick: (bool val) {
                        _updateList(val, Day.Friday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[5],
                      text: saturday,
                      onClick: (bool val) {
                        _updateList(val, Day.Saturday);
                      },
                    ),
                    SingleButton(
                      isAllDayEnabled: _isEverydayEnabled,
                      defaultValue: selectedDays[6],
                      text: sunday,
                      onClick: (bool val) {
                        _updateList(val, Day.Sunday);
                      },
                    ),
                  ],
                )
              ]),
            ));
      }),
    );
  }

  void _updateList(bool isAdd, Day value) {
    print('_updateList');
    if (isAdd) {
      if (!_listSelection.contains(value)) _listSelection.add(value);
    } else {
      _listSelection.remove(value);
      if (_listSelection.contains(Day.Everyday)) {
        _listSelection.remove(Day.Everyday);
      }
    }
  }

  void _getScreenData() {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    _hours = args.hour;
    _minutes = args.min;
  }
}
