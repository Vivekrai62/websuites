class ReportTaskStatusResponseModel {
  String? id;
  String? name;
  String? reference;
  bool? defaultAt;
  String? color;
  bool? status;
  int? order;
  dynamic description;
  String? createdAt;
  String? updatedAt;

  ReportTaskStatusResponseModel(
      {this.id,
      this.name,
      this.reference,
      this.defaultAt,
      this.color,
      this.status,
      this.order,
      this.description,
      this.createdAt,
      this.updatedAt});

  ReportTaskStatusResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reference = json['reference'];
    defaultAt = json['default'];
    color = json['color'];
    status = json['status'];
    order = json['order'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['reference'] = reference;
    data['default'] = defaultAt;
    data['color'] = color;
    data['status'] = status;
    data['order'] = order;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<ReportTaskStatusResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ReportTaskStatusResponseModel.fromJson(json))
        .toList();
  }
}
