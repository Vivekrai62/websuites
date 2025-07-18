class SettingCustomFieldsResponseModel {
  String? id;
  String? fieldFor;
  String? fieldLabel;
  String? fieldName;
  String? type;
  String? description;
  String? answers;
  String? pattern; // Changed from Null to String?
  int? maxValue;
  bool? required;
  bool? requiredForCustomer;
  String? defaultValue;
  bool? multiple;
  String? createdAt;
  String? updatedAt;
  List<String>? leadCustomFieldEditRestrictions; // Changed from List<Null> to List<String>
  List<String>? restrictedRoles; // Changed from List<Null> to List<String>

  SettingCustomFieldsResponseModel({
    this.id,
    this.fieldFor,
    this.fieldLabel,
    this.fieldName,
    this.type,
    this.description,
    this.answers,
    this.pattern,
    this.maxValue,
    this.required,
    this.requiredForCustomer,
    this.defaultValue,
    this.multiple,
    this.createdAt,
    this.updatedAt,
    this.leadCustomFieldEditRestrictions,
    this.restrictedRoles,
  });

  SettingCustomFieldsResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldFor = json['field_for'];
    fieldLabel = json['field_label'];
    fieldName = json['field_name'];
    type = json['type'];
    description = json['description'];
    answers = json['answers'];
    pattern = json['pattern']; // Adjusted from Null to String
    maxValue = json['max_value'];
    required = json['required'];
    requiredForCustomer = json['required_for_customer'];
    defaultValue = json['default_value'];
    multiple = json['multiple'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    // Adjusted from List<Null> to List<String> or appropriate type
    if (json['lead_custom_field_edit_restrictions'] != null) {
      leadCustomFieldEditRestrictions = List<String>.from(json['lead_custom_field_edit_restrictions']);
    }

    if (json['restricted_roles'] != null) {
      restrictedRoles = List<String>.from(json['restricted_roles']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_for'] = fieldFor;
    data['field_label'] = fieldLabel;
    data['field_name'] = fieldName;
    data['type'] = type;
    data['description'] = description;
    data['answers'] = answers;
    data['pattern'] = pattern;
    data['max_value'] = maxValue;
    data['required'] = required;
    data['required_for_customer'] = requiredForCustomer;
    data['default_value'] = defaultValue;
    data['multiple'] = multiple;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    if (leadCustomFieldEditRestrictions != null) {
      data['lead_custom_field_edit_restrictions'] = leadCustomFieldEditRestrictions;
    }

    if (restrictedRoles != null) {
      data['restricted_roles'] = restrictedRoles;
    }

    return data;
  }

  static List<SettingCustomFieldsResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SettingCustomFieldsResponseModel.fromJson(json)).toList();
  }
}
