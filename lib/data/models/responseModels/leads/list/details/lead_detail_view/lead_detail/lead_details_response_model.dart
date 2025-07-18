class LeadDetailResponseModel {
  String? id;
  int? score;
  String? firstName;
  String? lastName;
  int? countryCode;
  String? mobile;
  String? mobileWithCountrycode;
  String? email;
  String? organization;
  String? description;
  String? address;
  Null city;
  Null state;
  int? flag;
  Null importCustomData;
  Null queryTime;
  String? queryType;
  Null refId;
  Null leadBuyerEmail;
  Null leadBuyerName;
  Null label;
  Null note;
  String? gstin;
  List<Null>? websites;
  Null deleteRemark;
  Null deadRemark;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  String? oldLead;
  bool? isOldLead;
  Null facebookLeadgenId;
  String? latestEnquiryDate;
  String? leadStatus;
  Source? source;
  Contact? contact;
  List<Null>? enquiries;
  List<SecondaryEmails>? secondaryEmails;
  List<SecondaryMobiles>? secondaryMobiles;
  Pincode? pincode;
  District? district;
  District? leadCity;
  District? leadState;
  District? leadCountry;
  Type? type;
  Null subType;
  Null status;
  List<Divisions>? divisions;
  List<ProductCategory>? productCategories;
  Null customer;
  Null leadParent;
  List<Null>? projections;
  Null createdBy;
  List<LeadToCustomFields>? leadToCustomFields;
  List<LeadAssigned>? leadAssigned;

  LeadDetailResponseModel(
      {this.id,
      this.score,
      this.firstName,
      this.lastName,
      this.countryCode,
      this.mobile,
      this.mobileWithCountrycode,
      this.email,
      this.organization,
      this.description,
      this.address,
      this.city,
      this.state,
      this.flag,
      this.importCustomData,
      this.queryTime,
      this.queryType,
      this.refId,
      this.leadBuyerEmail,
      this.leadBuyerName,
      this.label,
      this.note,
      this.gstin,
      this.websites,
      this.deleteRemark,
      this.deadRemark,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.oldLead,
      this.isOldLead,
      this.facebookLeadgenId,
      this.latestEnquiryDate,
      this.leadStatus,
      this.source,
      this.contact,
      this.enquiries,
      this.secondaryEmails,
      this.secondaryMobiles,
      this.pincode,
      this.district,
      this.leadCity,
      this.leadState,
      this.leadCountry,
      this.type,
      this.subType,
      this.status,
      this.divisions,
      this.productCategories,
      this.customer,
      this.leadParent,
      this.projections,
      this.createdBy,
      this.leadToCustomFields,
      this.leadAssigned});

  LeadDetailResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    score = json['score'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    mobileWithCountrycode = json['mobile_with_countrycode'];
    email = json['email'];
    organization = json['organization'];
    description = json['description'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    flag = json['flag'];
    importCustomData = json['import_custom_data'];
    queryTime = json['query_time'];
    queryType = json['query_type'];
    refId = json['ref_id'];
    leadBuyerEmail = json['lead_buyer_email'];
    leadBuyerName = json['lead_buyer_name'];
    label = json['label'];
    note = json['note'];
    gstin = json['gstin'];
    if (json['websites'] != null) {
      websites = <Null>[];
      json['websites'].forEach((v) {
        websites!.add((v));
      });
    }
    deleteRemark = json['delete_remark'];
    deadRemark = json['dead_remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    oldLead = json['old_lead'];
    isOldLead = json['isOldLead'];
    facebookLeadgenId = json['facebookLeadgenId'];
    latestEnquiryDate = json['latest_enquiry_date'];
    leadStatus = json['leadStatus'];
    source = json['source'] != null ? Source.fromJson(json['source']) : null;
    contact =
        json['contact'] != null ? Contact.fromJson(json['contact']) : null;
    if (json['enquiries'] != null) {
      enquiries = <Null>[];
      json['enquiries'].forEach((v) {
        enquiries!.add((v));
      });
    }
    if (json['secondary_emails'] != null) {
      secondaryEmails = <SecondaryEmails>[];
      json['secondary_emails'].forEach((v) {
        secondaryEmails!.add(SecondaryEmails.fromJson(v));
      });
    }
    if (json['secondary_mobiles'] != null) {
      secondaryMobiles = <SecondaryMobiles>[];
      json['secondary_mobiles'].forEach((v) {
        secondaryMobiles!.add(SecondaryMobiles.fromJson(v));
      });
    }
    pincode =
        json['pincode'] != null ? Pincode.fromJson(json['pincode']) : null;
    district =
        json['district'] != null ? District.fromJson(json['district']) : null;
    leadCity =
        json['lead_city'] != null ? District.fromJson(json['lead_city']) : null;
    leadState = json['lead_state'] != null
        ? District.fromJson(json['lead_state'])
        : null;
    leadCountry = json['lead_country'] != null
        ? District.fromJson(json['lead_country'])
        : null;
    type = json['type'] != null ? Type.fromJson(json['type']) : null;
    subType = json['sub_type'];
    status = json['status'];
    if (json['divisions'] != null) {
      divisions = <Divisions>[];
      json['divisions'].forEach((v) {
        divisions!.add(Divisions.fromJson(v));
      });
    }
    if (json['productCategories'] != null) {
      productCategories = <ProductCategory>[];
      json['productCategories'].forEach((v) {
        productCategories!.add(ProductCategory.fromJson(v));
      });
    }
    customer = json['customer'];
    leadParent = json['lead_parent'];
    if (json['projections'] != null) {
      projections = <Null>[];
      json['projections'].forEach((v) {
        projections!.add((v));
      });
    }
    createdBy = json['created_by'];
    if (json['leadToCustomFields'] != null) {
      leadToCustomFields = <LeadToCustomFields>[];
      json['leadToCustomFields'].forEach((v) {
        leadToCustomFields!.add(LeadToCustomFields.fromJson(v));
      });
    }
    if (json['lead_assigned'] != null) {
      leadAssigned = <LeadAssigned>[];
      json['lead_assigned'].forEach((v) {
        leadAssigned!.add(LeadAssigned.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['score'] = score;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['country_code'] = countryCode;
    data['mobile'] = mobile;
    data['mobile_with_countrycode'] = mobileWithCountrycode;
    data['email'] = email;
    data['organization'] = organization;
    data['description'] = description;
    data['address'] = address;
    data['city'] = city;
    data['state'] = state;
    data['flag'] = flag;
    data['import_custom_data'] = importCustomData;
    data['query_time'] = queryTime;
    data['query_type'] = queryType;
    data['ref_id'] = refId;
    data['lead_buyer_email'] = leadBuyerEmail;
    data['lead_buyer_name'] = leadBuyerName;
    data['label'] = label;
    data['note'] = note;
    data['gstin'] = gstin;
    if (websites != null) {
      data['websites'] = websites!.map((v) => ()).toList();
    }
    data['delete_remark'] = deleteRemark;
    data['dead_remark'] = deadRemark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['old_lead'] = oldLead;
    data['isOldLead'] = isOldLead;
    data['facebookLeadgenId'] = facebookLeadgenId;
    data['latest_enquiry_date'] = latestEnquiryDate;
    data['leadStatus'] = leadStatus;
    if (source != null) {
      data['source'] = source!.toJson();
    }
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    if (enquiries != null) {
      data['enquiries'] = enquiries!.map((v) => ()).toList();
    }
    if (secondaryEmails != null) {
      data['secondary_emails'] =
          secondaryEmails!.map((v) => v.toJson()).toList();
    }
    if (secondaryMobiles != null) {
      data['secondary_mobiles'] =
          secondaryMobiles!.map((v) => v.toJson()).toList();
    }
    if (pincode != null) {
      data['pincode'] = pincode!.toJson();
    }
    if (district != null) {
      data['district'] = district!.toJson();
    }
    if (leadCity != null) {
      data['lead_city'] = leadCity!.toJson();
    }
    if (leadState != null) {
      data['lead_state'] = leadState!.toJson();
    }
    if (leadCountry != null) {
      data['lead_country'] = leadCountry!.toJson();
    }
    if (type != null) {
      data['type'] = type!.toJson();
    }
    data['sub_type'] = subType;
    data['status'] = status;
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    if (productCategories != null) {
      data['productCategories'] = productCategories!.map((v) => ()).toList();
    }
    data['customer'] = customer;
    data['lead_parent'] = leadParent;
    if (projections != null) {
      data['projections'] = projections!.map((v) => ()).toList();
    }
    data['created_by'] = createdBy;
    if (leadToCustomFields != null) {
      data['leadToCustomFields'] =
          leadToCustomFields!.map((v) => v.toJson()).toList();
    }
    if (leadAssigned != null) {
      data['lead_assigned'] = leadAssigned!.map((v) => v.toJson()).toList();
    }
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

class ProductCategory {
  String? id;
  String? name;

  ProductCategory({this.id, this.name});

  // From JSON constructor
  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Contact {
  String? id;
  String? type;
  String? name;
  String? email;
  String? mobile;

  Contact({this.id, this.type, this.name, this.email, this.mobile});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}

class SecondaryEmails {
  String? id;
  String? email;
  String? createdAt;
  String? updatedAt;

  SecondaryEmails({this.id, this.email, this.createdAt, this.updatedAt});

  SecondaryEmails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SecondaryMobiles {
  String? id;
  String? mobile;
  String? countryCode;
  String? mobileWithCountrycode;
  String? createdAt;
  String? updatedAt;

  SecondaryMobiles(
      {this.id,
      this.mobile,
      this.countryCode,
      this.mobileWithCountrycode,
      this.createdAt,
      this.updatedAt});

  SecondaryMobiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mobile = json['mobile'];
    countryCode = json['country_code'];
    mobileWithCountrycode = json['mobile_with_countrycode'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mobile'] = mobile;
    data['country_code'] = countryCode;
    data['mobile_with_countrycode'] = mobileWithCountrycode;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Pincode {
  String? id;
  String? code;

  Pincode({this.id, this.code});

  Pincode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}

class District {
  String? id;
  String? name;

  District({this.id, this.name});

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Type {
  String? id;
  String? name;
  bool? isReminderRequired;

  Type({this.id, this.name, this.isReminderRequired});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isReminderRequired = json['isReminderRequired'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['isReminderRequired'] = isReminderRequired;
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? status;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;
  String? createdAt;
  String? updatedAt;
  String? zohoOrganizationId;
  String? zohoTaxExemptionId;

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

class LeadToCustomFields {
  String? id;
  String? leadId;
  String? customId;
  String? value;
  String? fieldName;
  String? createdAt;
  String? updatedAt;
  Customfields? customfields;

  LeadToCustomFields(
      {this.id,
      this.leadId,
      this.customId,
      this.value,
      this.fieldName,
      this.createdAt,
      this.updatedAt,
      this.customfields});

  LeadToCustomFields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadId = json['lead_id'];
    customId = json['custom_id'];
    value = json['value'];
    fieldName = json['field_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customfields = json['customfields'] != null
        ? Customfields.fromJson(json['customfields'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['lead_id'] = leadId;
    data['custom_id'] = customId;
    data['value'] = value;
    data['field_name'] = fieldName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (customfields != null) {
      data['customfields'] = customfields!.toJson();
    }
    return data;
  }
}

class Customfields {
  String? id;
  String? fieldFor;
  String? fieldLabel;
  String? fieldName;
  String? type;
  String? description;
  String? answers;
  String? pattern;
  int? maxValue;
  bool? required;
  bool? requiredForCustomer;
  String? defaultValue;
  bool? multiple;
  String? createdAt;
  String? updatedAt;

  Customfields(
      {this.id,
      this.fieldFor,
      this.fieldLabel,
      this.fieldName,
      this.type,
      this.description,
      this.answers,
      this.pattern,
      this.maxValue,
      this.required,
      this.requiredForCustomer,
      this.defaultValue,
      this.multiple,
      this.createdAt,
      this.updatedAt});

  Customfields.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldFor = json['field_for'];
    fieldLabel = json['field_label'];
    fieldName = json['field_name'];
    type = json['type'];
    description = json['description'];
    answers = json['answers'];
    pattern = json['pattern'];
    maxValue = json['max_value'];
    required = json['required'];
    requiredForCustomer = json['required_for_customer'];
    defaultValue = json['default_value'];
    multiple = json['multiple'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['field_for'] = fieldFor;
    data['field_label'] = fieldLabel;
    data['field_name'] = fieldName;
    data['type'] = type;
    data['description'] = description;
    data['answers'] = answers;
    data['pattern'] = pattern;
    data['max_value'] = maxValue;
    data['required'] = required;
    data['required_for_customer'] = requiredForCustomer;
    data['default_value'] = defaultValue;
    data['multiple'] = multiple;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class LeadAssigned {
  String? id;
  int? status;
  String? createdAt;
  User? user;

  LeadAssigned({this.id, this.status, this.createdAt, this.user});

  LeadAssigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  District? department;

  User({this.id, this.firstName, this.lastName, this.department});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    department = json['department'] != null
        ? District.fromJson(json['department'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (department != null) {
      data['department'] = department!.toJson();
    }
    return data;
  }
}
