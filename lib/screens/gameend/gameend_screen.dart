import 'package:flutter/material.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:sudoku_brain/models/screen_arguments.dart';
import 'package:sudoku_brain/screens/board/board_screen.dart';
import 'package:sudoku_brain/screens/levelselection/levelselection_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

class GameEndScreen extends StatefulWidget {
  static String id = 'game_end';

  @override
  _GameEndScreenState createState() => _GameEndScreenState();
}

class _GameEndScreenState extends State<GameEndScreen> {
  String _levelName;
  String _bestTime = '';
  String _lastBestTime = '';

  bool _isGameEnded = true;
  int _levelNumber;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => getData(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kPrimaryColor,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .13),
              child: GradientText(_levelName == null ? '' : _levelName,
                  gradient: LinearGradient(colors: [
                    Color(0xFF71DC8F),
                    Color(0xFF0BB9AD),
                  ]),
                  style: TextStyle(
                      fontFamily: 'Staatliches',
                      fontSize: 53.0,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none),
                  textAlign: TextAlign.center),
            ),
            CommonText(
              text: 'Level $_levelNumber',
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05),
              child: Image(
                image: AssetImage('assets/images/ic_win.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .05,
                  bottom: MediaQuery.of(context).size.height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CommonText(
                    text: _isGameEnded == true
                        ? 'Total Time       '
                        : 'Best Time',
                  ),
                  CommonText(
                    text: _lastBestTime == null ? _bestTime : _lastBestTime,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isGameEnded == null ? false : _isGameEnded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CommonText(
                    text: 'New Best Time',
                  ),
                  CommonText(
                    text: _bestTime == null ? '' : _bestTime,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .04),
              child: RaisedButton(
                padding: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                color: Color(0xFF7EC1FF),
                child: Text(_isGameEnded == true ? 'NEXT' : 'PLAY AGAIN',
                    style: TextStyle(
                        fontFamily: 'Staatliches',
                        fontSize: 30.0,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none),
                    textAlign: TextAlign.center),
                onPressed: () {
                  if (!_isGameEnded) {
                    Navigator.pushReplacementNamed(context, MainBoard.id,
                        arguments: ScreenArguments(
                            levelName: _levelName.toLowerCase(),
                            index: _levelNumber - 1));
                  } else {
                    Navigator.pushReplacementNamed(context, LevelSelection.id,
                        arguments: ScreenArguments(
                          //TODO: Add expert support here -- Zahid
                            levelTYPE: _levelName == 'easy'
                                ? LevelTYPE.EASY
                                : (_levelName == 'medium'
                                    ? LevelTYPE.MEDIUM
                                    : LevelTYPE.HARD)));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getData(BuildContext context) async {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    _levelName = args.levelName;
    _levelNumber = args.index;
    _bestTime = args.bestTime;
    _isGameEnded = args.isPlayed;

    String key = '${_levelName}_$_levelNumber';
    String test = await LocalDB.getString(key);
    _lastBestTime = test;

    if (_isGameEnded) LocalDB.setString(key, _bestTime);

    setState(() {});
  }
}

class CommonText extends StatelessWidget {
  final String text;

  CommonText({this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
          fontFamily: 'Rubik',
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.w100,
          decoration: TextDecoration.none),
    );
  }
}
