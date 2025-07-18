class LeadSettingDeadUpdateReqModel {
  String? reason;
  bool? status;

  LeadSettingDeadUpdateReqModel({this.reason, this.status});

  LeadSettingDeadUpdateReqModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    data['status'] = this.status;
    return data;
  }
}
