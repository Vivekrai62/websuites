class LeadActionCreateResModel {
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
  final String? rememberTokenTime;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deviceId;
  final bool tracking;
  final String crmCategory;
  final bool mobileApp;
  final bool superSettings;

  LeadActionCreateResModel({
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
  });

  factory LeadActionCreateResModel.fromJson(Map<String, dynamic> json) {
    return LeadActionCreateResModel(
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
      rememberTokenTime: json['remember_token_time'],
      isDefault: json['default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deviceId: json['device_id'],
      tracking: json['tracking'],
      crmCategory: json['crm_category'],
      mobileApp: json['mobile_app'],
      superSettings: json['superSettings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'address': address,
      'bio': bio,
      'profile_pic': profilePic,
      'password': password,
      'status': status,
      'remember_token': rememberToken,
      'remember_token_time': rememberTokenTime,
      'default': isDefault,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'device_id': deviceId,
      'tracking': tracking,
      'crm_category': crmCategory,
      'mobile_app': mobileApp,
      'superSettings': superSettings,
    };
  }

  static List<LeadActionCreateResModel> listFromJson(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadActionCreateResModel.fromJson(json)).toList();
  }
}
