class TaskDescriptionResponseModel {
  String? id;
  String? description;
  String? createdAt;
  CreatedBy? createdBy;

  TaskDescriptionResponseModel(
      {this.id, this.description, this.createdAt, this.createdBy});

  TaskDescriptionResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['created_at'] = createdAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }

  static List<TaskDescriptionResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => TaskDescriptionResponseModel.fromJson(json))
        .toList();
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;

  CreatedBy({this.id, this.firstName, this.lastName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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
