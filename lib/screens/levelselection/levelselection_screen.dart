import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudoku_brain/components/logo_header.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/levelselection/bloc.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Logs.dart';

class LevelSelection extends StatefulWidget {
  static String id = 'level_selection';

  @override
  _LevelSelectionState createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  LevelSelectionBloc _levelselectionBloc;
  String _levelName;
  List levelList;

  @override
  void initState() {
    super.initState();
    _levelselectionBloc = BlocProvider.of<LevelSelectionBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    getArguments();
    return BlocListener(
      bloc: BlocProvider.of<LevelSelectionBloc>(context),
      listener: (BuildContext context, state) {
        if (state is LevelListState) {
          Logs.printLogs('LevelListState: ${state.levelList}');
          levelList = List.from(state.levelList);
        }
      },
      child: BlocBuilder<LevelSelectionBloc, LevelSelectionState>(
          builder: (context, state) {
        return SafeArea(
          child: Container(
            color: kPrimaryColor,

            child: Column(
              children: <Widget>[
                LogoHeader(),
                Expanded(
                  flex: 6,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(30.0, 0.0, 30.0, 0.0),
                    decoration: new BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                          child: Text(
                            '${_levelName == null ? '' : _levelName.toUpperCase()}',
                            style: TextStyle(
                                fontFamily: 'Staatliches',
                                fontSize: 35.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w200,
                                decoration: TextDecoration.none),
                          ),
                        ),
                        _buildItemsList(levelList),
                      ],
                    ),
                  ),
                ),
              ],
            ),

//
          ),
        );
      }),
    );
  }

  Widget _buildItemsList(List items) {
//    List items = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    if (items != null) {
      return Column(
        children: <Widget>[
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.61,
            child: GridView.count(
                primary: false,
                crossAxisCount: 3,
                children: List.generate(items.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      Logs.printLogs('index: $index');
                      Navigator.pushNamed(context, MainBoard.id,
                          arguments: ScreenArguments(
                              levelName: _levelName.toLowerCase(), index: index));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          color: Color(0xFF003D4D),
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 30.0,
                      child: Center(
                        child: Text(
                          'Level ${index + 1}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Viga',
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ],
      );
    } else {
      Logs.printLogs('else');
      return Container(
        padding: EdgeInsets.all(10.0),
        width: double.maxFinite,
      );
    }
  }

  void getArguments() {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    _levelName = EnumToString.parse(args.levelTYPE);
    _levelselectionBloc.add(
        LevelListEvent(context: context, levelName: _levelName.toLowerCase()));
  }
}
