class MasterProposalsResponseModel {
  String? id;
  String? subject;
  String? body;
  String? attachment;
  bool? status;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  MasterProposalsResponseModel(
      {this.id,
        this.subject,
        this.body,
        this.attachment,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  MasterProposalsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    body = json['body'];
    attachment = json['attachment'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['body'] = body;
    data['attachment'] = attachment;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
  static List<MasterProposalsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>MasterProposalsResponseModel.fromJson(json)).toList();
  }

}
