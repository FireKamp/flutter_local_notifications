import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(kPrimaryColor),
        scaffoldBackgroundColor: Color(kPrimaryColor),
      ),
      home: Grid(),
    );
  }
}

class Grid extends StatefulWidget {
  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          color: Colors.white,
          width: 30.0,
          height: 30.0,
          child: GridView.count(
            primary: false,
            crossAxisCount: 3,

            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                child: const Text('1',textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 10.0),),
                color: Colors.teal[100],
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: const Text('400'),
                color: Colors.teal[200],
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: const Text('cdf'),
                color: Colors.teal[100],
              ),
              Container(
                width: 50.0,
                height: 50.0,
                child: const Text('400'),
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
        Container(),
        Container()
      ],
    );
  }
}
