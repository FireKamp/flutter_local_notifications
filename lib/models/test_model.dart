class TestModel {
  int id;
  String name;
  String address;
  int age;

  TestModel({this.id, this.name, this.address, this.age});

  TestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    age = json['age'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['age'] = this.age;
    return data;
  }
}
