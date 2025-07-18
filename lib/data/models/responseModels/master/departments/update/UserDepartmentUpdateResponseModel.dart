class UserDepartmentUpdateResponseModel {
  UserDepartmentUpdateResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.userDepartmentUpdateResponseModelDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? userDepartmentUpdateResponseModelDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserDepartmentUpdateResponseModel.fromJson(Map<String, dynamic> json){
    return UserDepartmentUpdateResponseModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      userDepartmentUpdateResponseModelDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
