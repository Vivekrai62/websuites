class HrmLeaveTypeResponseModel {
  HrmLeaveTypeResponseModel({
    required this.id,
    required this.type,
    required this.name,
    required this.shortCode,
    required this.paidOption,
    required this.description,
    required this.isEmployeeViewDescription,
    required this.isSickLeave,
    required this.limitGender,
    required this.limitMaritalStatus,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.reasons,
  });

  final String? id;
  final String? type;
  final String? name;
  final String? shortCode;
  final String? paidOption;
  final String? description;
  final bool? isEmployeeViewDescription;
  final bool? isSickLeave;
  final String? limitGender;
  final dynamic limitMaritalStatus;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<dynamic> reasons;

  // Adjusted fromJson method to handle List<dynamic> response
  factory HrmLeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return HrmLeaveTypeResponseModel(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      shortCode: json["short_code"],
      paidOption: json["paid_option"],
      description: json["description"],
      isEmployeeViewDescription: json["is_employee_view_description"],
      isSickLeave: json["is_sick_leave"],
      limitGender: json["limit_gender"],
      limitMaritalStatus: json["limit_marital_status"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      reasons: json["reasons"] == null ? [] : List<dynamic>.from(json["reasons"]!.map((x) => x)),
    );
  }

  // A new fromJsonList method to handle the response as a customer_list
  static List<HrmLeaveTypeResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => HrmLeaveTypeResponseModel.fromJson(json)).toList();
  }
}
