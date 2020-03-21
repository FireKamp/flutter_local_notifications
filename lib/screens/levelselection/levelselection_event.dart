import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LevelSelectionEvent {}

class LevelListEvent extends LevelSelectionEvent {
  final String levelName;
  final BuildContext context;

  LevelListEvent({this.context, this.levelName});
}
