import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

import './bloc.dart';

class LevelSelectionBloc
    extends Bloc<LevelSelectionEvent, LevelSelectionState> {
  @override
  LevelSelectionState get initialState => InitialLevelSelectionState();

  @override
  Stream<LevelSelectionState> mapEventToState(
    LevelSelectionEvent event,
  ) async* {
    if (event is LevelListEvent) {
      List<bool> list = await _readJson(event.context, event.levelName);
      yield LevelListState(levelList: list);
    }
  }

  Future<List<bool>> _readJson(BuildContext context, String objName) async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");

    var decodedData = jsonDecode(data);
    List list = decodedData['difficulty'][objName]['level'];

    List<bool> updatedList = [];
    for (int i = 0; i < list.length; i++) {
      String key = '${objName.toLowerCase()}_${i + 1}';
      String time = await LocalDB.getString(key);
      updatedList.add(time == null ? false : true);
    }

    return updatedList;
  }
}
