import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sudoku_brain/utils/Constants.dart';

import 'Board.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(kPrimaryColor),
        scaffoldBackgroundColor: Color(kPrimaryColor),
      ),
      home: MyHomePage(
        title: 'SudokuBrain',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<MyHomePage> {
  bool isShowRowBorder = false;
  bool isShowColumnBorder = false;
  bool isCellPressed = false;
  bool listChanged=false;

  int row = 0;
  int col = 0;

  List<List<int>> imgList = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];

  List<List<int>> _initList = [
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0]
  ];

  static String toImg(int s) {
//    return 'set2/' + s.toString() + '.png';
  }

  static int count = 0;
  static int cursor = 0;
  HashSet<RowCol> conflicts = new HashSet<RowCol>();

  void changeConflicts() {
    conflicts = Conflict.getConflicts(imgList);
  }

  static void changeCursor(i) {
    cursor = i;
  }

  // Resets the whole board.
  void reset() {
//    setState(() {
//      imgList = new List<List<int>>.generate(
//          9, (i) => new List<int>.from(initList[i]));
//      changeConflicts();
//    });
  }

  Color getHighlightColor(int r, int c) {
    bool isConflict = conflicts.contains(new RowCol(r, c));
    bool isChangable = _initList[r][c] == 0;

    print('initList[$r][$c]=${_initList[r][c]}---- ${imgList[r][c]}');

    if (r == row && c == col) {
      return Color(kBoardCellSelected);
    }

    if (isConflict && !isChangable)
      return Colors.red[900];
    else if (isConflict)
      return Colors.red[100];
    else if (!isChangable)
      return Color(kBoardPreFilled);
    else
      return Color(kBoardCellEmpty);
  }

  List<TableRow> getTableRowLst() {
    List<TableRow> lst = new List<TableRow>();
    for (int r = 0; r < 9; r++) {
      lst.add(getTableRow(r));
    }
    return lst;
  }

  TableRow getTableRow(r) {
    if (r == 3 || r == 6) {
      isShowRowBorder = true;
    } else {
      isShowRowBorder = false;
    }
    List<Widget> lst = new List<Widget>();
    for (int c = 0; c < 9; c++) {
      if (c == 3 || c == 6) {
        isShowColumnBorder = true;
      } else {
        isShowColumnBorder = false;
      }

      lst.add(new Container(
        height: 36.0,
        color: getHighlightColor(r, c),
        child: Column(
          children: <Widget>[
            Visibility(
              visible: isShowRowBorder,
              child: Divider(
                color: Color(kPrimaryColor),
                height: 1.0,
                thickness: 2.0,
              ),
            ),
            InkWell(
              onTap: () {
                print('board cell:[$r][$c]');
                if (_initList[r][c] == 0) {
                  setState(() {
                    row = r;
                    col = c;
                  });
                }
              },
              child: Row(
                children: <Widget>[
                  Visibility(
                    visible: isShowColumnBorder,
                    child: Container(
                      height: 35.0,
                      width: 2.0,
                      color: Color(kPrimaryColor),
                    ),
                  ),
                  Text(
                    imgList[r][c] == 0 ? '' : '${imgList[r][c]}',
                    style: TextStyle(
                        fontSize: 20.0, color: Color(kBoardTextColor)),
                  )
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return new TableRow(children: lst);
  }

  List<TableRow> getKeyRowlst() {
    List<TableRow> lst = new List<TableRow>();
    lst.add(getKeyRow(0));
    lst.add(getKeyRow(5));
    return lst;
  }

  TableRow getKeyRow(int c) {
    List<Widget> lst = new List<Widget>();
    for (int i = 0; i <= 4; i++) {
      Color containerColor = Color(kPrimaryColor);
      if (cursor == i + c) containerColor = Color(kNumPadBorder);
      lst.add(
        new Container(
          color: containerColor,
          child: InkWell(
            onTap: () {
              print((i + c).toString());
              setState(() {
                changeCursor(i + c);

                imgList[row][col] = i + c;
                changeConflicts();
              });
            },
            child: Center(
              child: Text(
                '${(i + c).toString()}',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
          ),
        ),
      );
    }
    return new TableRow(children: lst);
  }

  @override
  void initState() {
    super.initState();
    print('initState');
    readJson();
//    WidgetsBinding.instance.addPostFrameCallback((_) => readJson());
  }

  void readJson() async {
    print('readJson');

    String data =
        await DefaultAssetBundle.of(context).loadString("assets/brain.json");
//    print('data: $data');

    var decodedData = jsonDecode(data);
    List list = decodedData['easy'];
    print('list: $list');

//    imgList.clear();
//    initList.clear();

    List<List<int>> ques = [];

    for (int i = 0; i < list.length; i++) {
      ques.add(list[i].cast<int>());
    }
    print('listChanged: $listChanged');
    if(!listChanged){
      listChanged=true;
       _initList =ques;

    }
    imgList = ques;

    setState(() {


    });
    print('imgList: $imgList');
  }

  @override
  Widget build(BuildContext context) {
    print('build');

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(kPrimaryColor),
          body: Column(children: [
            Container(
              height: 40.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(Icons.settings, size: 25.0),
                  Text(
                    '00:00',
                    style: TextStyle(fontSize: 19.0),
                  ),
                  Icon(Icons.pause, size: 30.0),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Table(
                children: getTableRowLst(), // main board
                border: new TableBorder.all(color: Color(kPrimaryColor)),
              ),
            ),
            Padding(
                padding: new EdgeInsets.only(top: 40.0),
                child: new Table(
                  children: getKeyRowlst(),
                  border: new TableBorder.all(
                    color: Color(kNumPadBorder),
                  ),
                ))
          ])),
    );
  }
}
