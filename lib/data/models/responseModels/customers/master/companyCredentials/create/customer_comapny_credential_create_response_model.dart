class CustomerCompanyCredentialCreateResponseModel {
  String? name;
  String? id;
  String? createdAt;
  String? updatedAt;

  CustomerCompanyCredentialCreateResponseModel(
      {this.name, this.id, this.createdAt, this.updatedAt});

  CustomerCompanyCredentialCreateResponseModel.fromJson(
      Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
