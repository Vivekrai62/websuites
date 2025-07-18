class ActivityPurposeCreateResponseModel {
  String? type;
  String? name;
  String? id;
  bool? status;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  ActivityPurposeCreateResponseModel(
      {this.type,
        this.name,
        this.id,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  ActivityPurposeCreateResponseModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    name = json['name'];
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['name'] = name;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}