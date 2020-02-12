import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HelpBloc extends Bloc<HelpEvent, HelpState> {
  @override
  HelpState get initialState => InitialHelpState();

  @override
  Stream<HelpState> mapEventToState(
    HelpEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
