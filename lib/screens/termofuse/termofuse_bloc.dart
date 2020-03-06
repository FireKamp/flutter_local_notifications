import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TermofuseBloc extends Bloc<TermofuseEvent, TermofuseState> {
  @override
  TermofuseState get initialState => InitialTermofuseState();

  @override
  Stream<TermofuseState> mapEventToState(
    TermofuseEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
