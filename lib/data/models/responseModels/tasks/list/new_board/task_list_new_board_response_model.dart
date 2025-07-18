class NewBoardResponseModel {
  String? name;
  String? reference;
  String? color;
  int? order;
  dynamic description;
  String? id;
  bool? defaultAt;
  bool? status;
  String? createdAt;
  String? updatedAt;

  NewBoardResponseModel(
      {this.name,
      this.reference,
      this.color,
      this.order,
      this.description,
      this.id,
      this.defaultAt,
      this.status,
      this.createdAt,
      this.updatedAt});

  NewBoardResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    reference = json['reference'];
    color = json['color'];
    order = json['order'];
    description = json['description'];
    id = json['id'];
    defaultAt = json['default'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['reference'] = reference;
    data['color'] = color;
    data['order'] = order;
    data['description'] = description;
    data['id'] = id;
    data['default'] = defaultAt;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
