class CustomerDetailsActiAssignedResModel {
  CustomerDetailsActiAssignedResModel({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.user,
    required this.assignedBy,
    required this.department,
    required this.remark,
    required this.company,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final AssignedBy? user;
  final AssignedBy? assignedBy;
  final Department? department;
  final String? remark;
  final Company? company;

  factory CustomerDetailsActiAssignedResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsActiAssignedResModel(
      id: json["id"]?.toString(),
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      user: json["user"] == null ? null : AssignedBy.fromJson(json["user"]),
      assignedBy: json["assigned_by"] == null ? null : AssignedBy.fromJson(json["assigned_by"]),
      department: json["department"] == null ? null : Department.fromJson(json["department"]),
      remark: json["remark"],
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );
  }

  static List<CustomerDetailsActiAssignedResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsActiAssignedResModel.fromJson(json)).toList();
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

  factory AssignedBy.fromJson(Map<String, dynamic> json) {
    return AssignedBy(
      id: json["id"]?.toString(),
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }
}

class Department {
  Department({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json["id"]?.toString(),
      name: json["name"],
    );
  }
}

class Company {
  Company({
    required this.companyName,
    required this.companyEmail,
  });

  final String? companyName;
  final String? companyEmail;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json["company_name"],
      companyEmail: json["company_email"],
    );
  }
}