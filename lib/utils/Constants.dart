// Colors
import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF220E4A);
const kBoardTextColor = 0xFF737272;
const kBoardCellEmpty = 0xFFFFF3D2;
const kBoardBorder = 0xFFE2E6E7;
const kBoardPreFilled = 0xFFFCD0A3;
const kNumPadBorder = 0xFFABDCFF;
const kPanelBg = 0xFF38356e;
const transparent = Color(0xca000000);
const lightBlue = Color(0xFFDCF8FF);
const kBoardCellSelected = Color(0xFF80C3FF);
const kBorderTest = Color(0x60170D2E);

// Gradients
const kEasyLevelGrad = LinearGradient(
  colors: <Color>[Color(0xFF91E786), Color(0xFF0AB8AD)],
);

const kMediumLevelGrad = LinearGradient(
  colors: <Color>[Color(0xFF1E9FFE), Color(0xFF4F5FFE)],
);

const kHardLevelGrad = LinearGradient(
  colors: <Color>[Color(0xFFA193FF), Color(0xFF6442FD)],
);
const kExpertLevelGrad = LinearGradient(
  colors: <Color>[Color(0xFFFE23A7), Color(0xFFE2297E)],
);

const String levelHintName = '';

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
