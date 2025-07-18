class LeadDetailsLeadTypeReqModel {
  String? remark;
  String? status;
  String? reason;

  LeadDetailsLeadTypeReqModel({this.remark, this.status, this.reason});

  LeadDetailsLeadTypeReqModel.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}
