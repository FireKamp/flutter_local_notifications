import 'dart:async';

import 'package:bloc/bloc.dart';

import './bloc.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  @override
  LevelState get initialState => InitialLevelState();

  @override
  Stream<LevelState> mapEventToState(
    LevelEvent event,
  ) async* {
    if (event is LevelSelected) {
      yield SelectedLevelState(levelTYPE: event.levelTYPE);
    }
  }
}
