class LeadDetailsActiNotesResModel {
  LeadDetailsActiNotesResModel({
    required this.id,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.createdBy,
  });

  final String? id;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final CreatedBy? createdBy;

  factory LeadDetailsActiNotesResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsActiNotesResModel(
      id: json["id"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<LeadDetailsActiNotesResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiNotesResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "remark": remark,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_by": createdBy?.toJson(),
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

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
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
