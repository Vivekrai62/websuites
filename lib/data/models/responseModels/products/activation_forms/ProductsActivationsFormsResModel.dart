class ProductsActivationsFormsResModel {
  ProductsActivationsFormsResModel({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.hsnCode,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.requirementsForm,
    required this.mailRequirementsFormToCustomer,
    required this.isActivationFormEnabled,
    required this.parent,
    required this.requirementsMailToUser,
    required this.requirementsCcToUsers,
  });

  final String? id;
  final String? name;
  final dynamic type;
  final String? description;
  final dynamic hsnCode;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final RequirementsForm? requirementsForm;
  final bool? mailRequirementsFormToCustomer;
  final bool? isActivationFormEnabled;
  final ProductsActivationsFormsResModel? parent;
  final RequirementsToUser? requirementsMailToUser;
  final List<RequirementsToUser> requirementsCcToUsers;

  factory ProductsActivationsFormsResModel.fromJson(Map<String, dynamic> json) {
    return ProductsActivationsFormsResModel(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      description: json["description"],
      hsnCode: json["HSN_code"],
      image: json["image"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      requirementsForm: json["requirementsForm"] == null
          ? null
          : RequirementsForm.fromJson(json["requirementsForm"]),
      mailRequirementsFormToCustomer: json["mailRequirementsFormToCustomer"],
      isActivationFormEnabled: json["is_activation_form_enabled"],
      parent: json["parent"] == null
          ? null
          : ProductsActivationsFormsResModel.fromJson(json["parent"]),
      requirementsMailToUser: json["requirementsMailToUser"] == null
          ? null
          : RequirementsToUser.fromJson(json["requirementsMailToUser"]),
      requirementsCcToUsers: json["requirementsCcToUsers"] == null
          ? []
          : List<RequirementsToUser>.from(
          json["requirementsCcToUsers"]!.map((x) => RequirementsToUser.fromJson(x))),
    );
  }

  // Add this static method to parse a role of JSON objects
  static List<ProductsActivationsFormsResModel> fromJsonList(dynamic jsonList) {
    if (jsonList == null || jsonList is! List) {
      return [];
    }
    return jsonList
        .map((json) => ProductsActivationsFormsResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class RequirementsToUser {
  RequirementsToUser({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory RequirementsToUser.fromJson(Map<String, dynamic> json){
    return RequirementsToUser(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
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
