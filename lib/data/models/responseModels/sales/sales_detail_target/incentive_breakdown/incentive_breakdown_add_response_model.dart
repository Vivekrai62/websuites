class IncentiveBreakdownAddResponseModel {
  int? achievePercentage;
  int? incentive;
  String? incentiveType;
  TargetIncentiveMember? targetIncentiveMember;
  CreatedBy? createdBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  IncentiveBreakdownAddResponseModel(
      {this.achievePercentage,
      this.incentive,
      this.incentiveType,
      this.targetIncentiveMember,
      this.createdBy,
      this.id,
      this.createdAt,
      this.updatedAt});

  IncentiveBreakdownAddResponseModel.fromJson(Map<String, dynamic> json) {
    achievePercentage = json['achieve_percentage'];
    incentive = json['incentive'];
    incentiveType = json['incentive_type'];
    targetIncentiveMember = json['target_incentive_member'] != null
        ? TargetIncentiveMember.fromJson(json['target_incentive_member'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['achieve_percentage'] = achievePercentage;
    data['incentive'] = incentive;
    data['incentive_type'] = incentiveType;
    if (targetIncentiveMember != null) {
      data['target_incentive_member'] = targetIncentiveMember!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TargetIncentiveMember {
  String? id;
  int? saleTarget;
  String? createdAt;
  String? updatedAt;
  TargetIncentive? targetIncentive;

  TargetIncentiveMember(
      {this.id,
      this.saleTarget,
      this.createdAt,
      this.updatedAt,
      this.targetIncentive});

  TargetIncentiveMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleTarget = json['sale_target'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    targetIncentive = json['target_incentive'] != null
        ? TargetIncentive.fromJson(json['target_incentive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale_target'] = saleTarget;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (targetIncentive != null) {
      data['target_incentive'] = targetIncentive!.toJson();
    }
    return data;
  }
}

class TargetIncentive {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  int? saleTarget;
  Team? team;
  String? createdAt;
  String? updatedAt;

  TargetIncentive(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.saleTarget,
      this.team,
      this.createdAt,
      this.updatedAt});

  TargetIncentive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    saleTarget = json['sale_target'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['sale_target'] = saleTarget;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Team {
  String? id;
  dynamic bio;
  String? email;
  String? mobile;
  bool? status;
  dynamic address;
  bool? defaultAt;
  List<Null>? children;
  String? password;
  bool? tracking;
  String? deviceId;
  String? lastName;
  List<RoleList>? roleList;
  dynamic smsSender;
  String? createdAt;
  String? firstName;
  bool? mobileApp;
  dynamic smtpSender;
  String? updatedAt;
  dynamic profilePic;
  String? crmCategory;
  dynamic mailjetSender;
  bool? superSettings;
  String? rememberToken;
  String? rememberTokenTime;

  Team(
      {this.id,
      this.bio,
      this.email,
      this.mobile,
      this.status,
      this.address,
      this.defaultAt,
      this.children,
      this.password,
      this.tracking,
      this.deviceId,
      this.lastName,
      this.roleList,
      this.smsSender,
      this.createdAt,
      this.firstName,
      this.mobileApp,
      this.smtpSender,
      this.updatedAt,
      this.profilePic,
      this.crmCategory,
      this.mailjetSender,
      this.superSettings,
      this.rememberToken,
      this.rememberTokenTime});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bio = json['bio'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    address = json['address'];
    defaultAt = json['default'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add((v));
      });
    }
    password = json['password'];
    tracking = json['tracking'];
    deviceId = json['device_id'];
    lastName = json['last_name'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    smsSender = json['smsSender'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    mobileApp = json['mobile_app'];
    smtpSender = json['smtpSender'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    crmCategory = json['crm_category'];
    mailjetSender = json['mailjetSender'];
    superSettings = json['superSettings'];
    rememberToken = json['remember_token'];
    rememberTokenTime = json['remember_token_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bio'] = bio;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['address'] = address;
    data['default'] = defaultAt;
    if (children != null) {
      data['children'] = children!.map((v) => ()).toList();
    }
    data['password'] = password;
    data['tracking'] = tracking;
    data['device_id'] = deviceId;
    data['last_name'] = lastName;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    data['smsSender'] = smsSender;
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['mobile_app'] = mobileApp;
    data['smtpSender'] = smtpSender;
    data['updated_at'] = updatedAt;
    data['profile_pic'] = profilePic;
    data['crm_category'] = crmCategory;
    data['mailjetSender'] = mailjetSender;
    data['superSettings'] = superSettings;
    data['remember_token'] = rememberToken;
    data['remember_token_time'] = rememberTokenTime;
    return data;
  }
}

class RoleList {
  String? id;
  String? name;
  bool? defaultAt;
  String? description;

  RoleList({this.id, this.name, this.defaultAt, this.description});

  RoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultAt = json['default'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['default'] = defaultAt;
    data['description'] = description;
    return data;
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
  dynamic profilePic;
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
  dynamic parent;
  List<RoleList>? roleList;
  dynamic department;
  dynamic mailjetSender;
  dynamic smtpSender;

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
      this.parent,
      this.roleList,
      this.department,
      this.mailjetSender,
      this.smtpSender});

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
    parent = json['parent'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    department = json['department'];
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
    data['default'] = defaultAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    data['parent'] = parent;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    data['department'] = department;
    data['mailjetSender'] = mailjetSender;
    data['smtpSender'] = smtpSender;
    return data;
  }
}
