class LeadDetailAttachmentListResponseModel {
  String? id;
  String? type;
  String? filename;
  String? typeName;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  UploadedBy? uploadedBy;

  LeadDetailAttachmentListResponseModel(
      {this.id,
      this.type,
      this.filename,
      this.typeName,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.uploadedBy});

  LeadDetailAttachmentListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    filename = json['filename'];
    typeName = json['type_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    uploadedBy = json['uploaded_by'] != null
        ? UploadedBy.fromJson(json['uploaded_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['filename'] = filename;
    data['type_name'] = typeName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (uploadedBy != null) {
      data['uploaded_by'] = uploadedBy!.toJson();
    }
    return data;
  }

  static List<LeadDetailAttachmentListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailAttachmentListResponseModel.fromJson(json))
        .toList();
  }
}

class UploadedBy {
  String? id;
  String? firstName;
  String? lastName;

  UploadedBy({this.id, this.firstName, this.lastName});

  UploadedBy.fromJson(Map<String, dynamic> json) {
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
}
