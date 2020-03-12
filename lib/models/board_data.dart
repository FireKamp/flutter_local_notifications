import 'package:sudoku_brain/utils/Enums.dart';

class BoardData {
  int value;
  PlayMode mode;
  List<int> pencilValues = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  BoardData({this.value, this.mode});

  BoardData.fromJson(Map<String, dynamic> json) {
    value = int.parse(json['value']);
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['mode'] = this.mode;
    return data;
  }
}
