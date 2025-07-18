class LeadSettingDeadReasonList {
  String? id;
  String? reason;
  bool? status;
  String? createdAt;
  String? updatedAt;

  LeadSettingDeadReasonList({
    this.id,
    this.reason,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  LeadSettingDeadReasonList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  /// 🔧 This is the method you were missing
  static List<LeadSettingDeadReasonList> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadSettingDeadReasonList.fromJson(json)).toList();
  }
}
