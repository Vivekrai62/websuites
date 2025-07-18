class DbLeadTypeResModel {
  DbLeadTypeResModel({
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

  factory DbLeadTypeResModel.fromJson(Map<String, dynamic> json){
    return DbLeadTypeResModel(
      id: json["id"],
      name: json["name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      leads: json["leads"],
      leadCount: json["leadCount"],
    );
  }

}

