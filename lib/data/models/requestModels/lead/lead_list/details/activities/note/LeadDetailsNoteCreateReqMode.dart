class LeadDetailsNoteCreateReqMode {
  String? remark;
  String? activity;
  String? lead;
  bool? isSendEmail;
  bool? isSendSms;
  bool? isSendWhatsapp;
  double? lat;
  double? lng;

  LeadDetailsNoteCreateReqMode(
      {this.remark,
        this.activity,
        this.lead,
        this.isSendEmail,
        this.isSendSms,
        this.isSendWhatsapp,
        this.lat,
        this.lng});

  LeadDetailsNoteCreateReqMode.fromJson(Map<String, dynamic> json) {
    remark = json['remark'];
    activity = json['activity'];
    lead = json['lead'];
    isSendEmail = json['is_send_email'];
    isSendSms = json['is_send_sms'];
    isSendWhatsapp = json['is_send_whatsapp'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['remark'] = this.remark;
    data['activity'] = this.activity;
    data['lead'] = this.lead;
    data['is_send_email'] = this.isSendEmail;
    data['is_send_sms'] = this.isSendSms;
    data['is_send_whatsapp'] = this.isSendWhatsapp;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
