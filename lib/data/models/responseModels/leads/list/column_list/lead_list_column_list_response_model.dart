class LeadListColumnListResponseModel {
  String? id;
  String? leadField;
  String? fieldName;
  int? score;
  bool? filter;
  bool? status;
  String? type;
  String? userLeadFieldId;
  int? order;
  bool? isHiddenByUser;
  String? createdAt;
  String? updatedAt;

  LeadListColumnListResponseModel(
      {this.id,
      this.leadField,
      this.fieldName,
      this.score,
      this.filter,
      this.status,
      this.type,
      this.userLeadFieldId,
      this.order,
      this.isHiddenByUser,
      this.createdAt,
      this.updatedAt});

  LeadListColumnListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadField = json['lead_field'];
    fieldName = json['field_name'];
    score = json['score'];
    filter = json['filter'];
    status = json['status'];
    type = json['type'];
    userLeadFieldId = json['userLeadFieldId'];
    order = json['order'];
    isHiddenByUser = json['isHiddenByUser'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['lead_field'] = leadField;
    data['field_name'] = fieldName;
    data['score'] = score;
    data['filter'] = filter;
    data['status'] = status;
    data['type'] = type;
    data['userLeadFieldId'] = userLeadFieldId;
    data['order'] = order;
    data['isHiddenByUser'] = isHiddenByUser;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  static List<LeadListColumnListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadListColumnListResponseModel.fromJson(json))
        .toList();
  }
}
