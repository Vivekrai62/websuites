class UserUpdateResponseModel {
  UserUpdateResponseModel({
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
    required this.userUpdateResponseModelDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.department,
    required this.roleList,
    required this.mailjetSender,
    required this.smtpSender,
    required this.smsSender,
    required this.parent,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? mobile;
  final dynamic address;
  final dynamic bio;
  final dynamic profilePic;
  final String? password;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? userUpdateResponseModelDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;
  final Department? department;
  final List<RoleList> roleList;
  final dynamic mailjetSender;
  final dynamic smtpSender;
  final dynamic smsSender;
  final Parent? parent;

  factory UserUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    return UserUpdateResponseModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile: json["mobile"],
      address: json["address"],
      bio: json["bio"],
      profilePic: json["profile_pic"],
      password: json["password"],
      status: json["status"], // Ensure this is a boolean
      rememberToken: json["remember_token"],
      rememberTokenTime: json["remember_token_time"],
      userUpdateResponseModelDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
      department: json["department"] == null ? null : Department.fromJson(json["department"]),
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      mailjetSender: json["mailjetSender"],
      smtpSender: json["smtpSender"],
      smsSender: json["smsSender"],
      parent: json["parent"] == null ? null : Parent.fromJson(json["parent"]),
    );
  }
}

// Department class
class Department {
  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.departmentDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? departmentDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      departmentDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
}

// Parent class
class Parent {
  Parent({
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
    required this.parentDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.roleList,
    required this.mailjetSender,
    required this.smtpSender,
    required this.smsSender,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? bio;
  final dynamic profilePic;
  final String? password;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? parentDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;
  final List<RoleList> roleList;
  final dynamic mailjetSender;
  final dynamic smtpSender;
  final dynamic smsSender;

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
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
      parentDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      mailjetSender: json["mailjetSender"],
      smtpSender: json["smtpSender"],
      smsSender: json["smsSender"],
    );
  }
}

// RoleList class
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

  factory RoleList.fromJson(Map<String, dynamic> json) {
    return RoleList(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      roleListDefault: json["default"],
    );
  }
}