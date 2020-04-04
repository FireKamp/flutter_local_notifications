import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NotificationPermissionBloc extends Bloc<NotificationPermissionEvent, NotificationPermissionState> {
  @override
  NotificationPermissionState get initialState => InitialNotificationPermissionState();

  @override
  Stream<NotificationPermissionState> mapEventToState(
    NotificationPermissionEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
