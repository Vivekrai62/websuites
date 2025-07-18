class UserAddRoleResponseModel {
  UserAddRoleResponseModel({
    this.name,
    this.description,
    this.id,
    this.isDefault,
  });

  final String? name;
  final String? description;
  final String? id;
  final bool? isDefault;

  factory UserAddRoleResponseModel.fromJson(Map<String, dynamic> json) {
    return UserAddRoleResponseModel(
      name: json["name"],
      description: json["description"],
      id: json["id"],
      isDefault: json["default"],
    );
  }

  // Optional: Add toJson method if you need to serialize the model
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "description": description,
      "id": id,
      "default": isDefault,
    };
  }
}