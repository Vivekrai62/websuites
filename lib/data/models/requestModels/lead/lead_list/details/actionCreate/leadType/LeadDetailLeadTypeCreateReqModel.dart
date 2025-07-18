class LeadDetailLeadTypeCreateReqModel {
  String? activity;
  String? leadType;
  String? subLeadType;
  int? lat;
  int? lng;
  String? remark;

  LeadDetailLeadTypeCreateReqModel(
      {this.activity,
        this.leadType,
        this.subLeadType,
        this.lat,
        this.lng,
        this.remark});

  LeadDetailLeadTypeCreateReqModel.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    leadType = json['lead_type'];
    subLeadType = json['sub_lead_type'];
    lat = json['lat'];
    lng = json['lng'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = this.activity;
    data['lead_type'] = this.leadType;
    data['sub_lead_type'] = this.subLeadType;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['remark'] = this.remark;
    return data;
  }
}
