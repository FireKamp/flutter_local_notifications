import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class HomeScreen extends StatelessWidget {

  static final String id = 'home_screen';


  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Container(
        color: kPrimaryColor,
        child: Column(
          children: <Widget>[
            Icon(Icons.blur_circular,size: 80.0,),

          ],
        ),
      ),
    );
  }
}
