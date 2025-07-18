class UserDepartmentAddResponseModel {
  UserDepartmentAddResponseModel({
    required this.name,
    required this.description,
    required this.id,
    required this.isDefault, // Renamed for clarity
    required this.createdAt,
    required this.updatedAt,
  });

  final String? name;
  final String? description;
  final String? id;
  final bool? isDefault; // Renamed for clarity
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory UserDepartmentAddResponseModel.fromJson(Map<String, dynamic> json) {
    return UserDepartmentAddResponseModel(
      name: json["name"],
      description: json["description"],
      id: json["id"],
      isDefault: json["default"], // Renamed for clarity
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}