import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryColor,
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
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
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
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '1',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '2',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '3',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '4',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '5',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '6',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '7',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '8',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
              ),
              Container(
                width: 30.0,
                height: 30.0,
                child: const Text(
                  '9',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 10.0),
                ),
                color: Colors.teal[100],
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
