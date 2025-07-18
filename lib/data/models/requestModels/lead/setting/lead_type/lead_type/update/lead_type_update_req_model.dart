class LeadTypeUpdateReqModel {
  String? name;
  String? status;
  bool? isReminderRequired;

  LeadTypeUpdateReqModel({this.name, this.status, this.isReminderRequired});

  LeadTypeUpdateReqModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    status = json['status'];
    isReminderRequired = json['isReminderRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['status'] = this.status;
    data['isReminderRequired'] = this.isReminderRequired;
    return data;
  }
}
