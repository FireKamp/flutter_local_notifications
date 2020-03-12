import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/screens/board/main_board_bloc.dart';

class CounterWidget extends StatelessWidget {
  const CounterWidget({
    Key key,
    @required MainBoardBloc mainBoardBloc,
  })  : _mainBoardBloc = mainBoardBloc,
        super(key: key);

  final MainBoardBloc _mainBoardBloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: _mainBoardBloc.outCounter,
      initialData: '00:00',
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        return AutoSizeText(
          '${snapshot.data}',
          style: TextStyle(fontSize: 19.0),
        );
      },
    );
  }
}
