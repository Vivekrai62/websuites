class ReportTaskTypeResponseModel {
  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  ReportTaskTypeResponseModel(
      {this.id, this.name, this.status, this.createdAt, this.updatedAt});

  ReportTaskTypeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<ReportTaskTypeResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ReportTaskTypeResponseModel.fromJson(json))
        .toList();
  }
}
