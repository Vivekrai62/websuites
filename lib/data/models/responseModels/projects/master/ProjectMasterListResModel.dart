class ProjectMasterListResponseModel {
  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  ProjectMasterListResponseModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Constructor to create object from JSON
  ProjectMasterListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  // Method to create a role of objects from a role of JSON
  static List<ProjectMasterListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProjectMasterListResponseModel.fromJson(json))
        .toList();
  }

  // Method to convert object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
