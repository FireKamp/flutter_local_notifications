import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class GameendBloc extends Bloc<GameendEvent, GameendState> {
  @override
  GameendState get initialState => InitialGameendState();

  @override
  Stream<GameendState> mapEventToState(
    GameendEvent event,
  ) async* {
  }
}
