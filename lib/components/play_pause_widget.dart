import 'package:flutter/material.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';
import 'package:sudoku_brain/screens/board/main_board_event.dart';

class PlayPauseWidget extends StatelessWidget {
  const PlayPauseWidget({
    Key key,
    @required bool isTimerPaused,
    @required MainBoardBloc mainBoardBloc,
  })  : _isTimerPaused = isTimerPaused,
        _mainBoardBloc = mainBoardBloc,
        super(key: key);

  final bool _isTimerPaused;
  final MainBoardBloc _mainBoardBloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          print('Pause');
          if (_isTimerPaused) {
            _mainBoardBloc.add(StartTimer());
          } else {
            _mainBoardBloc.add(PauseTimer());
          }
        },
        child: Icon(_isTimerPaused == true ? Icons.play_arrow : Icons.pause,
            size: 30.0));
  }
}
