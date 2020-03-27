import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class FetchedPausedState extends HomeState {
  final bool isPaused;
  final String levelName;
  final int levelNumber;
  final int levelTime;

  FetchedPausedState(
      {this.isPaused, this.levelName, this.levelNumber, this.levelTime});
}
