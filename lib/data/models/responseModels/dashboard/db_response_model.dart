class DashboardResponseModel {
  String? name;
  bool? isDefault;
  List<Roles>? roles;
  String? id;

  DashboardResponseModel({this.name, this.isDefault, this.roles, this.id});

  DashboardResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    isDefault = json['isDefault'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isDefault'] = isDefault;
    if (roles != null) {
     data['roles'] = roles !.map((v) => v.toJson()).toList();
    data['id'] = id;
    }
    return data;
}}

class Roles {
  String? id;
  String? name;
  String? description;
  bool? isdefault;

  Roles({this.id, this.name, this.description, this.isdefault});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isdefault = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['default'] = isdefault;
    return data;
  }
}