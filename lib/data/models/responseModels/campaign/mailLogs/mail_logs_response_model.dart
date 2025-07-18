class CampaignMailLogsResponseModel {
  List<Items>? items;
  Meta? meta;

  CampaignMailLogsResponseModel({this.items, this.meta});

  CampaignMailLogsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? provider;
  String? subject;
  String? from;
  To? to;
  String? status;
  bool? cc;
  bool? bcc;
  String? mailjetMessageId;
  String? brevoMessageId;
  String? smtpMessageId;
  String? receiverType;
  String? error;
  String? createdAt;
  String? updatedAt;
  String? linkableType;
  String? linkableId;
  User? user;
  ReceiverUser? receiverUser;
  String? receiverLead;
  ReceiverCustomer? receiverCustomer;
  String? campaign;

  Items(
      {this.id,
      this.provider,
      this.subject,
      this.from,
      this.to,
      this.status,
      this.cc,
      this.bcc,
      this.mailjetMessageId,
      this.brevoMessageId,
      this.smtpMessageId,
      this.receiverType,
      this.error,
      this.createdAt,
      this.updatedAt,
      this.linkableType,
      this.linkableId,
      this.user,
      this.receiverUser,
      this.receiverLead,
      this.receiverCustomer,
      this.campaign});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    provider = json['provider'];
    subject = json['subject'];
    from = json['from'];
    to = json['to'] != null ? To.fromJson(json['to']) : null;
    status = json['status'];
    cc = json['cc'];
    bcc = json['bcc'];
    mailjetMessageId = json['mailjetMessageId'];
    brevoMessageId = json['brevoMessageId'];
    smtpMessageId = json['smtpMessageId'];
    receiverType = json['receiverType'];
    error = json['error'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    linkableType = json['linkableType'];
    linkableId = json['linkableId'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    receiverUser = json['receiverUser'] != null
        ? ReceiverUser.fromJson(json['receiverUser'])
        : null;
    receiverLead = json['receiverLead'];
    receiverCustomer = json['receiverCustomer'] != null
        ? ReceiverCustomer.fromJson(json['receiverCustomer'])
        : null;
    campaign = json['campaign'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider'] = provider;
    data['subject'] = subject;
    data['from'] = from;
    if (to != null) {
      data['to'] = to!.toJson();
    }
    data['status'] = status;
    data['cc'] = cc;
    data['bcc'] = bcc;
    data['mailjetMessageId'] = mailjetMessageId;
    data['brevoMessageId'] = brevoMessageId;
    data['smtpMessageId'] = smtpMessageId;
    data['receiverType'] = receiverType;
    data['error'] = error;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['linkableType'] = linkableType;
    data['linkableId'] = linkableId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (receiverUser != null) {
      data['receiverUser'] = receiverUser!.toJson();
    }
    data['receiverLead'] = receiverLead;
    if (receiverCustomer != null) {
      data['receiverCustomer'] = receiverCustomer!.toJson();
    }
    data['campaign'] = campaign;
    return data;
  }
}

class To {
  String? email;
  String? type;
  String? receiverType;
  Receiver? receiver;

  To({this.email, this.type, this.receiverType, this.receiver});

  To.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    type = json['type'];
    receiverType = json['receiverType'];
    receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['type'] = type;
    data['receiverType'] = receiverType;
    if (receiver != null) {
      data['receiver'] = receiver!.toJson();
    }
    return data;
  }
}

class Receiver {
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
  String? rememberToken;
  String? rememberTokenTime;
  bool? isdefault;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;
  String? companyName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  String? primaryAddress;
  String? profileImage;
  String? dob;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  String? deletedAt;
  String? deleteRemark;
  String? zohoContactId;
  String? subStatus;

  Receiver(
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
      this.isdefault,
      this.createdAt,
      this.updatedAt,
      this.deviceId,
      this.tracking,
      this.crmCategory,
      this.mobileApp,
      this.superSettings,
      this.companyName,
      this.primaryEmail,
      this.countryCode,
      this.primaryContact,
      this.organization,
      this.primaryAddress,
      this.profileImage,
      this.dob,
      this.aboutClient,
      this.otherInformation,
      this.lat,
      this.lng,
      this.deletedAt,
      this.deleteRemark,
      this.zohoContactId,
      this.subStatus});

  Receiver.fromJson(Map<String, dynamic> json) {
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
    isdefault = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    tracking = json['tracking'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
    companyName = json['company_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    primaryAddress = json['primary_address'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    aboutClient = json['about_client'];
    otherInformation = json['other_information'];
    lat = json['lat'];
    lng = json['lng'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoContactId = json['zoho_contact_id'];
    subStatus = json['subStatus'];
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
    data['default'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    data['company_name'] = companyName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['organization'] = organization;
    data['primary_address'] = primaryAddress;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['about_client'] = aboutClient;
    data['other_information'] = otherInformation;
    data['lat'] = lat;
    data['lng'] = lng;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_contact_id'] = zohoContactId;
    data['subStatus'] = subStatus;
    return data;
  }
}

class User {
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
  String? rememberToken;
  String? rememberTokenTime;
  bool? isdefault;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;

  User(
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
      this.isdefault,
      this.createdAt,
      this.updatedAt,
      this.deviceId,
      this.tracking,
      this.crmCategory,
      this.mobileApp,
      this.superSettings});

  User.fromJson(Map<String, dynamic> json) {
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
    isdefault = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    tracking = json['tracking'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
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
    data['default'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    return data;
  }
}

class ReceiverUser {
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
  String? rememberToken;
  String? rememberTokenTime;
  bool? isdefault;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;

  ReceiverUser(
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
      this.isdefault,
      this.createdAt,
      this.updatedAt,
      this.deviceId,
      this.tracking,
      this.crmCategory,
      this.mobileApp,
      this.superSettings});

  ReceiverUser.fromJson(Map<String, dynamic> json) {
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
    isdefault = json['default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deviceId = json['device_id'];
    tracking = json['tracking'];
    crmCategory = json['crm_category'];
    mobileApp = json['mobile_app'];
    superSettings = json['superSettings'];
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
    data['default'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    return data;
  }
}

class ReceiverCustomer {
  String? id;
  String? companyName;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  String? primaryAddress;
  String? profileImage;
  String? dob;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deleteRemark;
  String? zohoContactId;
  String? status;
  String? subStatus;

  ReceiverCustomer(
      {this.id,
      this.companyName,
      this.firstName,
      this.lastName,
      this.primaryEmail,
      this.countryCode,
      this.primaryContact,
      this.organization,
      this.primaryAddress,
      this.profileImage,
      this.dob,
      this.aboutClient,
      this.otherInformation,
      this.lat,
      this.lng,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deleteRemark,
      this.zohoContactId,
      this.status,
      this.subStatus});

  ReceiverCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    primaryAddress = json['primary_address'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    aboutClient = json['about_client'];
    otherInformation = json['other_information'];
    lat = json['lat'];
    lng = json['lng'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoContactId = json['zoho_contact_id'];
    status = json['status'];
    subStatus = json['subStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['organization'] = organization;
    data['primary_address'] = primaryAddress;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['about_client'] = aboutClient;
    data['other_information'] = otherInformation;
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_contact_id'] = zohoContactId;
    data['status'] = status;
    data['subStatus'] = subStatus;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}
