class CustomerMasterCompanyCredentialResponseModel {
  String? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  CustomerMasterCompanyCredentialResponseModel(
      {this.id, this.name, this.createdAt, this.updatedAt});

  CustomerMasterCompanyCredentialResponseModel.fromJson(
      Map<String, dynamic> json) {
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

  static List<CustomerMasterCompanyCredentialResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerMasterCompanyCredentialResponseModel.fromJson(json)).toList();
  }
}


