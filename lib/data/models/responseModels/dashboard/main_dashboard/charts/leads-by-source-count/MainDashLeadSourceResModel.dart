class MainDashLeadSourceResModel {
  MainDashLeadSourceResModel({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updateAt,
    required this.leads,
    required this.leadCount,
  });

  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updateAt;
  final dynamic leads;
  final int? leadCount;

  factory MainDashLeadSourceResModel.fromJson(Map<String, dynamic> json){
    return MainDashLeadSourceResModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updateAt: DateTime.tryParse(json["update_at"] ?? ""),
      leads: json["leads"],
      leadCount: json["leadCount"],
    );
  }

}

