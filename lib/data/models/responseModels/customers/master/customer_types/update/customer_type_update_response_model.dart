class CustomerTypeUpdateResponseModel {
  String? id;
  bool? status;
  String? name;
  String? updatedAt;

  CustomerTypeUpdateResponseModel(
      {this.id, this.status, this.name, this.updatedAt});

  CustomerTypeUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    name = json['name'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['name'] = name;
    data['updated_at'] = updatedAt;
    return data;
  }
}
