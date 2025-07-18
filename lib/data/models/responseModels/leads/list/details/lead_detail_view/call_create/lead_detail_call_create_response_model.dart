class LeadDetailActivityCallCreateResponseModel {
  String? activity;
  String? remark;
  String? reminder;
  bool? reminderStatus;
  String? services;
  double? lat;
  double? lng;
  String? ccTo;
  bool? informedToCustomer;
  Lead? lead;
  SubActivity? subActivity;
  String? leadType;
  String? subLeadType;
  String? leadStatus;
  String? visitedWith;
  Lead? createdBy;
  Lead? reminderTo;
  String? meetingWith;
  String? meetingWithName;
  String? meetingWithPhone;
  String? dateContacted;
  String? remoteLocation;
  String? recordFile;
  String? callActivtyDescription;
  String? id;
  int? meetingWithCountryCode;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? callDuration;

  LeadDetailActivityCallCreateResponseModel({
    this.activity,
    this.remark,
    this.reminder,
    this.reminderStatus,
    this.services,
    this.lat,
    this.lng,
    this.ccTo,
    this.informedToCustomer,
    this.lead,
    this.subActivity,
    this.leadType,
    this.subLeadType,
    this.leadStatus,
    this.visitedWith,
    this.createdBy,
    this.reminderTo,
    this.meetingWith,
    this.meetingWithName,
    this.meetingWithPhone,
    this.dateContacted,
    this.remoteLocation,
    this.recordFile,
    this.callActivtyDescription,
    this.id,
    this.meetingWithCountryCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.callDuration,
  });

  LeadDetailActivityCallCreateResponseModel.fromJson(Map<String, dynamic> json) {
    activity = json['activity'];
    remark = json['remark'];
    reminder = json['reminder'];
    reminderStatus = json['reminder_status'];
    services = json['services'];
    lat = json['lat'];
    lng = json['lng'];
    ccTo = json['cc_to'];
    informedToCustomer = json['informed_to_customer'];
    lead = json['lead'] != null ? Lead.fromJson(json['lead']) : null;
    subActivity = json['sub_activity'] != null
        ? SubActivity.fromJson(json['sub_activity'])
        : null;
    leadType = json['lead_type'];
    subLeadType = json['sub_lead_type'];
    leadStatus = json['lead_status'];
    visitedWith = json['visited_with'];
    createdBy =
    json['created_by'] != null ? Lead.fromJson(json['created_by']) : null;
    reminderTo =
    json['reminder_to'] != null ? Lead.fromJson(json['reminder_to']) : null;
    meetingWith = json['meeting_with'];
    meetingWithName = json['meeting_with_name'];
    meetingWithPhone = json['meeting_with_phone'];
    dateContacted = json['date_contacted'];
    remoteLocation = json['remote_location'];
    recordFile = json['record_file'];
    callActivtyDescription = json['call_activty_description'];
    id = json['id'];
    meetingWithCountryCode = json['meeting_with_country_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    callDuration = json['call_duration'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['activity'] = activity;
    data['remark'] = remark;
    data['reminder'] = reminder;
    data['reminder_status'] = reminderStatus;
    data['services'] = services;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cc_to'] = ccTo;
    data['informed_to_customer'] = informedToCustomer;
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    if (subActivity != null) {
      data['sub_activity'] = subActivity!.toJson();
    }
    data['lead_type'] = leadType;
    data['sub_lead_type'] = subLeadType;
    data['lead_status'] = leadStatus;
    data['visited_with'] = visitedWith;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (reminderTo != null) {
      data['reminder_to'] = reminderTo!.toJson();
    }
    data['meeting_with'] = meetingWith;
    data['meeting_with_name'] = meetingWithName;
    data['meeting_with_phone'] = meetingWithPhone;
    data['date_contacted'] = dateContacted;
    data['remote_location'] = remoteLocation;
    data['record_file'] = recordFile;
    data['call_activty_description'] = callActivtyDescription;
    data['id'] = id;
    data['meeting_with_country_code'] = meetingWithCountryCode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['call_duration'] = callDuration;
    return data;
  }
}

class Lead {
  String? id;

  Lead({this.id});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}

class SubActivity {
  String? id;
  String? type;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  SubActivity({
    this.id,
    this.type,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  SubActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
