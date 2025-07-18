import 'dart:core';

class CreateLeadResponseModel {
  String? firstName;
  String? lastName;
  int? countryCode;
  String? mobile;
  String? mobileWithCountrycode;
  String? email;
  String? organization;
  String? description;
  String? address;
  String? gstin;
  List<Null>? websites;
  String? leadStatus;
  Null pincode;
  Null leadCity;
  Null district;
  Null leadState;
  LeadCountry? leadCountry;
  CreatedBy? createdBy;
  Source? source;
  Type? type;
  Null leadParent;
  List<Divisions>? divisions;
  List<ProductCategories>? productCategories;
  Null city;
  Null state;
  Null importCustomData;
  Null queryTime;
  Null refId;
  Null leadBuyerEmail;
  Null leadBuyerName;
  Null label;
  Null note;
  Null deleteRemark;
  Null deadRemark;
  bool? isOldLead;
  Null facebookLeadgenId;
  String? id;
  int? score;
  int? flag;
  String? queryType;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  String? oldLead;
  String? latestEnquiryDate;
  List<Null>? leadToCustomFields;

  CreateLeadResponseModel(
      {this.firstName,
      this.lastName,
      this.countryCode,
      this.mobile,
      this.mobileWithCountrycode,
      this.email,
      this.organization,
      this.description,
      this.address,
      this.gstin,
      this.websites,
      this.leadStatus,
      this.pincode,
      this.leadCity,
      this.district,
      this.leadState,
      this.leadCountry,
      this.createdBy,
      this.source,
      this.type,
      this.leadParent,
      this.divisions,
      this.productCategories,
      this.city,
      this.state,
      this.importCustomData,
      this.queryTime,
      this.refId,
      this.leadBuyerEmail,
      this.leadBuyerName,
      this.label,
      this.note,
      this.deleteRemark,
      this.deadRemark,
      this.isOldLead,
      this.facebookLeadgenId,
      this.id,
      this.score,
      this.flag,
      this.queryType,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.oldLead,
      this.latestEnquiryDate,
      this.leadToCustomFields});

  CreateLeadResponseModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileWithCountrycode = json['mobile_with_countrycode'];
    email = json['email'];
    organization = json['organization'];
    description = json['description'];
    address = json['address'];
    gstin = json['gstin'];
    if (json['websites'] != null) {
      websites = <Null>[];
      json['websites'].forEach((v) {
        websites!.add((v));
      });
    }
    leadStatus = json['leadStatus'];
    pincode = json['pincode'];
    leadCity = json['lead_city'];
    district = json['district'];
    leadState = json['lead_state'];
    leadCountry = json['lead_country'] != null
        ? LeadCountry.fromJson(json['lead_country'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    leadParent = json['lead_parent'];
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(Divisions.fromJson(v));
      });
    }
    if (json['productCategories'] != null) {
      productCategories = <ProductCategories>[];
      json['productCategories'].forEach((v) {
        productCategories!.add(ProductCategories.fromJson(v));
      });
    }
    city = json['city'];
    state = json['state'];
    importCustomData = json['import_custom_data'];
    queryTime = json['query_time'];
    refId = json['ref_id'];
    leadBuyerEmail = json['lead_buyer_email'];
    leadBuyerName = json['lead_buyer_name'];
    label = json['label'];
    note = json['note'];
    deleteRemark = json['delete_remark'];
    deadRemark = json['dead_remark'];
    isOldLead = json['isOldLead'];
    facebookLeadgenId = json['facebookLeadgenId'];
    id = json['id'];
    score = json['score'];
    flag = json['flag'];
    queryType = json['query_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    oldLead = json['old_lead'];
    latestEnquiryDate = json['latest_enquiry_date'];
    if (json['leadToCustomFields'] != null) {
      leadToCustomFields = <Null>[];
      json['leadToCustomFields'].forEach((v) {
        leadToCustomFields!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_with_countrycode'] = mobileWithCountrycode;
    data['email'] = email;
    data['organization'] = organization;
    data['description'] = description;
    data['address'] = address;
    data['gstin'] = gstin;
    if (websites != null) {
      data['websites'] = websites!.map((v) => ()).toList();
    }
    data['leadStatus'] = leadStatus;
    data['pincode'] = pincode;
    data['lead_city'] = leadCity;
    data['district'] = district;
    data['lead_state'] = leadState;
    if (leadCountry != null) {
      data['lead_country'] = leadCountry!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (source != null) {
      data['source'] = source!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['lead_parent'] = leadParent;
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    if (productCategories != null) {
      data['productCategories'] =
          productCategories!.map((v) => v.toJson()).toList();
    }
    data['city'] = city;
    data['state'] = state;
    data['import_custom_data'] = importCustomData;
    data['query_time'] = queryTime;
    data['ref_id'] = refId;
    data['lead_buyer_email'] = leadBuyerEmail;
    data['lead_buyer_name'] = leadBuyerName;
    data['label'] = label;
    data['note'] = note;
    data['delete_remark'] = deleteRemark;
    data['dead_remark'] = deadRemark;
    data['isOldLead'] = isOldLead;
    data['facebookLeadgenId'] = facebookLeadgenId;
    data['id'] = id;
    data['score'] = score;
    data['flag'] = flag;
    data['query_type'] = queryType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['old_lead'] = oldLead;
    data['latest_enquiry_date'] = latestEnquiryDate;
    if (leadToCustomFields != null) {
      data['leadToCustomFields'] = leadToCustomFields!.map((v) => ()).toList();
    }
    return data;
  }
}

class LeadCountry {
  String? id;
  String? name;
  String? shortName;
  String? native;
  String? phone;
  String? continent;
  String? capital;
  String? currency;
  String? status;
  bool? installStatus;
  String? createdAt;
  String? updatedAt;

  LeadCountry(
      {this.id,
      this.name,
      this.shortName,
      this.native,
      this.phone,
      this.continent,
      this.capital,
      this.currency,
      this.status,
      this.installStatus,
      this.createdAt,
      this.updatedAt});

  LeadCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shortName = json['shortName'];
    native = json['native'];
    phone = json['phone'];
    continent = json['continent'];
    capital = json['capital'];
    currency = json['currency'];
    status = json['status'];
    installStatus = json['installStatus'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['shortName'] = shortName;
    data['native'] = native;
    data['phone'] = phone;
    data['continent'] = continent;
    data['capital'] = capital;
    data['currency'] = currency;
    data['status'] = status;
    data['installStatus'] = installStatus;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  List<RoleList>? roleList;
  Null department;
  Null mailjetSender;
  Null smtpSender;

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

class Source {
  String? id;
  String? name;
  String? status;
  String? createdAt;
  String? updateAt;

  Source({this.id, this.name, this.status, this.createdAt, this.updateAt});

  Source.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['update_at'] = updateAt;
    return data;
  }
}

class Type {
  String? id;
  String? name;
  Null subTypes;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  Null activityChartLabelY;
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? removeFromTodo;
  bool? removeFromList;

  Type(
      {this.id,
      this.name,
      this.subTypes,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.activityChartInterval,
      this.activityChartLabelY,
      this.activityChartLabelX,
      this.isReminderRequired,
      this.removeFromTodo,
      this.removeFromList});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    subTypes = json['sub_types'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    activityChartInterval = json['activity_chart_interval'];
    activityChartLabelY = json['activity_chart_label_y'];
    activityChartLabelX = json['activity_chart_label_x'];
    isReminderRequired = json['isReminderRequired'];
    removeFromTodo = json['remove_from_todo'];
    removeFromList = json['remove_from_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sub_types'] = subTypes;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['activity_chart_interval'] = activityChartInterval;
    data['activity_chart_label_y'] = activityChartLabelY;
    data['activity_chart_label_x'] = activityChartLabelX;
    data['isReminderRequired'] = isReminderRequired;
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? status;
  Null mobileNo;
  Null contactPerson;
  Null email;
  Null address;
  Null logo;
  String? createdAt;
  String? updatedAt;
  Null zohoOrganizationId;
  Null zohoTaxExemptionId;

  Divisions(
      {this.id,
      this.name,
      this.status,
      this.mobileNo,
      this.contactPerson,
      this.email,
      this.address,
      this.logo,
      this.createdAt,
      this.updatedAt,
      this.zohoOrganizationId,
      this.zohoTaxExemptionId});

  Divisions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    mobileNo = json['mobile_no'];
    contactPerson = json['contact_person'];
    email = json['email'];
    address = json['address'];
    logo = json['logo'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    zohoOrganizationId = json['zoho_organization_id'];
    zohoTaxExemptionId = json['zoho_tax_exemption_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['mobile_no'] = mobileNo;
    data['contact_person'] = contactPerson;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['zoho_organization_id'] = zohoOrganizationId;
    data['zoho_tax_exemption_id'] = zohoTaxExemptionId;
    return data;
  }
}

class ProductCategories {
  String? id;
  String? name;
  String? description;
  Null image;
  String? createdAt;
  String? updatedAt;

  ProductCategories(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  ProductCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
