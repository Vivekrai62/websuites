class LeadSettingCustomLeadLabel {
  String? id;
  String? fieldFor;
  String? fieldLabel;
  String? fieldName;
  String? type;
  String? description;
  String? answers;
  String? pattern;
  int? maxValue;
  bool? required;
  bool? requiredForCustomer;
  String? defaultValue;
  bool? multiple;
  String? createdAt;
  String? updatedAt;
  List<dynamic>? leadCustomFieldEditRestrictions;
  List<dynamic>? restrictedRoles;

  LeadSettingCustomLeadLabel({
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

  LeadSettingCustomLeadLabel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    fieldFor = json['field_for'] as String?;
    fieldLabel = json['field_label'] as String?;
    fieldName = json['field_name'] as String?;
    type = json['type'] as String?;
    description = json['description'] as String?;
    answers = json['answers'] as String?;
    pattern = json['pattern'] as String?;
    maxValue = json['max_value'] as int?;
    required = json['required'] as bool?;
    requiredForCustomer = json['required_for_customer'] as bool?;
    defaultValue = json['default_value'] as String?;
    multiple = json['multiple'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    leadCustomFieldEditRestrictions = json['lead_custom_field_edit_restrictions'] as List<dynamic>?;
    restrictedRoles = json['restricted_roles'] as List<dynamic>?;
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
    data['lead_custom_field_edit_restrictions'] = leadCustomFieldEditRestrictions;
    data['restricted_roles'] = restrictedRoles;
    return data;
  }

  // New method to parse a list of JSON objects
  static List<LeadSettingCustomLeadLabel> fromJsonList(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .where((json) => json is Map<String, dynamic>)
        .map((json) => LeadSettingCustomLeadLabel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}