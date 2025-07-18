class RoleListEditResponseModel {
  RoleListEditResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.roleListEditResponseModelDefault,
    required this.userPermissions,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? roleListEditResponseModelDefault;
  final List<UserPermission> userPermissions;

  factory RoleListEditResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleListEditResponseModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      roleListEditResponseModelDefault: json["default"],
      userPermissions: json["user_permissions"] == null
          ? []
          : List<UserPermission>.from(
          json["user_permissions"].map((x) => UserPermission.fromJson(x))),
    );
  }
}

class UserPermission {
  UserPermission({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserPermission.fromJson(Map<String, dynamic> json) {
    return UserPermission(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}