class BoardData {
  int value;
  int mode;
  List<int> pencilValues;

  BoardData({this.value, this.mode, this.pencilValues});

  BoardData.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    pencilValues = json['pencilValues'].cast<int>();
    mode = json['mode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    data['pencilValues'] = this.pencilValues;
    data['mode'] = this.mode;
    return data;
  }
}
