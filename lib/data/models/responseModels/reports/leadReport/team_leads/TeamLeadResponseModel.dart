class TeamLeadResponseModel {
  TeamLeadResponseModel({
    required this.user,
    required this.leadType,
    required this.total,
  });

  final User? user;
  final List<LeadType> leadType;
  final int? total;

  factory TeamLeadResponseModel.fromJson(Map<String, dynamic> json) {
    return TeamLeadResponseModel(
      user: json["user"] == null ? null : User.fromJson(json["user"]),
      leadType: json["lead_type"] == null
          ? []
          : List<LeadType>.from(json["lead_type"]!.map((x) => LeadType.fromJson(x))),
      total: json["total"],
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      "user": user?.toJson(),
      "lead_type": leadType.map((e) => e.toJson()).toList(),
      "total": total,
    };
  }

  // Static method to parse a list
  static List<TeamLeadResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TeamLeadResponseModel.fromJson(json)).toList();
  }
}

class LeadType {
  LeadType({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.leads,
    required this.leadCount,
  });

  final String? id;
  final String? name;
  final DateTime? createdAt;
  final dynamic leads;
  final int? leadCount;

  factory LeadType.fromJson(Map<String, dynamic> json) {
    return LeadType(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      leads: json["leads"],
      leadCount: json["leadCount"],
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "created_at": createdAt?.toIso8601String(),
      "leads": leads,
      "leadCount": leadCount,
    };
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
    );
  }

  // Add toJson method
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
    };
  }
}