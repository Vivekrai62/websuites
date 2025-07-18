class CustomerTypeCreateResponseModel {
  String? name;
  Null parent;
  String? id;
  bool? status;
  String? createdAt;
  String? updatedAt;

  CustomerTypeCreateResponseModel(
      {this.name,
      this.parent,
      this.id,
      this.status,
      this.createdAt,
      this.updatedAt});

  CustomerTypeCreateResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    parent = json['parent'];
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['parent'] = parent;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
