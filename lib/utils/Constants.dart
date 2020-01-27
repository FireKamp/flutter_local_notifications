// Colors
import 'package:flutter/material.dart';

const kPrimaryColor = 0xFF220E4A;
const kBoardTextColor = 0xFF737272;
const kBoardCellSelected = 0xFF80C3FF;
const kBoardCellEmpty = 0xFFFFF3D2;
const kBoardBorder = 0xFFE2E6E7;
const kBoardPreFilled = 0xFFFCD0A3;
const kNumPadBorder = 0xFFABDCFF;
const kPanelBg = 0xFF38356e;
const transparent = Color(0xca000000);

// init list
List<List<int>> constantList = [
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

List<List<int>> dummyList1 = [
  [8, 6, 2, 7, 3, 9, 1, 4, 5],
  [4, 3, 1, 2, 5, 6, 7, 8, 9],
  [9, 5, 7, 1, 4, 8, 6, 3, 2],
  [2, 8, 3, 4, 6, 5, 9, 1, 7],
  [5, 1, 6, 8, 9, 7, 4, 2, 3],
  [7, 9, 4, 3, 1, 2, 8, 5, 6],
  [1, 2, 9, 5, 7, 4, 3, 6, 8],
  [6, 4, 5, 9, 8, 3, 2, 7, 1],
  [3, 7, 8, 6, 2, 1, 5, 9, 4]
];

List<List<int>> dummyList = [
  [8, 0, 2, 7, 3, 9, 1, 4, 5],
  [4, 3, 1, 2, 5, 6, 7, 8, 9],
  [9, 5, 7, 1, 4, 8, 6, 3, 2],
  [2, 8, 3, 4, 0, 5, 9, 1, 7],
  [5, 1, 6, 8, 9, 7, 4, 2, 3],
  [7, 9, 4, 3, 1, 2, 8, 5, 6],
  [1, 2, 9, 5, 7, 4, 3, 6, 8],
  [6, 4, 5, 9, 8, 3, 2, 7, 1],
  [3, 7, 8, 6, 2, 1, 5, 9, 0]
];

// Enums
//enum SelectionType{
//
//}
