import 'dart:collection';

import 'package:sudoku_brain/models/board_data.dart';

import '../models/row_col.dart';

class Conflict {
  static HashSet<RowCol> getConflicts(List<List<BoardData>> grid) {
    HashSet<RowCol> result = new HashSet<RowCol>();
    computeRowConflicts(grid, result);
    computeColConflicts(grid, result);
    computeBlockConflicts(grid, result);
    return result;
  }

  static void computeRowConflicts(
      List<List<BoardData>> grid, HashSet<RowCol> res) {
    for (int r = 0; r < 9; r++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int c = 0; c < 9; c++) {
        int newNum = grid[r][c].value;

        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
        } else
          usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  static void computeColConflicts(
      List<List<BoardData>> grid, HashSet<RowCol> res) {
    for (int c = 0; c < 9; c++) {
      HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
      for (int r = 0; r < 9; r++) {
        int newNum = grid[r][c].value;
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
        } else
          usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }

  // Check to finish game
  static bool computeFinishGame(List<List<BoardData>> grid) {
    bool isGameFinished = true;
    for (int c = 0; c < 9; c++) {
      for (int r = 0; r < 9; r++) {
        int newNum = grid[r][c].value;
        if (newNum == 0) {
          isGameFinished = false;
        }
      }
    }
    return isGameFinished;
  }

  static void computeBlockConflicts(
      List<List<BoardData>> grid, HashSet<RowCol> res) {
    blockConf(0, 0, grid, res);
    blockConf(0, 3, grid, res);
    blockConf(0, 6, grid, res);
    blockConf(3, 0, grid, res);
    blockConf(3, 3, grid, res);
    blockConf(3, 6, grid, res);
    blockConf(6, 0, grid, res);
    blockConf(6, 3, grid, res);
    blockConf(6, 6, grid, res);
  }

  static void blockConf(
      int row, int col, List<List<BoardData>> grid, HashSet<RowCol> res) {
    HashMap<int, RowCol> usedNumToRowCol = new HashMap<int, RowCol>();
    for (int r = row; r < row + 3; r++) {
      for (int c = col; c < col + 3; c++) {
        int newNum = grid[r][c].value;
        if (newNum == 0) continue;
        if (usedNumToRowCol.containsKey(newNum)) {
          res.add(new RowCol(r, c));
          res.add(usedNumToRowCol[newNum]);
        } else
          usedNumToRowCol[newNum] = new RowCol(r, c);
      }
    }
  }
}
