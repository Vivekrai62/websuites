class AddMasterProposalResponseModel {
  AddMasterProposalResponseModel({
    required this.subject,
    required this.body,
    required this.attachment,
    required this.createdBy,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String? subject;
  final String? body;
  final String? attachment;
  final CreatedBy? createdBy;
  final String? id;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory AddMasterProposalResponseModel.fromJson(Map<String, dynamic> json){
    return AddMasterProposalResponseModel(
      subject: json["subject"],
      body: json["body"],
      attachment: json["attachment"],
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      id: json["id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.bio,
    required this.profilePic,
    required this.password,
    required this.status,
    required this.rememberToken,
    required this.rememberTokenTime,
    required this.createdByDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.parent,
    required this.roleList,
    required this.department,
    required this.mailjetSender,
    required this.smtpSender,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final dynamic address;
  final dynamic bio;
  final dynamic profilePic;
  final String? password;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? createdByDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;
  final dynamic parent;
  final List<RoleList> roleList;
  final dynamic department;
  final dynamic mailjetSender;
  final dynamic smtpSender;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile: json["mobile"],
      address: json["address"],
      bio: json["bio"],
      profilePic: json["profile_pic"],
      password: json["password"],
      status: json["status"],
      rememberToken: json["remember_token"],
      rememberTokenTime: json["remember_token_time"],
      createdByDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
      parent: json["parent"],
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      department: json["department"],
      mailjetSender: json["mailjetSender"],
      smtpSender: json["smtpSender"],
    );
  }

}

class RoleList {
  RoleList({
    required this.id,
    required this.name,
    required this.description,
    required this.roleListDefault,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? roleListDefault;

  factory RoleList.fromJson(Map<String, dynamic> json){
    return RoleList(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      roleListDefault: json["default"],
    );
  }

}

