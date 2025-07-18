class CustomerViewCreditDebitResponseModel {
  CustomerViewCreditDebitResponseModel({
    required this.serviceStatus,
    required this.projectStatus,
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.primaryEmail,
    required this.countryCode,
    required this.primaryContact,
    required this.organization,
    required this.websites,
    required this.primaryAddress,
    required this.profileImage,
    required this.dob,
    required this.gstin,
    required this.aboutClient,
    required this.otherInformation,
    required this.lat,
    required this.lng,
    required this.joinedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.deleteRemark,
    required this.zohoContactId,
    required this.status,
    required this.subStatus,
    required this.customerAssigned,
    required this.customerType,
    required this.contact,
    required this.pincode,
    required this.district,
    required this.city,
    required this.state,
    required this.country,
    required this.customerToCustomFields,
    required this.source,
    required this.divisions,
    required this.secondaryEmails,
    required this.secondaryMobiles,
    required this.companies,
    required this.creditDebit,
    required this.projects,
    required this.orders,
    required this.customerCredits,
  });

  final String? serviceStatus;
  final ProjectStatus? projectStatus;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final String? organization;
  final List<String> websites;
  final String? primaryAddress;
  final dynamic profileImage;
  final dynamic dob;
  final String? gstin;
  final String? aboutClient;
  final String? otherInformation;
  final double? lat;
  final double? lng;
  final dynamic joinedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final dynamic zohoContactId;
  final String? status;
  final dynamic subStatus;
  final List<CustomerAssigned> customerAssigned;
  final City? customerType;
  final Contact? contact;
  final Pincode? pincode;
  final City? district;
  final City? city;
  final City? state;
  final City? country;
  final List<CustomerToCustomField> customerToCustomFields;
  final City? source;
  final List<City> divisions;
  final List<dynamic> secondaryEmails;
  final List<dynamic> secondaryMobiles;
  final List<Company> companies;
  final List<CreditDebit> creditDebit;
  final List<Project> projects;
  final List<OrderElement> orders;
  final int? customerCredits;

  factory CustomerViewCreditDebitResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerViewCreditDebitResponseModel(
      serviceStatus: json["serviceStatus"],
      projectStatus: json["projectStatus"] == null ? null : ProjectStatus.fromJson(json["projectStatus"]),
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      primaryEmail: json["primary_email"],
      countryCode: json["country_code"],
      primaryContact: json["primary_contact"],
      organization: json["organization"],
      websites: json["websites"] == null ? [] : List<String>.from(json["websites"]!.map((x) => x)),
      primaryAddress: json["primary_address"],
      profileImage: json["profile_image"],
      dob: json["dob"],
      gstin: json["gstin"],
      aboutClient: json["about_client"],
      otherInformation: json["other_information"],
      lat: json["lat"],
      lng: json["lng"],
      joinedAt: json["joined_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoContactId: json["zoho_contact_id"],
      status: json["status"],
      subStatus: json["subStatus"],
      customerAssigned: json["customer_assigned"] == null ? [] : List<CustomerAssigned>.from(json["customer_assigned"]!.map((x) => CustomerAssigned.fromJson(x))),
      customerType: json["customer_type"] == null ? null : City.fromJson(json["customer_type"]),
      contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
      pincode: json["pincode"] == null ? null : Pincode.fromJson(json["pincode"]),
      district: json["district"] == null ? null : City.fromJson(json["district"]),
      city: json["city"] == null ? null : City.fromJson(json["city"]),
      state: json["state"] == null ? null : City.fromJson(json["state"]),
      country: json["country"] == null ? null : City.fromJson(json["country"]),
      customerToCustomFields: json["customerToCustomFields"] == null ? [] : List<CustomerToCustomField>.from(json["customerToCustomFields"]!.map((x) => CustomerToCustomField.fromJson(x))),
      source: json["source"] == null ? null : City.fromJson(json["source"]),
      divisions: json["divisions"] == null ? [] : List<City>.from(json["divisions"]!.map((x) => City.fromJson(x))),
      secondaryEmails: json["secondary_emails"] == null ? [] : List<dynamic>.from(json["secondary_emails"]!.map((x) => x)),
      secondaryMobiles: json["secondary_mobiles"] == null ? [] : List<dynamic>.from(json["secondary_mobiles"]!.map((x) => x)),
      companies: json["companies"] == null ? [] : List<Company>.from(json["companies"]!.map((x) => Company.fromJson(x))),
      creditDebit: json["credit_debit"] == null ? [] : List<CreditDebit>.from(json["credit_debit"]!.map((x) => CreditDebit.fromJson(x))),
      projects: json["projects"] == null ? [] : List<Project>.from(json["projects"]!.map((x) => Project.fromJson(x))),
      orders: json["orders"] == null ? [] : List<OrderElement>.from(json["orders"]!.map((x) => OrderElement.fromJson(x))),
      customerCredits: json["customerCredits"],
    );
  }

}

