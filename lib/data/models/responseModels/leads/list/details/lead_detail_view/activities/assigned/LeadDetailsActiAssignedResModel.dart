class LeadDetailsActiAssignedResModel {
  LeadDetailsActiAssignedResModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.user,
    required this.assignedBy,
    required this.department,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final AssignedBy? user;
  final AssignedBy? assignedBy;
  final Department? department;

  factory LeadDetailsActiAssignedResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsActiAssignedResModel(
      id: json["id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      user: json["user"] == null ? null : AssignedBy.fromJson(json["user"]),
      assignedBy: json["assigned_by"] == null ? null : AssignedBy.fromJson(json["assigned_by"]),
      department: json["department"] == null ? null : Department.fromJson(json["department"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "user": user?.toJson(),
    "assigned_by": assignedBy?.toJson(),
    "department": department?.toJson(),
  };

  /// Add this method to handle a list of JSON objects
  static List<LeadDetailsActiAssignedResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiAssignedResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}


class AssignedBy {
  AssignedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory AssignedBy.fromJson(Map<String, dynamic> json){
    return AssignedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };

}

class Department {
  Department({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Department.fromJson(Map<String, dynamic> json){
    return Department(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

}
