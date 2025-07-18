class MasterCustomizeResponseModel {
  String? id;
  String? key;
  String? defaultLabel;
  String? updatedAt;

  MasterCustomizeResponseModel(
      {this.id, this.key, this.defaultLabel, this.updatedAt});

  MasterCustomizeResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    defaultLabel = json['default_label'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['default_label'] = defaultLabel;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<MasterCustomizeResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>MasterCustomizeResponseModel.fromJson(json)).toList();
  }

}