class CompanyCredentialUpdateResponseModel {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CompanyCredentialUpdateResponseModel(
      {this.id, this.name, this.createdAt, this.updatedAt});

  CompanyCredentialUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
