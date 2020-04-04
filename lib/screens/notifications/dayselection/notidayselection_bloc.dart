import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';

class NotidayselectionBloc
    extends Bloc<NotidayselectionEvent, NotidayselectionState> {
  @override
  NotidayselectionState get initialState => InitialNotidayselectionState();

  @override
  Stream<NotidayselectionState> mapEventToState(
    NotidayselectionEvent event,
  ) async* {
    if (event is GetSelectedDays) {
      var list = await _getList();
      List<int> mOriginaList = list.map((i) => int.parse(i)).toList();

      yield NotidayselectedListState(list: mOriginaList);
    } else if (event is EverydayClicked) {
      yield EverydayState(value: event.isEnabled);
    }
  }

  Future<List<String>> _getList() async {
    var list = await LocalDB.getList(LocalDB.keyNotificationRepList);
    return list;
  }
}
