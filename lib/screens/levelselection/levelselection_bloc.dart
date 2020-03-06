import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

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
      List list = await _readJson(event.context, event.levelName);
      yield LevelListState(levelList: list);
    }
  }

  Future<List> _readJson(BuildContext context, String objName) async {
    print('readJson');

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");

    var decodedData = jsonDecode(data);
    List list = decodedData['difficulty'][objName]['level'];
    print('list: $list');

    return list;
  }
}
