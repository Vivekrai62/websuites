class UpdateProjectOverViewResponseModel {
  String? id;
  String? projectName;
  String? billingType;
  String? status;
  int? totalRate;
  int? estimatedHours;
  String? startDate;
  String? deadline;
  String? description;
  String? demoUrl;
  String? finishDate;
  String? liveUrl;
  String? createdAt;
  String? updatedAt;
  List<Members>? members;
  Customer? customer;
  Companies? company;

  UpdateProjectOverViewResponseModel(
      {this.id,
      this.projectName,
      this.billingType,
      this.status,
      this.totalRate,
      this.estimatedHours,
      this.startDate,
      this.deadline,
      this.description,
      this.demoUrl,
      this.finishDate,
      this.liveUrl,
      this.createdAt,
      this.updatedAt,
      this.members,
      this.customer,
      this.company});

  UpdateProjectOverViewResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    billingType = json['billing_type'];
    status = json['status'];
    totalRate = json['total_rate'];
    estimatedHours = json['estimated_hours'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    description = json['description'];
    demoUrl = json['demo_url'];
    finishDate = json['finish_date'];
    liveUrl = json['live_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    company =
        json['company'] != null ? Companies.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['billing_type'] = billingType;
    data['status'] = status;
    data['total_rate'] = totalRate;
    data['estimated_hours'] = estimatedHours;
    data['start_date'] = startDate;
    data['deadline'] = deadline;
    data['description'] = description;
    data['demo_url'] = demoUrl;
    data['finish_date'] = finishDate;
    data['live_url'] = liveUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Members {
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
  List<RoleList>? roleList;
  dynamic mailjetSender;
  dynamic smtpSender;
  dynamic smsSender;

  Members(
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

  Members.fromJson(Map<String, dynamic> json) {
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
    mailjetSender = json['mailjetSender'];
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
    data['mailjetSender'] = mailjetSender;
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

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  List<Null>? websites;
  String? primaryAddress;
  dynamic profileImage;
  dynamic dob;
  dynamic gstin;
  String? aboutClient;
  String? otherInformation;
  int? lat;
  int? lng;
  dynamic joinedAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic deleteRemark;
  dynamic zohoContactId;
  String? status;
  dynamic subStatus;
  List<Companies>? companies;
  List<Null>? customerToCustomFields;

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.primaryEmail,
      this.countryCode,
      this.primaryContact,
      this.organization,
      this.websites,
      this.primaryAddress,
      this.profileImage,
      this.dob,
      this.gstin,
      this.aboutClient,
      this.otherInformation,
      this.lat,
      this.lng,
      this.joinedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deleteRemark,
      this.zohoContactId,
      this.status,
      this.subStatus,
      this.companies,
      this.customerToCustomFields});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    if (json['websites'] != null) {
      websites = <Null>[];
      json['websites'].forEach((v) {
        websites!.add((v));
      });
    }
    primaryAddress = json['primary_address'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gstin = json['gstin'];
    aboutClient = json['about_client'];
    otherInformation = json['other_information'];
    lat = json['lat'];
    lng = json['lng'];
    joinedAt = json['joined_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoContactId = json['zoho_contact_id'];
    status = json['status'];
    subStatus = json['subStatus'];
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
    if (json['customerToCustomFields'] != null) {
      customerToCustomFields = <Null>[];
      json['customerToCustomFields'].forEach((v) {
        customerToCustomFields!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['organization'] = organization;
    if (websites != null) {
      data['websites'] = websites!.map((v) => ()).toList();
    }
    data['primary_address'] = primaryAddress;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['gstin'] = gstin;
    data['about_client'] = aboutClient;
    data['other_information'] = otherInformation;
    data['lat'] = lat;
    data['lng'] = lng;
    data['joined_at'] = joinedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_contact_id'] = zohoContactId;
    data['status'] = status;
    data['subStatus'] = subStatus;
    if (companies != null) {
      data['companies'] = companies!.map((v) => v.toJson()).toList();
    }
    if (customerToCustomFields != null) {
      data['customerToCustomFields'] =
          customerToCustomFields!.map((v) => ()).toList();
    }
    return data;
  }
}

class Companies {
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? cCountryCode;
  String? address;
  dynamic website;
  dynamic gst;
  dynamic logo;
  int? lat;
  int? lng;

  Companies(
      {this.id,
      this.companyName,
      this.companyEmail,
      this.companyPhone,
      this.countryCode,
      this.contactPersonName,
      this.contactPersonNumber,
      this.cCountryCode,
      this.address,
      this.website,
      this.gst,
      this.logo,
      this.lat,
      this.lng});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    countryCode = json['country_code'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    cCountryCode = json['c_country_code'];
    address = json['address'];
    website = json['website'];
    gst = json['gst'];
    logo = json['logo'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['company_phone'] = companyPhone;
    data['country_code'] = countryCode;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['c_country_code'] = cCountryCode;
    data['address'] = address;
    data['website'] = website;
    data['gst'] = gst;
    data['logo'] = logo;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}
