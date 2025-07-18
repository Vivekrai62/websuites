// class UserModel {
//   final String id;
//   final String firstName;
//   final String lastName;
//   final String email;
//   final String mobile;
//   final String? address;
//   final String? bio;
//   final String? profilePic;
//   final String password;
//   final bool status;
//   final String? rememberToken;
//   final DateTime? rememberTokenTime;
//   final bool isDefault;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final String deviceId;
//   final bool tracking;
//   final String crmCategory;
//   final bool mobileApp;
//   final bool superSettings;
//   final List<Role> roleList;
//   final Department department;
//   final Parent parent;
//   final MailjetSender mailjetSender;
//   final dynamic smtpSender;
//   final dynamic smsSender;
//   final List<String> charts;
//   final bool inventory;
//
//   UserModel({
//     required this.id,
//     required this.firstName,
//     required this.lastName,
//     required this.email,
//     required this.mobile,
//     this.address,
//     this.bio,
//     this.profilePic,
//     required this.password,
//     required this.status,
//     this.rememberToken,
//     this.rememberTokenTime,
//     required this.isDefault,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.deviceId,
//     required this.tracking,
//     required this.crmCategory,
//     required this.mobileApp,
//     required this.superSettings,
//     required this.roleList,
//     required this.department,
//     required this.parent,
//     required this.mailjetSender,
//     this.smtpSender,
//     this.smsSender,
//     required this.charts,
//     required this.inventory,
//   });
//
//   // Updated factory method with null handling for lists
//   factory UserModel.fromJson(Map<String, dynamic> json) {
//     return UserModel(
//       id: json['id'],
//       firstName: json['first_name'],
//       lastName: json['last_name'],
//       email: json['email'],
//       mobile: json['mobile'],
//       address: json['address'],
//       bio: json['bio'],
//       profilePic: json['profile_pic'],
//       password: json['password'],
//       status: json['status'],
//       rememberToken: json['remember_token'],
//       rememberTokenTime: json['remember_token_time'] != null
//           ? DateTime.parse(json['remember_token_time'])
//           : null,
//       isDefault: json['default'],
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//       deviceId: json['device_id'],
//       tracking: json['tracking'],
//       crmCategory: json['crm_category'],
//       mobileApp: json['mobile_app'],
//       superSettings: json['superSettings'],
//       // Check if 'role_list' is null, if so, provide an empty customer_list
//       roleList: (json['role_list'] as List?)
//           ?.map((role) => Role.fromJson(role))
//           .toList() ??
//           [],
//       department: Department.fromJson(json['department']),
//       parent: Parent.fromJson(json['parent']),
//       mailjetSender: MailjetSender.fromJson(json['mailjetSender']),
//       smtpSender: json['smtpSender'],
//       smsSender: json['smsSender'],
//       // Check if 'charts' is null, if so, provide an empty customer_list
//       charts: List<String>.from(json['charts'] ?? []),
//       inventory: json['inventory'],
//     );
//   }
// }

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String? address;
  final String? bio;
  final String? profilePic;
  final String password;
  final bool status;
  final String? rememberToken;
  final DateTime? rememberTokenTime;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceId;
  final bool tracking;
  final String crmCategory;
  final bool mobileApp;
  final bool superSettings;
  final List<Role> roleList;
  final Department department;
  final Parent parent;
  final MailjetSender mailjetSender;
  final dynamic smtpSender;
  final dynamic smsSender;
  final List<String> charts;
  final bool inventory;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    this.address,
    this.bio,
    this.profilePic,
    required this.password,
    required this.status,
    this.rememberToken,
    this.rememberTokenTime,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.roleList,
    required this.department,
    required this.parent,
    required this.mailjetSender,
    this.smtpSender,
    this.smsSender,
    required this.charts,
    required this.inventory,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      address: json['address'] ?? '',
      bio: json['bio'] ?? '',
      profilePic: json['profile_pic'] ?? '',
      password: json['password'] ?? '',
      status: json['status'] ?? false,
      rememberToken: json['remember_token'] ?? '',
      rememberTokenTime: json['remember_token_time'] != null
          ? DateTime.parse(json['remember_token_time'])
          : null,
      isDefault: json['default'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deviceId: json['device_id'] ?? '',
      tracking: json['tracking'] ?? false,
      crmCategory: json['crm_category'] ?? '',
      mobileApp: json['mobile_app'] ?? false,
      superSettings: json['superSettings'] ?? false,
      roleList: (json['role_list'] as List<dynamic>?)
              ?.map((role) => Role.fromJson(role))
              .toList() ??
          [], // Safely handle null
      department: Department.fromJson(json['department']),
      parent: Parent.fromJson(json['parent']),
      mailjetSender: MailjetSender.fromJson(json['mailjetSender']),
      smtpSender: json['smtpSender'],
      smsSender: json['smsSender'],
      charts: List<String>.from(json['charts'] ?? []), // Safely handle null
      inventory: json['inventory'] ?? false,
    );
  }
}

