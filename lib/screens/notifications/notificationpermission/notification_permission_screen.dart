import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
import 'package:sudoku_brain/screens/notifications/notificationsettings/notification_settings_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';

class NotificationPermission extends StatelessWidget {
  static String id = 'notification_permission';

  @override
  Widget build(BuildContext context) {
    return Material(
        color: kPrimaryColor,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.20),
              child: Column(children: <Widget>[
                Image.asset(
                  'assets/images/ic_notification.png',
                ),
                SizedBox(
                  height: 30.0,
                ),
                AutoSizeText(
                  'NOTIFICATIONS',
                  style: TextStyle(
                      letterSpacing: 1.5,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w400,
                      color: lightYellow,
                      fontFamily: 'Staatliches'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Train your brain daily! Do you want us to remind you?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.w100,
                          color: Colors.white,
                          fontFamily: 'Rubik'),
                    )),
                SizedBox(
                  height: 40.0,
                ),
                GestureDetector(
                    onTap: () {
                      LocalDB.setBool(LocalDB.keyNotificationAllowed, true);
                      Navigator.pushReplacementNamed(
                          context, NotificationsSettingsScreen.id);
                    },
                    child: Container(
                      height: 40.0,
                      width: 120.0,
                      child: Center(
                          child: Text(
                        'Allow',
                        style: TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.w100,
                            color: Colors.white,
                            fontFamily: 'Rubik'),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.tealAccent,
                      ),
                    )),
                SizedBox(
                  height: 8.0,
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, HomeScreen.id);

                  },
                  child: Text(
                    'SKIP',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontFamily: 'Rubik'),
                  ),
                )
              ]),
            )
          ],
        ));
  }
}
