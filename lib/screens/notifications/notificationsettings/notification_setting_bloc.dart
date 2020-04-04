import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';

class NotificationSettingBloc
    extends Bloc<NotificationSettingEvent, NotificationSettingState> {
  @override
  NotificationSettingState get initialState =>
      InitialNotificationSettingState();

  @override
  Stream<NotificationSettingState> mapEventToState(
    NotificationSettingEvent event,
  ) async* {
    if (event is FetchNotificationData) {
      var hour = await _getTime(LocalDB.keyNotificationHour);
      var min = await _getTime(LocalDB.keyNotificationMinutes);
      var isAllowed = await _getPermissionAllowed();
      yield NotificationDataState(isAllowed: isAllowed, hour: hour, min: min);
    }
  }

  Future<int> _getTime(String key) async {
    int result = await LocalDB.getInt(key);
    return result;
  }

  Future<bool> _getPermissionAllowed() async {
    bool isAllowed = await LocalDB.getBool(LocalDB.keyNotificationAllowed);
    return isAllowed;
  }
}
