class CustomerMasterFieldCreateResponseModel {
  String? fieldLabel;
  String? fieldName;
  String? type;
  String? answers;
  bool? required;
  String? id;
  bool? defaultAt;
  String? createdAt;
  String? updatedAt;

  CustomerMasterFieldCreateResponseModel(
      {this.fieldLabel,
      this.fieldName,
      this.type,
      this.answers,
      this.required,
      this.id,
      this.defaultAt,
      this.createdAt,
      this.updatedAt});

  CustomerMasterFieldCreateResponseModel.fromJson(Map<String, dynamic> json) {
    fieldLabel = json['field_label'];
    fieldName = json['field_name'];
    type = json['type'];
    answers = json['answers'];
    required = json['required'];
    id = json['id'];
    defaultAt = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['field_label'] = fieldLabel;
    data['field_name'] = fieldName;
    data['type'] = type;
    data['answers'] = answers;
    data['required'] = required;
    data['id'] = id;
    data['default'] = defaultAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
