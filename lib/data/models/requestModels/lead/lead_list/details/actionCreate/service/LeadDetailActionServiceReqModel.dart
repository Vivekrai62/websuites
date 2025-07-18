class LeadDetailActionServiceReqModel {
  String? activity;
  int? lat;
  int? lng;
  String? remark;
  List<String>? services;

  LeadDetailActionServiceReqModel(
      {this.activity, this.lat, this.lng, this.remark, this.services});

  LeadDetailActionServiceReqModel.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    lat = json['lat'];
    lng = json['lng'];
    remark = json['remark'];
    services = json['services'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activity'] = this.activity;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['remark'] = this.remark;
    data['services'] = this.services;
    return data;
  }
}
