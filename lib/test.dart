import 'package:flutter/material.dart';

void main() => runApp(FirstScreen());

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Color(0xff000019),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: Column(children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Container(
                      height: 240.0,
                      width: 240.0,
                      decoration: BoxDecoration(
                          color: Color(0xffFEF9F8),
                          border:
                              Border.all(style: BorderStyle.solid, width: 5.0),
                          borderRadius: BorderRadius.circular(120.0)),
                      child: Image.asset(
                        'assets/Bell.JPG',
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                      'NOTIFICATIONS',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          fontFamily: 'Staatliches'),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          'Train your brain daily!Do you want us to remind you?',
                          style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: 'Rubik'),
                        )),
                    SizedBox(
                      height: 40.0,
                    ),
                    GestureDetector(
                        onTap: () {
//                              Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen()));
                        },
                        child: Container(
                          height: 40.0,
                          width: 120.0,
                          child: Center(
                              child: Text(
                            'Allow',
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
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
                      onPressed: () {},
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Rubik'),
                      ),
                    )
                  ]),
                )
              ],
            ),
          ],
        ));
  }
}
