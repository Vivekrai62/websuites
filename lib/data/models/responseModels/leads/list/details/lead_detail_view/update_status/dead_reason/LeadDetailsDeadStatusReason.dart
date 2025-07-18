class LeadDetailsDeadStatusReason {
  String? id;
  String? reason;
  bool? status;
  String? createdAt;
  String? updatedAt;

  LeadDetailsDeadStatusReason({
    this.id,
    this.reason,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  LeadDetailsDeadStatusReason.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['reason'] = reason;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }


  static List<LeadDetailsDeadStatusReason> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsDeadStatusReason.fromJson(json))
        .toList();
  }
}
