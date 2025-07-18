class LeadAssignResponseModel {
  String? id;
  String? firstName;
  String? lastName;

  LeadAssignResponseModel({this.id, this.firstName, this.lastName});

  LeadAssignResponseModel.fromJson(Map<String, dynamic> json) {
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
  static List<LeadAssignResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>LeadAssignResponseModel.fromJson(json)).toList();
  }
}