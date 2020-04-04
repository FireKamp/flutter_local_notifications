import 'package:meta/meta.dart';

@immutable
abstract class HomeState {}

class InitialHomeState extends HomeState {}

class FetchedPausedState extends HomeState {
  final bool isPaused;
  final bool isSoundsOn;
  final bool isHapticsOn;
  final bool isHideDuplicates;
  final bool isMistakeLimit;
  final bool isHighDuplicates;
  final String levelName;
  final int levelNumber;
  final int levelTime;

  FetchedPausedState(
      {this.isPaused,
      this.levelName,
      this.levelNumber,
      this.levelTime,
      this.isHapticsOn,
      this.isHideDuplicates,
      this.isHighDuplicates,
      this.isMistakeLimit,
      this.isSoundsOn});
}
