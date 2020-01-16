import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import './bloc.dart';

class MainBoardBloc extends Bloc<MainBoardEvent, MainBoardState> {
  @override
  MainBoardState get initialState => InitialMainBoardState();

  @override
  Stream<MainBoardState> mapEventToState(
    MainBoardEvent event,
  ) async* {
    if (event is BoardInitISCalled) {
      yield FetchingLevel();
      final list = await readJson(event.context);
      yield LevelFetched(boardList: list);
    }
  }
}

Future<List<List<int>>> readJson(BuildContext context) async {
  print('readJson');

  List<List<List<int>>> finalList=List();

  String data =
      await DefaultAssetBundle.of(context).loadString("assets/brain.json");
//    print('data: $data');

  var decodedData = jsonDecode(data);
  List list = decodedData['easy'];
  print('list: $list');

  List<List<int>> ques = [];
  List<List<int>> ans = [];
  for (int i = 0; i < list.length; i++) {
    ques.add(list[i].cast<int>());
    ans.add(list[i].cast<int>());
  }

  finalList.add(ques);
  finalList.add(ans);
  return ques;
}
