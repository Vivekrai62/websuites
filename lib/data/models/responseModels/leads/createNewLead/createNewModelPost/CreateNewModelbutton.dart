class LeadToCustomField {
  LeadToCustomField({
    required this.leadId,
    required this.customId,
    required this.value,
    required this.fieldName,
    required this.lead,
    required this.customfields,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? leadId;
  final String? customId;
  final String? value;
  final String? fieldName;
  final CreateNewModel? lead;
  final Customfields? customfields;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory LeadToCustomField.fromJson(Map<String, dynamic> json){
    return LeadToCustomField(
      leadId: json["lead_id"],
      customId: json["custom_id"],
      value: json["value"],
      fieldName: json["field_name"],
      lead: json["lead"] == null ? null : CreateNewModel.fromJson(json["lead"]),
      customfields: json["customfields"] == null ? null : Customfields.fromJson(json["customfields"]),
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class CreateNewModel {
  CreateNewModel({
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobile,
    required this.mobileWithCountrycode,
    required this.email,
    required this.organization,
    required this.address,
    required this.websites,
    required this.leadStatus,
    required this.pincode,
    required this.leadCity,
    required this.district,
    required this.leadState,
    required this.leadCountry,
    required this.createdBy,
    required this.source,
    required this.type,
    required this.leadParent,
    required this.divisions,
    required this.productCategories,
    required this.description,
    required this.city,
    required this.state,
    required this.importCustomData,
    required this.queryTime,
    required this.refId,
    required this.leadBuyerEmail,
    required this.leadBuyerName,
    required this.label,
    required this.note,
    required this.gstin,
    required this.deleteRemark,
    required this.deadRemark,
    required this.isOldLead,
    required this.facebookLeadgenId,
    required this.id,
    required this.score,
    required this.flag,
    required this.queryType,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.oldLead,
    required this.latestEnquiryDate,
    required this.leadToCustomFields,
  });

  final String? firstName;
  final String? lastName;
  final int? countryCode;
  final String? mobile;
  final String? mobileWithCountrycode;
  final String? email;
  final String? organization;
  final String? address;
  final List<dynamic> websites;
  final String? leadStatus;
  final Pincode? pincode;
  final District? leadCity;
  final District? district;
  final State? leadState;
  final LeadCountry? leadCountry;
  final CreatedBy? createdBy;
  final Source? source;
  final Type? type;
  final dynamic leadParent;
  final List<Map<String, String>> divisions;
  final List<ProductCategory> productCategories;
  final dynamic description;
  final dynamic city;
  final dynamic state;
  final dynamic importCustomData;
  final dynamic queryTime;
  final dynamic refId;
  final dynamic leadBuyerEmail;
  final dynamic leadBuyerName;
  final dynamic label;
  final dynamic note;
  final dynamic gstin;
  final dynamic deleteRemark;
  final dynamic deadRemark;
  final bool? isOldLead;
  final dynamic facebookLeadgenId;
  final String? id;
  final int? score;
  final int? flag;
  final String? queryType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? oldLead;
  final DateTime? latestEnquiryDate;
  final List<LeadToCustomField> leadToCustomFields;

  factory CreateNewModel.fromJson(Map<String, dynamic> json){
    return CreateNewModel(
      firstName: json["first_name"],
      lastName: json["last_name"],
      countryCode: json["country_code"],
      mobile: json["mobile"],
      mobileWithCountrycode: json["mobile_with_countrycode"],
      email: json["email"],
      organization: json["organization"],
      address: json["address"],
      websites: json["websites"] == null ? [] : List<dynamic>.from(json["websites"]!.map((x) => x)),
      leadStatus: json["leadStatus"],
      pincode: json["pincode"] == null ? null : Pincode.fromJson(json["pincode"]),
      leadCity: json["lead_city"] == null ? null : District.fromJson(json["lead_city"]),
      district: json["district"] == null ? null : District.fromJson(json["district"]),
      leadState: json["lead_state"] == null ? null : State.fromJson(json["lead_state"]),
      leadCountry: json["lead_country"] == null ? null : LeadCountry.fromJson(json["lead_country"]),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      source: json["source"] == null ? null : Source.fromJson(json["source"]),
      type: json["type"] == null ? null : Type.fromJson(json["type"]),
      leadParent: json["lead_parent"],
      divisions: json["divisions"] == null ? [] : List<Map<String, String>>.from(json["divisions"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      productCategories: json["productCategories"] == null ? [] : List<ProductCategory>.from(json["productCategories"]!.map((x) => ProductCategory.fromJson(x))),
      description: json["description"],
      city: json["city"],
      state: json["state"],
      importCustomData: json["import_custom_data"],
      queryTime: json["query_time"],
      refId: json["ref_id"],
      leadBuyerEmail: json["lead_buyer_email"],
      leadBuyerName: json["lead_buyer_name"],
      label: json["label"],
      note: json["note"],
      gstin: json["gstin"],
      deleteRemark: json["delete_remark"],
      deadRemark: json["dead_remark"],
      isOldLead: json["isOldLead"],
      facebookLeadgenId: json["facebookLeadgenId"],
      id: json["id"],
      score: json["score"],
      flag: json["flag"],
      queryType: json["query_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      oldLead: json["old_lead"],
      latestEnquiryDate: DateTime.tryParse(json["latest_enquiry_date"] ?? ""),
      leadToCustomFields: json["leadToCustomFields"] == null ? [] : List<LeadToCustomField>.from(json["leadToCustomFields"]!.map((x) => LeadToCustomField.fromJson(x))),
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
  final String? address;
  final String? bio;
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
  final CreatedBy? parent;
  final List<RoleList> roleList;
  final ProductCategory? department;
  final MailjetSender? mailjetSender;
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
      parent: json["parent"] == null ? null : CreatedBy.fromJson(json["parent"]),
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      department: json["department"] == null ? null : ProductCategory.fromJson(json["department"]),
      mailjetSender: json["mailjetSender"] == null ? null : MailjetSender.fromJson(json["mailjetSender"]),
      smtpSender: json["smtpSender"],
    );
  }

}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.productCategoryDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? description;
  final bool? productCategoryDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? image;

  factory ProductCategory.fromJson(Map<String, dynamic> json){
    return ProductCategory(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      productCategoryDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      image: json["image"],
    );
  }

}

class MailjetSender {
  MailjetSender({
    required this.id,
    required this.provider,
    required this.name,
    required this.email,
    required this.status,
    required this.mailjetSenderId,
    required this.smtpHost,
    required this.smtpPassword,
    required this.smtpPort,
    required this.smtpAuthentication,
    required this.isDefaultSender,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? provider;
  final String? name;
  final String? email;
  final bool? status;
  final String? mailjetSenderId;
  final dynamic smtpHost;
  final dynamic smtpPassword;
  final dynamic smtpPort;
  final dynamic smtpAuthentication;
  final bool? isDefaultSender;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MailjetSender.fromJson(Map<String, dynamic> json){
    return MailjetSender(
      id: json["id"],
      provider: json["provider"],
      name: json["name"],
      email: json["email"],
      status: json["status"],
      mailjetSenderId: json["mailjet_sender_id"],
      smtpHost: json["smtp_host"],
      smtpPassword: json["smtp_password"],
      smtpPort: json["smtp_port"],
      smtpAuthentication: json["smtp_authentication"],
      isDefaultSender: json["is_default_sender"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
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

class District {
  District({
    required this.id,
    required this.state,
  });

  final String? id;
  final State? state;

  factory District.fromJson(Map<String, dynamic> json){
    return District(
      id: json["id"],
      state: json["state"] == null ? null : State.fromJson(json["state"]),
    );
  }

}

class State {
  State({
    required this.id,
  });

  final String? id;

  factory State.fromJson(Map<String, dynamic> json){
    return State(
      id: json["id"],
    );
  }

}

class LeadCountry {
  LeadCountry({
    required this.id,
    required this.name,
    required this.shortName,
    required this.native,
    required this.phone,
    required this.continent,
    required this.capital,
    required this.currency,
    required this.status,
    required this.installStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? shortName;
  final String? native;
  final String? phone;
  final String? continent;
  final String? capital;
  final String? currency;
  final String? status;
  final bool? installStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory LeadCountry.fromJson(Map<String, dynamic> json){
    return LeadCountry(
      id: json["id"],
      name: json["name"],
      shortName: json["shortName"],
      native: json["native"],
      phone: json["phone"],
      continent: json["continent"],
      capital: json["capital"],
      currency: json["currency"],
      status: json["status"],
      installStatus: json["installStatus"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Pincode {
  Pincode({
    required this.id,
    required this.district,
  });

  final String? id;
  final District? district;

  factory Pincode.fromJson(Map<String, dynamic> json){
    return Pincode(
      id: json["id"],
      district: json["district"] == null ? null : District.fromJson(json["district"]),
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
    required this.subTypes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.activityChartInterval,
    required this.activityChartLabelY,
    required this.activityChartLabelX,
    required this.isReminderRequired,
    required this.removeFromTodo,
    required this.removeFromList,
  });

  final String? id;
  final String? name;
  final dynamic subTypes;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? activityChartInterval;
  final dynamic activityChartLabelY;
  final String? activityChartLabelX;
  final bool? isReminderRequired;
  final bool? removeFromTodo;
  final bool? removeFromList;

  factory Type.fromJson(Map<String, dynamic> json){
    return Type(
      id: json["id"],
      name: json["name"],
      subTypes: json["sub_types"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      activityChartInterval: json["activity_chart_interval"],
      activityChartLabelY: json["activity_chart_label_y"],
      activityChartLabelX: json["activity_chart_label_x"],
      isReminderRequired: json["isReminderRequired"],
      removeFromTodo: json["remove_from_todo"],
      removeFromList: json["remove_from_list"],
    );
  }

}