class City {
  City({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory City.fromJson(Map<String, dynamic> json){
    return City(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.cCountryCode,
    required this.address,
    required this.website,
    required this.gst,
    required this.logo,
    required this.lat,
    required this.lng,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final int? countryCode;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final int? cCountryCode;
  final String? address;
  final String? website;
  final String? gst;
  final dynamic logo;
  final int? lat;
  final int? lng;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      companyName: json["company_name"],
      companyEmail: json["company_email"],
      companyPhone: json["company_phone"],
      countryCode: json["country_code"],
      contactPersonName: json["contact_person_name"],
      contactPersonNumber: json["contact_person_number"],
      cCountryCode: json["c_country_code"],
      address: json["address"],
      website: json["website"],
      gst: json["gst"],
      logo: json["logo"],
      lat: json["lat"],
      lng: json["lng"],
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

class CreditDebit {
  CreditDebit({
    required this.id,
    required this.type,
    required this.amount,
    required this.status,
    required this.creditUse,
    required this.order,
  });

  final String? id;
  final String? type;
  final String? amount;
  final String? status;
  final List<CreditUse> creditUse;
  final CreditUseOrder? order;

  factory CreditDebit.fromJson(Map<String, dynamic> json){
    return CreditDebit(
      id: json["id"],
      type: json["type"],
      amount: json["amount"],
      status: json["status"],
      creditUse: json["credit_use"] == null ? [] : List<CreditUse>.from(json["credit_use"]!.map((x) => CreditUse.fromJson(x))),
      order: json["order"] == null ? null : CreditUseOrder.fromJson(json["order"]),
    );
  }

}

class CreditUse {
  CreditUse({
    required this.id,
    required this.amount,
    required this.order,
  });

  final String? id;
  final String? amount;
  final CreditUseOrder? order;

  factory CreditUse.fromJson(Map<String, dynamic> json){
    return CreditUse(
      id: json["id"],
      amount: json["amount"],
      order: json["order"] == null ? null : CreditUseOrder.fromJson(json["order"]),
    );
  }

}

class CreditUseOrder {
  CreditUseOrder({
    required this.id,
    required this.orderNumber,
  });

  final String? id;
  final int? orderNumber;

  factory CreditUseOrder.fromJson(Map<String, dynamic> json){
    return CreditUseOrder(
      id: json["id"],
      orderNumber: json["order_number"],
    );
  }

}

class CustomerAssigned {
  CustomerAssigned({
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final String? id;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  factory CustomerAssigned.fromJson(Map<String, dynamic> json){
    return CustomerAssigned(
      id: json["id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

}

class User {
  User({
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
    required this.userDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? bio;
  final String? profilePic;
  final String? password;
  final bool? status;
  final String? rememberToken;
  final dynamic rememberTokenTime;
  final bool? userDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;

  factory User.fromJson(Map<String, dynamic> json){
    return User(
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
      userDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
    );
  }

}

class CustomerToCustomField {
  CustomerToCustomField({
    required this.id,
    required this.customerId,
    required this.customId,
    required this.fieldName,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    required this.customfields,
  });

  final String? id;
  final String? customerId;
  final String? customId;
  final String? fieldName;
  final String? value;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CustomField? customfields;

  factory CustomerToCustomField.fromJson(Map<String, dynamic> json){
    return CustomerToCustomField(
      id: json["id"],
      customerId: json["customer_id"],
      customId: json["custom_id"],
      fieldName: json["field_name"],
      value: json["value"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customfields: json["customfields"] == null ? null : CustomField.fromJson(json["customfields"]),
    );
  }

}

class CustomField {
  CustomField({
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

  factory CustomField.fromJson(Map<String, dynamic> json){
    return CustomField(
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

class OrderElement {
  OrderElement({
    required this.id,
    required this.orderNumber,
    required this.gstFees,
    required this.tdsPercentage,
    required this.amount,
    required this.tdsAmount,
    required this.totalAmount,
    required this.payabaleAmount,
    required this.performaInvoice,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.deleteRemark,
    required this.zohoSalesorderId,
    required this.orderProducts,
  });

  final String? id;
  final int? orderNumber;
  final int? gstFees;
  final int? tdsPercentage;
  final int? amount;
  final int? tdsAmount;
  final int? totalAmount;
  final int? payabaleAmount;
  final String? performaInvoice;
  final String? status;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final String? zohoSalesorderId;
  final List<OrderProduct> orderProducts;

  factory OrderElement.fromJson(Map<String, dynamic> json){
    return OrderElement(
      id: json["id"],
      orderNumber: json["order_number"],
      gstFees: json["gst_fees"],
      tdsPercentage: json["tds_percentage"],
      amount: json["amount"],
      tdsAmount: json["tds_amount"],
      totalAmount: json["total_amount"],
      payabaleAmount: json["payabale_amount"],
      performaInvoice: json["performa_invoice"],
      status: json["status"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoSalesorderId: json["zoho_salesorder_id"],
      orderProducts: json["order_products"] == null ? [] : List<OrderProduct>.from(json["order_products"]!.map((x) => OrderProduct.fromJson(x))),
    );
  }

}

class OrderProduct {
  OrderProduct({
    required this.id,
    required this.productType,
    required this.paymentMode,
    required this.paymentType,
    required this.mrp,
    required this.salePrice,
    required this.gst,
    required this.gstPercentage,
    required this.tdsOption,
    required this.tds,
    required this.tdsPercentage,
    required this.gstInfo,
    required this.total,
    required this.quantity,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.services,
  });

  final String? id;
  final String? productType;
  final String? paymentMode;
  final String? paymentType;
  final int? mrp;
  final int? salePrice;
  final int? gst;
  final int? gstPercentage;
  final String? tdsOption;
  final int? tds;
  final int? tdsPercentage;
  final String? gstInfo;
  final int? total;
  final int? quantity;
  final int? duration;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<Service> services;

  factory OrderProduct.fromJson(Map<String, dynamic> json){
    return OrderProduct(
      id: json["id"],
      productType: json["product_type"],
      paymentMode: json["payment_mode"],
      paymentType: json["payment_type"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      gst: json["gst"],
      gstPercentage: json["gst_percentage"],
      tdsOption: json["tds_option"],
      tds: json["tds"],
      tdsPercentage: json["tds_percentage"],
      gstInfo: json["gst_info"],
      total: json["total"],
      quantity: json["quantity"],
      duration: json["duration"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      services: json["services"] == null ? [] : List<Service>.from(json["services"]!.map((x) => Service.fromJson(x))),
    );
  }

}

class Service {
  Service({
    required this.id,
    required this.startDate,
    required this.endDate,
    required this.remark,
    required this.reminderBeforeExpire,
    required this.status,
    required this.quitReason,
    required this.quitDate,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.isDisposed,
  });

  final String? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic remark;
  final DateTime? reminderBeforeExpire;
  final bool? status;
  final dynamic quitReason;
  final dynamic quitDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? isDisposed;

  factory Service.fromJson(Map<String, dynamic> json){
    return Service(
      id: json["id"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      remark: json["remark"],
      reminderBeforeExpire: DateTime.tryParse(json["reminder_before_expire"] ?? ""),
      status: json["status"],
      quitReason: json["quit_reason"],
      quitDate: json["quit_date"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      isDisposed: json["isDisposed"],
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

class ProjectStatus {
  ProjectStatus({
    required this.notStarted,
    required this.inProgress,
  });

  final int? notStarted;
  final int? inProgress;

  factory ProjectStatus.fromJson(Map<String, dynamic> json){
    return ProjectStatus(
      notStarted: json["Not Started"],
      inProgress: json["In Progress"],
    );
  }

}

class Project {
  Project({
    required this.id,
    required this.projectName,
    required this.billingType,
    required this.status,
    required this.totalRate,
    required this.estimatedHours,
    required this.startDate,
    required this.deadline,
    required this.description,
    required this.demoUrl,
    required this.finishDate,
    required this.liveUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? projectName;
  final String? billingType;
  final String? status;
  final int? totalRate;
  final int? estimatedHours;
  final DateTime? startDate;
  final dynamic deadline;
  final String? description;
  final String? demoUrl;
  final dynamic finishDate;
  final String? liveUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Project.fromJson(Map<String, dynamic> json){
    return Project(
      id: json["id"],
      projectName: json["project_name"],
      billingType: json["billing_type"],
      status: json["status"],
      totalRate: json["total_rate"],
      estimatedHours: json["estimated_hours"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      deadline: json["deadline"],
      description: json["description"],
      demoUrl: json["demo_url"],
      finishDate: json["finish_date"],
      liveUrl: json["live_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}
