class CustomerMasterActivationServicesResponseModel {
  String? id;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  CustomerMasterActivationServicesResponseModel(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  CustomerMasterActivationServicesResponseModel.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<CustomerMasterActivationServicesResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) =>
            CustomerMasterActivationServicesResponseModel.fromJson(json))
        .toList();
  }
}
