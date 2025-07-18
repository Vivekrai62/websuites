class SettingRolesResponseModel {
  String? id;
  String? name;
  String? description;
  bool? isDefault; // Renamed from 'default' to 'isDefault'
  List<Users>? users;

  SettingRolesResponseModel({this.id, this.name, this.description, this.isDefault, this.users});

  SettingRolesResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isDefault = json['default']; // Use 'default' from JSON, map it to 'isDefault'
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['default'] = isDefault; // Map 'isDefault' to 'default' in JSON
    if (users != null) {
      data['users'] = users!.map((v) => v.toJson()).toList();
    }
    return data;
  }
  static List<SettingRolesResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SettingRolesResponseModel.fromJson(json)).toList();
  }
}

class Users {
  String? id;
  String? firstName;
  String? lastName;

  Users({this.id, this.firstName, this.lastName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }

}
