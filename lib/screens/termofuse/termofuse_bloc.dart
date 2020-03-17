import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class TermofuseBloc extends Bloc<TermofuseEvent, TermsOfUseState> {
  @override
  TermsOfUseState get initialState => InitialTermOfUseState();

  @override
  Stream<TermsOfUseState> mapEventToState(
    TermofuseEvent event,
  ) async* {
  }
}
