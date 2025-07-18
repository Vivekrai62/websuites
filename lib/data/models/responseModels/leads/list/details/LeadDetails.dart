class LeadDetailsResponseModel {
  LeadDetailsResponseModel({
    required this.id,
    required this.score,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobile,
    required this.mobileWithCountrycode,
    required this.email,
    required this.organization,
    required this.description,
    required this.address,
    required this.city,
    required this.state,
    required this.flag,
    required this.importCustomData,
    required this.queryTime,
    required this.queryType,
    required this.refId,
    required this.leadBuyerEmail,
    required this.leadBuyerName,
    required this.label,
    required this.note,
    required this.gstin,
    required this.websites,
    required this.deleteRemark,
    required this.deadRemark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.oldLead,
    required this.isOldLead,
    required this.facebookLeadgenId,
    required this.latestEnquiryDate,
    required this.leadStatus,
    required this.source,
    required this.contact,
    required this.enquiries,
    required this.secondaryEmails,
    required this.secondaryMobiles,
    required this.pincode,
    required this.district,
    required this.leadCity,
    required this.leadState,
    required this.leadCountry,
    required this.type,
    required this.subType,
    required this.status,
    required this.divisions,
    required this.productCategories,
    required this.customer,
    required this.leadParent,
    required this.projections,
    required this.createdBy,
    required this.leadToCustomFields,
    required this.leadAssigned,
    required this.reminderCount,
    required this.callCount,
    required this.meetingCount,
    required this.noteCount,
  });

  final String? id;
  final int? score;
  final String? firstName;
  final String? lastName;
  final int? countryCode;
  final String? mobile;
  final String? mobileWithCountrycode;
  final String? email;
  final String? organization;
  final String? description;
  final String? address;
  final dynamic city;
  final dynamic state;
  final int? flag;
  final dynamic importCustomData;
  final dynamic queryTime;
  final String? queryType;
  final dynamic refId;
  final dynamic leadBuyerEmail;
  final dynamic leadBuyerName;
  final dynamic label;
  final dynamic note;
  final String? gstin;
  final List<dynamic> websites;
  final dynamic deleteRemark;
  final dynamic deadRemark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? oldLead;
  final bool? isOldLead;
  final dynamic facebookLeadgenId;
  final DateTime? latestEnquiryDate;
  final String? leadStatus;
  final Source? source;
  final Contact? contact;
  final List<dynamic> enquiries;
  final List<dynamic> secondaryEmails;
  final List<dynamic> secondaryMobiles;
  final Pincode? pincode;
  final District? district;
  final dynamic leadCity;
  final District? leadState;
  final District? leadCountry;
  final Type? type;
  final dynamic subType;
  final dynamic status;
  final List<Division> divisions;
  final List<District> productCategories;
  final dynamic customer;
  final dynamic leadParent;
  final List<dynamic> projections;
  final CreatedBy? createdBy;
  final List<LeadToCustomField> leadToCustomFields;
  final List<LeadAssigned> leadAssigned;
  final int? reminderCount;
  final int? callCount;
  final int? meetingCount;
  final int? noteCount;

  factory LeadDetailsResponseModel.fromJson(Map<String, dynamic> json){
    return LeadDetailsResponseModel(
      id: json["id"],
      score: json["score"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      countryCode: json["country_code"],
      mobile: json["mobile"],
      mobileWithCountrycode: json["mobile_with_countrycode"],
      email: json["email"],
      organization: json["organization"],
      description: json["description"],
      address: json["address"],
      city: json["city"],
      state: json["state"],
      flag: json["flag"],
      importCustomData: json["import_custom_data"],
      queryTime: json["query_time"],
      queryType: json["query_type"],
      refId: json["ref_id"],
      leadBuyerEmail: json["lead_buyer_email"],
      leadBuyerName: json["lead_buyer_name"],
      label: json["label"],
      note: json["note"],
      gstin: json["gstin"],
      websites: json["websites"] == null ? [] : List<dynamic>.from(json["websites"]!.map((x) => x)),
      deleteRemark: json["delete_remark"],
      deadRemark: json["dead_remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      oldLead: json["old_lead"],
      isOldLead: json["isOldLead"],
      facebookLeadgenId: json["facebookLeadgenId"],
      latestEnquiryDate: DateTime.tryParse(json["latest_enquiry_date"] ?? ""),
      leadStatus: json["leadStatus"],
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
      contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
      enquiries: json["enquiries"] == null ? [] : List<dynamic>.from(json["enquiries"]!.map((x) => x)),
      secondaryEmails: json["secondary_emails"] == null ? [] : List<dynamic>.from(json["secondary_emails"]!.map((x) => x)),
      secondaryMobiles: json["secondary_mobiles"] == null ? [] : List<dynamic>.from(json["secondary_mobiles"]!.map((x) => x)),
      pincode: json["pincode"] == null ? null : Pincode.fromJson(json["pincode"]),
      district: json["district"] == null ? null : District.fromJson(json["district"]),
      leadCity: json["lead_city"],
      leadState: json["lead_state"] == null ? null : District.fromJson(json["lead_state"]),
      leadCountry: json["lead_country"] == null ? null : District.fromJson(json["lead_country"]),
      type: json["type"] == null ? null : Type.fromJson(json["type"]),
      subType: json["sub_type"],
      status: json["status"],
      divisions: json["divisions"] == null ? [] : List<Division>.from(json["divisions"]!.map((x) => Division.fromJson(x))),
      productCategories: json["productCategories"] == null ? [] : List<District>.from(json["productCategories"]!.map((x) => District.fromJson(x))),
      customer: json["customer"],
      leadParent: json["lead_parent"],
      projections: json["projections"] == null ? [] : List<dynamic>.from(json["projections"]!.map((x) => x)),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      leadToCustomFields: json["leadToCustomFields"] == null ? [] : List<LeadToCustomField>.from(json["leadToCustomFields"]!.map((x) => LeadToCustomField.fromJson(x))),
      leadAssigned: json["lead_assigned"] == null ? [] : List<LeadAssigned>.from(json["lead_assigned"]!.map((x) => LeadAssigned.fromJson(x))),
      reminderCount: json["reminderCount"],
      callCount: json["callCount"],
      meetingCount: json["meetingCount"],
      noteCount: json["noteCount"],
    );
  }

}

class Contact {
  Contact({
    required this.id,
    required this.type,
    required this.name,
    required this.email,
    required this.mobile,
  });

  final String? id;
  final String? type;
  final String? name;
  final String? email;
  final String? mobile;

  factory Contact.fromJson(Map<String, dynamic> json){
    return Contact(
      id: json["id"],
      type: json["type"],
      name: json["name"],
      email: json["email"],
      mobile: json["mobile"],
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.department,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final District? department;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      department: json["department"] == null ? null : District.fromJson(json["department"]),
    );
  }

}

class District {
  District({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory District.fromJson(Map<String, dynamic> json){
    return District(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Division {
  Division({
    required this.id,
    required this.name,
    required this.status,
    required this.mobileNo,
    required this.contactPerson,
    required this.email,
    required this.address,
    required this.logo,
    required this.termConditions,
    required this.gstin,
    required this.createdAt,
    required this.updatedAt,
    required this.zohoOrganizationId,
    required this.zohoTaxExemptionId,
  });

  final String? id;
  final String? name;
  final String? status;
  final String? mobileNo;
  final String? contactPerson;
  final String? email;
  final String? address;
  final String? logo;
  final dynamic termConditions;
  final dynamic gstin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? zohoOrganizationId;
  final String? zohoTaxExemptionId;

  factory Division.fromJson(Map<String, dynamic> json){
    return Division(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      mobileNo: json["mobile_no"],
      contactPerson: json["contact_person"],
      email: json["email"],
      address: json["address"],
      logo: json["logo"],
      termConditions: json["term_conditions"],
      gstin: json["gstin"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      zohoOrganizationId: json["zoho_organization_id"],
      zohoTaxExemptionId: json["zoho_tax_exemption_id"],
    );
  }

}

class LeadAssigned {
  LeadAssigned({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.user,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final CreatedBy? user;

  factory LeadAssigned.fromJson(Map<String, dynamic> json){
    return LeadAssigned(
      id: json["id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
    );
  }

}

class LeadToCustomField {
  LeadToCustomField({
    required this.id,
    required this.leadId,
    required this.customId,
    required this.value,
    required this.fieldName,
    required this.createdAt,
    required this.updatedAt,
    required this.customfields,
  });

  final String? id;
  final String? leadId;
  final String? customId;
  final String? value;
  final String? fieldName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customfields? customfields;

  factory LeadToCustomField.fromJson(Map<String, dynamic> json){
    return LeadToCustomField(
      id: json["id"],
      leadId: json["lead_id"],
      customId: json["custom_id"],
      value: json["value"],
      fieldName: json["field_name"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customfields: json["customfields"] == null ? null : Customfields.fromJson(json["customfields"]),
    );
  }

}

class Customfields {
  Customfields({
    required this.id,
    required this.fieldFor,
    required this.fieldLabel,
    required this.fieldName,
    required this.type,
    required this.description,
    required this.answers,
    required this.pattern,
    required this.maxValue,
    required this.required,
    required this.requiredForCustomer,
    required this.defaultValue,
    required this.multiple,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? fieldFor;
  final String? fieldLabel;
  final String? fieldName;
  final String? type;
  final String? description;
  final String? answers;
  final String? pattern;
  final int? maxValue;
  final bool? required;
  final bool? requiredForCustomer;
  final String? defaultValue;
  final bool? multiple;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Customfields.fromJson(Map<String, dynamic> json){
    return Customfields(
      id: json["id"],
      fieldFor: json["field_for"],
      fieldLabel: json["field_label"],
      fieldName: json["field_name"],
      type: json["type"],
      description: json["description"],
      answers: json["answers"],
      pattern: json["pattern"],
      maxValue: json["max_value"],
      required: json["required"],
      requiredForCustomer: json["required_for_customer"],
      defaultValue: json["default_value"],
      multiple: json["multiple"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Pincode {
  Pincode({
    required this.id,
    required this.code,
  });

  final String? id;
  final String? code;

  factory Pincode.fromJson(Map<String, dynamic> json){
    return Pincode(
      id: json["id"],
      code: json["code"],
    );
  }

}

class Source {
  Source({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updateAt,
  });

  final String? id;
  final String? name;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updateAt;

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updateAt: DateTime.tryParse(json["update_at"] ?? ""),
    );
  }

}

class Type {
  Type({
    required this.id,
    required this.name,
    required this.isReminderRequired,
  });

  final String? id;
  final String? name;
  final bool? isReminderRequired;

  factory Type.fromJson(Map<String, dynamic> json){
    return Type(
      id: json["id"],
      name: json["name"],
      isReminderRequired: json["isReminderRequired"],
    );
  }

}
