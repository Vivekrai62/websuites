class UserDepartmentAddRequestModel {
  String? name;
  String? description;

  UserDepartmentAddRequestModel({this.name, this.description});

  UserDepartmentAddRequestModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