// Rest of your models (Role, Department, Parent, MailjetSender) follow the same pattern

class Role {
  final String id;
  final String name;
  final String description;
  final bool isDefault;
  final List<dynamic> dashboards;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.isDefault,
    required this.dashboards,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isDefault: json['default'],
      dashboards: List<dynamic>.from(json['dashboards']),
    );
  }
}

class Department {
  final String id;
  final String name;
  final String description;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  Department({
    required this.id,
    required this.name,
    required this.description,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isDefault: json['default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

class Parent {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String? address;
  final String? bio;
  final String? profilePic;
  final String password;
  final bool status;
  final String? rememberToken;
  final DateTime? rememberTokenTime;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deviceId;
  final bool tracking;
  final String crmCategory;
  final bool mobileApp;
  final bool superSettings;
  final List<Role> roleList;
  final MailjetSender mailjetSender;

  Parent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    this.address,
    this.bio,
    this.profilePic,
    required this.password,
    required this.status,
    this.rememberToken,
    this.rememberTokenTime,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.roleList,
    required this.mailjetSender,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      bio: json['bio'],
      profilePic: json['profile_pic'],
      password: json['password'],
      status: json['status'],
      rememberToken: json['remember_token'],
      rememberTokenTime: json['remember_token_time'] != null
          ? DateTime.parse(json['remember_token_time'])
          : null,
      isDefault: json['default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deviceId: json['device_id'],
      tracking: json['tracking'],
      crmCategory: json['crm_category'],
      mobileApp: json['mobile_app'],
      superSettings: json['superSettings'],
      roleList: (json['role_list'] as List)
          .map((role) => Role.fromJson(role))
          .toList(),
      mailjetSender: MailjetSender.fromJson(json['mailjetSender']),
    );
  }
}

class MailjetSender {
  final String id;
  final String provider;
  final String name;
  final String email;
  final bool status;
  final String mailjetSenderId;
  final String? smtpHost;
  final String? smtpPassword;
  final String? smtpPort;
  final String? smtpAuthentication;
  final bool isDefaultSender;
  final DateTime createdAt;
  final DateTime updatedAt;

  MailjetSender({
    required this.id,
    required this.provider,
    required this.name,
    required this.email,
    required this.status,
    required this.mailjetSenderId,
    this.smtpHost,
    this.smtpPassword,
    this.smtpPort,
    this.smtpAuthentication,
    required this.isDefaultSender,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MailjetSender.fromJson(Map<String, dynamic> json) {
    return MailjetSender(
      id: json['id'],
      provider: json['provider'],
      name: json['name'],
      email: json['email'],
      status: json['status'],
      mailjetSenderId: json['mailjet_sender_id'],
      smtpHost: json['smtp_host'],
      smtpPassword: json['smtp_password'],
      smtpPort: json['smtp_port'],
      smtpAuthentication: json['smtp_authentication'],
      isDefaultSender: json['is_default_sender'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
