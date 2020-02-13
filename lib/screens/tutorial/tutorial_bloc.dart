import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TutorialBloc extends Bloc<TutorialEvent, TutorialState> {
  @override
  TutorialState get initialState => InitialTutorialState();

  @override
  Stream<TutorialState> mapEventToState(
    TutorialEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
