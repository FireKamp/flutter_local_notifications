import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:package_info/package_info.dart';
import 'package:sudoku_brain/components/gradient_button_wi.dart';
import 'package:sudoku_brain/components/top_container.dart';
import 'package:sudoku_brain/screens/termofuse/termofuse_screen.dart';
import 'package:sudoku_brain/screens/tutorial/tutorial_screen.dart';
import 'package:sudoku_brain/utils/Analytics.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/Enums.dart';
import 'package:sudoku_brain/utils/Logs.dart';
import 'package:sudoku_brain/utils/MediaPlayer.dart';

class HelpScreen extends StatelessWidget {
  static final String id = 'help_screen';
  final double sizedBoxHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    Analytics.logEvent('screen_help');

    return SafeArea(
      child: Column(
        children: <Widget>[
          TopContainer(
            imagePath: 'assets/images/ic_help.png',
            text: 'HELP',
            color: kPrimaryColor,
            gradient: LinearGradient(
              colors: <Color>[kPrimaryColor, kPrimaryColor],
            ),
            circleGradient: LinearGradient(
              colors: <Color>[Color(0xFFFFC7E7), Color(0xFFFF3AA0)],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.only(top: 50.0),
              color: kPrimaryColor,
              child: Column(
                children: <Widget>[
                  RaisedGradientButtonWI(
                      text: 'TUTORIAL',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFFABB69), Color(0xFFFE3E16)],
                      ),
                      onPressed: () {
                        MediaPlayer.loadPlayAudio(SoundValues.getEnum(Sounds.BUTTON_TAP));
                        Navigator.pushNamed(context, TutorialScreen.id);
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButtonWI(
                      text: 'CONTACT US',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFF82FFF4), Color(0xFF05AB9C)],
                      ),
                      onPressed: () async {
                        MediaPlayer.loadPlayAudio(SoundValues.getEnum(Sounds.BUTTON_TAP));
                        Analytics.logEvent('screen_contact_us');

                        getVersionName().then((onValue) async {
                          Logs.printLogs('onValue: $onValue');
                          final Email email = Email(
                            subject: 'Have questions or feedback? v $onValue',
                            recipients: ['hello@matchalagames.com'],
                            isHTML: false,
                          );
                          await FlutterEmailSender.send(email);
                        });
                      }),
                  SizedBox(
                    height: sizedBoxHeight,
                  ),
                  RaisedGradientButtonWI(
                      text: 'TERMS OF USE',
                      gradient: LinearGradient(
                        colors: <Color>[Color(0xFFBEE4FF), Color(0xFF1E9FFE)],
                      ),
                      onPressed: () {
                        MediaPlayer.loadPlayAudio(SoundValues.getEnum(Sounds.BUTTON_TAP));
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => TermsOfUse()),
                        );
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
}
