class CustomerOrderlessServiceQuitResponseModel {
  String? id;
  String? startDate;
  String? endDate;
  String? remark;
  String? reminderBeforeExpire;
  bool? status;
  String? quitReason;
  String? quitDate;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  bool? isDisposed;
  QuitBy? quitBy;

  CustomerOrderlessServiceQuitResponseModel(
      {this.id,
      this.startDate,
      this.endDate,
      this.remark,
      this.reminderBeforeExpire,
      this.status,
      this.quitReason,
      this.quitDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.isDisposed,
      this.quitBy});

  CustomerOrderlessServiceQuitResponseModel.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    remark = json['remark'];
    reminderBeforeExpire = json['reminder_before_expire'];
    status = json['status'];
    quitReason = json['quit_reason'];
    quitDate = json['quit_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    isDisposed = json['isDisposed'];
    quitBy = json['quit_by'] != null ? QuitBy.fromJson(json['quit_by']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['remark'] = remark;
    data['reminder_before_expire'] = reminderBeforeExpire;
    data['status'] = status;
    data['quit_reason'] = quitReason;
    data['quit_date'] = quitDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['isDisposed'] = isDisposed;
    if (quitBy != null) {
      data['quit_by'] = quitBy!.toJson();
    }
    return data;
  }
}

class QuitBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? bio;
  Null profilePic;
  String? password;
  bool? status;
  Null rememberToken;
  Null rememberTokenTime;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;
  Null parent;
  Null department;
  List<RoleList>? roleList;
  RoleList? role;
  Null mailjetSender;
  Null smtpSender;

  QuitBy(
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
      this.createdAt,
      this.updatedAt,
      this.deviceId,
      this.tracking,
      this.crmCategory,
      this.mobileApp,
      this.superSettings,
      this.parent,
      this.department,
      this.roleList,
      this.role,
      this.mailjetSender,
      this.smtpSender});

  QuitBy.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    tracking = json['tracking'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
    parent = json['parent'];
    department = json['department'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    role = json['role'] != null ? RoleList.fromJson(json['role']) : null;
    mailjetSender = json['mailjetSender'];
    smtpSender = json['smtpSender'];
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    data['parent'] = parent;
    data['department'] = department;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['mailjetSender'] = mailjetSender;
    data['smtpSender'] = smtpSender;
    return data;
  }
}

class RoleList {
  String? id;
  String? name;
  String? description;

  RoleList({
    this.id,
    this.name,
    this.description,
  });

  RoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    return data;
  }
}
