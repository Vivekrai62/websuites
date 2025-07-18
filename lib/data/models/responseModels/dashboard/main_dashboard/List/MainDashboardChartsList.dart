class MainDashboardChartsListResponseModel {
  MainDashboardChartsListResponseModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.countryCode, // Added missing field
    required this.mobile,
    required this.address,
    required this.bio,
    required this.profilePic,
    required this.status,
    required this.rememberToken,
    required this.rememberTokenTime,
    required this.mainDashboardChartsListDefault,
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
    required this.smtpSender,
    required this.smsSender,
    required this.charts,
    required this.inventory,
    required this.globalSettings,
    required this.baseCurrency,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? countryCode; // Added missing field with correct type
  final String? mobile;
  final String? address;
  final String? bio;
  final dynamic profilePic;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? mainDashboardChartsListDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;
  final List<RoleList> roleList;
  final dynamic department;
  final dynamic parent;
  final dynamic mailjetSender;
  final dynamic smtpSender;
  final dynamic smsSender;
  final List<String> charts;
  final bool? inventory;
  final GlobalSettings? globalSettings;
  final BaseCurrency? baseCurrency;

  factory MainDashboardChartsListResponseModel.fromJson(Map<String, dynamic> json){
    return MainDashboardChartsListResponseModel(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      countryCode: json["country_code"], // Added missing mapping
      mobile: json["mobile"],
      address: json["address"],
      bio: json["bio"],
      profilePic: json["profile_pic"],
      status: json["status"],
      rememberToken: json["remember_token"],
      rememberTokenTime: json["remember_token_time"],
      mainDashboardChartsListDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      department: json["department"],
      parent: json["parent"],
      mailjetSender: json["mailjetSender"],
      smtpSender: json["smtpSender"],
      smsSender: json["smsSender"],
      charts: json["charts"] == null ? [] : List<String>.from(json["charts"]!.map((x) => x)),
      inventory: json["inventory"],
      globalSettings: json["globalSettings"] == null ? null : GlobalSettings.fromJson(json["globalSettings"]),
      baseCurrency: json["base_currency"] == null ? null : BaseCurrency.fromJson(json["base_currency"]),
    );
  }
}

class BaseCurrency {
  BaseCurrency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? symbol;

  factory BaseCurrency.fromJson(Map<String, dynamic> json){
    return BaseCurrency(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      symbol: json["symbol"],
    );
  }
}

class GlobalSettings {
  GlobalSettings({
    required this.otpRequiredForMeetings, // Added missing field
    required this.disableCustomerCompanies,
    required this.countryCode,
    required this.locationRequiredOnLeadActivity,
    required this.locationRequiredOnCustomerActivity,
    required this.disableAutoAssignRepeatedLeads,
    required this.invetory,
  });

  final bool? otpRequiredForMeetings; // Added missing field
  final bool? disableCustomerCompanies;
  final bool? countryCode;
  final bool? locationRequiredOnLeadActivity;
  final bool? locationRequiredOnCustomerActivity;
  final bool? disableAutoAssignRepeatedLeads;
  final bool? invetory;

  factory GlobalSettings.fromJson(Map<String, dynamic> json){
    return GlobalSettings(
      otpRequiredForMeetings: json["otp_required_for_meetings"], // Added missing mapping
      disableCustomerCompanies: json["disable_customer_companies"],
      countryCode: json["country_code"],
      locationRequiredOnLeadActivity: json["location_required_on_lead_activity"],
      locationRequiredOnCustomerActivity: json["location_required_on_customer_activity"],
      disableAutoAssignRepeatedLeads: json["disable_auto_assign_repeated_leads"],
      invetory: json["invetory"],
    );
  }
}

class RoleList {
  RoleList({
    required this.id,
    required this.name,
    required this.description,
    required this.roleListDefault,
    required this.dashboards,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? roleListDefault;
  final List<Dashboard> dashboards;

  factory RoleList.fromJson(Map<String, dynamic> json){
    return RoleList(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      roleListDefault: json["default"],
      dashboards: json["dashboards"] == null ? [] : List<Dashboard>.from(json["dashboards"]!.map((x) => Dashboard.fromJson(x))),
    );
  }
}

class Dashboard {
  Dashboard({
    required this.id,
    required this.name,
    required this.charts,
    required this.isDefault,
  });

  final String? id;
  final String? name;
  final List<String> charts;
  final bool? isDefault;

  factory Dashboard.fromJson(Map<String, dynamic> json){
    return Dashboard(
      id: json["id"],
      name: json["name"],
      charts: json["charts"] == null ? [] : List<String>.from(json["charts"]!.map((x) => x)),
      isDefault: json["isDefault"],
    );
  }
}