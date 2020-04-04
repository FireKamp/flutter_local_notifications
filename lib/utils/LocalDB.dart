import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static final keyBoardList = 'keyBoardList';
  static final keyisFirstTime = 'keyisFirstTime';
  static final keyBoardLevelName = 'keyBoardLevelName';
  static final keyBoardLevelNumber = 'keyBoardLevelNumber';
  static final keyBoardLevelTime = 'keyBoardLevelTime';
  static final keyNotificationHour = 'keyNotificationHour';
  static final keyNotificationMinutes = 'keyNotificationMinutes';
  static final keyNotificationAllowed = 'keyNotificationAllowed';
  static final keyNotificationRepList = 'keyNotificationRepList';

  static savePausedBoard(
      String json, String _levelName, int _levelIndex, int timerValue) {
    LocalDB.setString(LocalDB.keyBoardList, json);
    LocalDB.setString(LocalDB.keyBoardLevelName, _levelName);
    LocalDB.setInt(LocalDB.keyBoardLevelNumber, _levelIndex);
    LocalDB.setInt(LocalDB.keyBoardLevelTime, timerValue);
  }

  // Set Data Methods
  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static setObject(String key, Object value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(value));
  }

  static setList(String key, List value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  static Future<Object> getList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // Get Data Methods
  static Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<Object> getObject(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      return jsonDecode(prefs.getString(key));
    } else {
      return null;
    }
  }

  // Remove Data Method
  static removeValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
