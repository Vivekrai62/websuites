class HrmLeavePlanResponseModel {
  HrmLeavePlanResponseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.leavePolicy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,  // No need to mark it required as it can be null
  });

  final String? id;
  final String? name;
  final String? description;
  final DateTime? startDate;
  final String? leavePolicy;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;  // Could be null, dynamic is fine

  factory HrmLeavePlanResponseModel.fromJson(Map<String, dynamic> json) {
    return HrmLeavePlanResponseModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      startDate: json["start_date"] != null
          ? DateTime.tryParse(json["start_date"])
          : null,  // Handle null and incorrect formats
      leavePolicy: json["leave_policy"],
      status: json["status"],
      createdAt: json["created_at"] != null
          ? DateTime.tryParse(json["created_at"])
          : null,  // Handle null and incorrect formats
      updatedAt: json["updated_at"] != null
          ? DateTime.tryParse(json["updated_at"])
          : null,  // Handle null and incorrect formats
      deletedAt: json["deleted_at"],  // No need to parse as it can be null
    );
  }

  static List<HrmLeavePlanResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HrmLeavePlanResponseModel.fromJson(json)).toList();
  }
}
