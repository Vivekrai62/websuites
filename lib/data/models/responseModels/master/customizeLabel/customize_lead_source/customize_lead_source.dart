class CustomizeLeadSourceResponseModel {
  String? id;
  String? key;
  String? defaultLabel;
  String? updatedAt;

  CustomizeLeadSourceResponseModel(
      {this.id, this.key, this.defaultLabel, this.updatedAt});

  CustomizeLeadSourceResponseModel.fromJson(Map<String, dynamic> json) {
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

  static List<CustomizeLeadSourceResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomizeLeadSourceResponseModel.fromJson(json))
        .toList();
  }
}
