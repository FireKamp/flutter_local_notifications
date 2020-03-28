import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {}

class FetchPauseBoard extends HomeEvent {}
