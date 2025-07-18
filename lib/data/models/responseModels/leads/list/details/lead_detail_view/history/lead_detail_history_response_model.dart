class LeadDetailHistoryResponseModel {
  String? id;
  String? activity;
  String? remark;
  String? leadStatus;
  String? reminder;
  bool? reminderStatus;
  dynamic meetingWith;
  dynamic meetingWithName;
  dynamic meetingWithPhone;
  int? meetingWithCountryCode;
  dynamic dateContacted;
  String? services;
  double? lat;
  double? lng;
  dynamic ccTo;
  bool? informedToCustomer;
  dynamic remoteLocation;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  int? callDuration;
  dynamic recordFile;
  dynamic callActivtyDescription;
  CreatedBy? createdBy;
  dynamic visitedWith;
  CreatedBy? reminderTo;
  dynamic screenshot;
  dynamic leadType;
  dynamic leadStatusValue;
  dynamic whatsappLog;

  LeadDetailHistoryResponseModel(
      {this.id,
      this.activity,
      this.remark,
      this.leadStatus,
      this.reminder,
      this.reminderStatus,
      this.meetingWith,
      this.meetingWithName,
      this.meetingWithPhone,
      this.meetingWithCountryCode,
      this.dateContacted,
      this.services,
      this.lat,
      this.lng,
      this.ccTo,
      this.informedToCustomer,
      this.remoteLocation,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.callDuration,
      this.recordFile,
      this.callActivtyDescription,
      this.createdBy,
      this.visitedWith,
      this.reminderTo,
      this.screenshot,
      this.leadType,
      this.leadStatusValue,
      this.whatsappLog});

  LeadDetailHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activity = json['activity'];
    remark = json['remark'];
    leadStatus = json['leadStatus'];
    reminder = json['reminder'];
    reminderStatus = json['reminder_status'];
    meetingWith = json['meeting_with'];
    meetingWithName = json['meeting_with_name'];
    meetingWithPhone = json['meeting_with_phone'];
    meetingWithCountryCode = json['meeting_with_country_code'];
    dateContacted = json['date_contacted'];
    services = json['services'];
    lat = json['lat'];
    lng = json['lng'];
    ccTo = json['cc_to'];
    informedToCustomer = json['informed_to_customer'];
    remoteLocation = json['remote_location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    callDuration = json['call_duration'];
    recordFile = json['record_file'];
    callActivtyDescription = json['call_activty_description'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    visitedWith = json['visited_with'];
    reminderTo = json['reminder_to'] != null
        ? CreatedBy.fromJson(json['reminder_to'])
        : null;
    screenshot = json['screenshot'];
    leadType = json['lead_type'];
    leadStatus = json['lead_status'];
    whatsappLog = json['whatsappLog'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['activity'] = activity;
    data['remark'] = remark;
    data['leadStatus'] = leadStatus;
    data['reminder'] = reminder;
    data['reminder_status'] = reminderStatus;
    data['meeting_with'] = meetingWith;
    data['meeting_with_name'] = meetingWithName;
    data['meeting_with_phone'] = meetingWithPhone;
    data['meeting_with_country_code'] = meetingWithCountryCode;
    data['date_contacted'] = dateContacted;
    data['services'] = services;
    data['lat'] = lat;
    data['lng'] = lng;
    data['cc_to'] = ccTo;
    data['informed_to_customer'] = informedToCustomer;
    data['remote_location'] = remoteLocation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['call_duration'] = callDuration;
    data['record_file'] = recordFile;
    data['call_activty_description'] = callActivtyDescription;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['visited_with'] = visitedWith;
    if (reminderTo != null) {
      data['reminder_to'] = reminderTo!.toJson();
    }
    data['screenshot'] = screenshot;
    data['lead_type'] = leadType;
    data['lead_status'] = leadStatus;
    data['whatsappLog'] = whatsappLog;
    return data;
  }

  static List<LeadDetailHistoryResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailHistoryResponseModel.fromJson(json))
        .toList();
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? bio;
  String? profilePic;
  String? password;
  bool? status;
  dynamic rememberToken;
  dynamic rememberTokenTime;
  bool? defaultAt;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;
  List<RoleList>? roleList;
  MailjetSender? mailjetSender;
  dynamic smtpSender;
  dynamic smsSender;

  CreatedBy(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.address,
      this.bio,
      this.profilePic,
      this.password,
      this.status,
      this.rememberToken,
      this.rememberTokenTime,
      this.defaultAt,
      this.createdAt,
      this.updatedAt,
      this.deviceId,
      this.tracking,
      this.crmCategory,
      this.mobileApp,
      this.superSettings,
      this.roleList,
      this.mailjetSender,
      this.smtpSender,
      this.smsSender});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    bio = json['bio'];
    profilePic = json['profile_pic'];
    password = json['password'];
    status = json['status'];
    rememberToken = json['remember_token'];
    rememberTokenTime = json['remember_token_time'];
    defaultAt = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    tracking = json['tracking'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    mailjetSender = json['mailjetSender'] != null
        ? MailjetSender.fromJson(json['mailjetSender'])
        : null;
    smtpSender = json['smtpSender'];
    smsSender = json['smsSender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['bio'] = bio;
    data['profile_pic'] = profilePic;
    data['password'] = password;
    data['status'] = status;
    data['remember_token'] = rememberToken;
    data['remember_token_time'] = rememberTokenTime;
    data['default'] = defaultAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    if (mailjetSender != null) {
      data['mailjetSender'] = mailjetSender!.toJson();
    }
    data['smtpSender'] = smtpSender;
    data['smsSender'] = smsSender;
    return data;
  }
}

class RoleList {
  String? id;
  String? name;
  String? description;
  bool? defaultAt;

  RoleList({this.id, this.name, this.description, this.defaultAt});

  RoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    defaultAt = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['default'] = defaultAt;
    return data;
  }
}

class MailjetSender {
  String? id;
  String? provider;
  String? name;
  String? email;
  bool? status;
  String? mailjetSenderId;
  dynamic smtpHost;
  dynamic smtpPassword;
  dynamic smtpPort;
  dynamic smtpAuthentication;
  bool? isDefaultSender;
  String? createdAt;
  String? updatedAt;

  MailjetSender(
      {this.id,
      this.provider,
      this.name,
      this.email,
      this.status,
      this.mailjetSenderId,
      this.smtpHost,
      this.smtpPassword,
      this.smtpPort,
      this.smtpAuthentication,
      this.isDefaultSender,
      this.createdAt,
      this.updatedAt});

  MailjetSender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    name = json['name'];
    email = json['email'];
    status = json['status'];
    mailjetSenderId = json['mailjet_sender_id'];
    smtpHost = json['smtp_host'];
    smtpPassword = json['smtp_password'];
    smtpPort = json['smtp_port'];
    smtpAuthentication = json['smtp_authentication'];
    isDefaultSender = json['is_default_sender'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['name'] = name;
    data['email'] = email;
    data['status'] = status;
    data['mailjet_sender_id'] = mailjetSenderId;
    data['smtp_host'] = smtpHost;
    data['smtp_password'] = smtpPassword;
    data['smtp_port'] = smtpPort;
    data['smtp_authentication'] = smtpAuthentication;
    data['is_default_sender'] = isDefaultSender;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
