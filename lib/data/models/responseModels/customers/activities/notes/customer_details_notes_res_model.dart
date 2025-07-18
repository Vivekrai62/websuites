class CustomerDetailsActiNotesResModel {
  CustomerDetailsActiNotesResModel({
    required this.id,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.company,
    required this.createdBy,
  });

  final String? id;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Company? company;
  final CreatedBy? createdBy;

  factory CustomerDetailsActiNotesResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsActiNotesResModel(
      id: json["id"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsActiNotesResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailsActiNotesResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"] as String?,
      companyName: json["company_name"] as String?,
      companyEmail: json["company_email"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "company_email": companyEmail,
  };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["id"] as String?,
      firstName: json["first_name"] as String?,
      lastName: json["last_name"] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}


