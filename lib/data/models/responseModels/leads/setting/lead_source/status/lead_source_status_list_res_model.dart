class LeadSourceStatusListResModel {
  LeadSourceStatusListResModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updateAt,
  });
  late final String id;
  late final String name;
  late final String status;
  late final String createdAt;
  late final String updateAt;

  LeadSourceStatusListResModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['status'] = status;
    _data['created_at'] = createdAt;
    _data['update_at'] = updateAt;
    return _data;
  }
}