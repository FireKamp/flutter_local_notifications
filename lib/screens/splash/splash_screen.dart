import 'package:flutter/material.dart';
import 'package:sudoku_brain/screens/home/home_screen.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splasf_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _delay();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      color: kPrimaryColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/images/ic_logo_large.png'),
            ),
            Image(
              image: AssetImage('assets/images/ic_name.png'),
            )
          ],
        ),
      ),
    ));
  }

  void _delay() {
    Future.delayed(const Duration(milliseconds: 3000), () {
      Navigator.pushReplacementNamed(context, HomeScreen.id);
    });
  }
}
