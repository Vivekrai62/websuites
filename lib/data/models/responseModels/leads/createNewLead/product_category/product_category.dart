class LeadProductCategoryList {
  final String? id;
  final String? name;
  final String? type;
  final String? description;
  final String? hsnCode;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final dynamic requirementsForm;
  final bool? mailRequirementsFormToCustomer;
  final bool? isActivationFormEnabled;

  LeadProductCategoryList({
    this.id,
    this.name,
    this.type,
    this.description,
    this.hsnCode,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.requirementsForm,
    this.mailRequirementsFormToCustomer,
    this.isActivationFormEnabled,
  });

  factory LeadProductCategoryList.fromJson(Map<String, dynamic> json) {
    return LeadProductCategoryList(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      description: json['description'],
      hsnCode: json['HSN_code'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      requirementsForm: json['requirementsForm'], // Optional: deserialize this if needed
      mailRequirementsFormToCustomer: json['mailRequirementsFormToCustomer'],
      isActivationFormEnabled: json['is_activation_form_enabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'HSN_code': hsnCode,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'requirementsForm': requirementsForm,
      'mailRequirementsFormToCustomer': mailRequirementsFormToCustomer,
      'is_activation_form_enabled': isActivationFormEnabled,
    };
  }

  /// Add this static method to parse a list of JSON
  static List<LeadProductCategoryList> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadProductCategoryList.fromJson(json)).toList();
  }
}



class RequirementsForm {
  RequirementsForm({
    required this.fields,
  });

  final List<Field> fields;

  factory RequirementsForm.fromJson(Map<String, dynamic> json){
    return RequirementsForm(
      fields: json["fields"] == null ? [] : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
    );
  }

}

class Field {
  Field({
    required this.isLocked,
    required this.isRequired,
    required this.options,
    required this.label,
    required this.type,
  });

  final bool? isLocked;
  final bool? isRequired;
  final List<dynamic> options;
  final String? label;
  final String? type;

  factory Field.fromJson(Map<String, dynamic> json){
    return Field(
      isLocked: json["isLocked"],
      isRequired: json["isRequired"],
      options: json["options"] == null ? [] : List<dynamic>.from(json["options"]!.map((x) => x)),
      label: json["label"],
      type: json["type"],
    );
  }

}
