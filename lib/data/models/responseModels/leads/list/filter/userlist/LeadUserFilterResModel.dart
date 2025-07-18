class LeadUserFilterResModel {
  String? id;
  String? firstName;
  String? lastName;

  LeadUserFilterResModel({this.id, this.firstName, this.lastName});

  LeadUserFilterResModel.fromJson(Map<String, dynamic> json) {
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

  static List<LeadUserFilterResModel> fromJsonList(dynamic jsonList) {
    if (jsonList is List) {
      return jsonList
          .map((json) => LeadUserFilterResModel.fromJson(json))
          .toList();
    }
    return [];
  }
}
