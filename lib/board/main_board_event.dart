import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MainBoardEvent {}

class BoardInitISCalled extends MainBoardEvent {
  final BuildContext context;

  BoardInitISCalled({this.context});
}
