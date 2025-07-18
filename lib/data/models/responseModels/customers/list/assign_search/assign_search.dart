class CustomerAssignResponseModel {
  String? id;
  String? firstName;
  String? lastName;

  CustomerAssignResponseModel({this.id, this.firstName, this.lastName});

  CustomerAssignResponseModel.fromJson(Map<String, dynamic> json) {
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

  static List<CustomerAssignResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerAssignResponseModel.fromJson(json)).toList();
  }
}