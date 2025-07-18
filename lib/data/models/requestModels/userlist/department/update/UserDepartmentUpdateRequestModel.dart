class UserDepartmentUpdateRequestModel {
  String? name;
  String? description;

  UserDepartmentUpdateRequestModel({this.name, this.description});

  UserDepartmentUpdateRequestModel.fromJson(Map<String, dynamic> json) {
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
