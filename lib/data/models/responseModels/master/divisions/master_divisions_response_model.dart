class MasterDivisionsResponseModel {
  String? id;
  String? name;
  String? status;
  String? createdAt;

  MasterDivisionsResponseModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
  });

  MasterDivisionsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }

  static List<MasterDivisionsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MasterDivisionsResponseModel.fromJson(json)).toList();
  }
}
