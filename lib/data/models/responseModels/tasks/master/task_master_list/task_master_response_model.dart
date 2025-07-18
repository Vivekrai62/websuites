class TaskMasterResponseModel {
  TaskMasterResponseModel({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory TaskMasterResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskMasterResponseModel(
      id: json["id"] as String?,
      name: json["name"] as String?,
      status: json["status"] as bool?,
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"] as String)
          : null,
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"] as String)
          : null,
    );
  }
}