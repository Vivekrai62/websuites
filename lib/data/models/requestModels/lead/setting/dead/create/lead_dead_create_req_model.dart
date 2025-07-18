class LeadSettingDeadCreateReqModel {
  String? reason;

  LeadSettingDeadCreateReqModel({this.reason});

  LeadSettingDeadCreateReqModel.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reason'] = this.reason;
    return data;
  }
}
