import 'package:flutter/material.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      home: AnimateContentExample(),
    );
  }
}

class AnimateContentExample extends StatefulWidget {
  @override
  _AnimateContentExampleState createState() =>
      new _AnimateContentExampleState();
}

class _AnimateContentExampleState extends State<AnimateContentExample> {
  double _animatedHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Animate Content"),
      ),
      body: new Column(
        children: <Widget>[
          new Card(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new GestureDetector(
                  onTap: () => setState(() {
                    _animatedHeight != 0.0
                        ? _animatedHeight = 0.0
                        : _animatedHeight = 100.0;
                  }),
                  child: new Container(
                    child: new Text("CLICK ME"),
                    color: Colors.blueAccent,
                    height: 25.0,
                    width: 100.0,
                  ),
                ),
                new AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  child: new Text("Toggle Me"),
                  height: _animatedHeight,
                  color: Colors.tealAccent,
                  width: 100.0,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
