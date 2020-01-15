import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MainBoardBloc extends Bloc<MainBoardEvent, MainBoardState> {
  @override
  MainBoardState get initialState => InitialMainBoardState();

  @override
  Stream<MainBoardState> mapEventToState(
    MainBoardEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
