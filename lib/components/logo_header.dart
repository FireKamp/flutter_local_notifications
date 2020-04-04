import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';

class LogoHeader extends StatelessWidget {
  const LogoHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.30,
      child: Row(
        children: <Widget>[
          Spacer(),
          GestureDetector(
            onTap: () {
              MediaPlayer.loadPlayAudio(SoundValues.getEnum(Sounds.BUTTON_TAP));
              Navigator.pop(context);
            },
            child: Image(
              image: AssetImage('assets/images/ic_back.png'),
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/ic_logo.png'),
              ),
              SizedBox(
                height: 10.0,
              ),
              Image(
                image: AssetImage('assets/images/header.png'),
              ),
              SizedBox(
                height: 7.0,
              ),
              Image(
                image: AssetImage('assets/images/subheader.png'),
              ),
            ],
          ),
          Spacer(),
          Spacer(),
        ],
      ),
    );
  }
}
