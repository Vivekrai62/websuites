
class DashboardRequestModel {
  String? name;
  bool? isDefault;
  List<Roles>? roles;
  String? id;

  DashboardRequestModel({
    this.name,
    this.isDefault,
    this.roles,
    this.id,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['isDefault'] = isDefault;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    return data;
  }
}

class Roles{
  String? id;
  String? name;
  String? description;
  bool? isDefault;

  Roles({
    this.id,
    this.name,
    this.description,
    this.isDefault,
  });

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['default'] = isDefault;
    return data;
  }
}