class MasterDepartmentsResponseModel {
  String? id;
  String? name;
  String? description;
  bool? isdefault;
  String? createdAt;
  String? updatedAt;

  MasterDepartmentsResponseModel(
      {this.id,
        this.name,
        this.description,
        this.isdefault,
        this.createdAt,
        this.updatedAt});

  MasterDepartmentsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    isdefault = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['default'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<MasterDepartmentsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>MasterDepartmentsResponseModel.fromJson(json)).toList();
  }

}
