class CustomerCompaniesResponseModel {
  List<Items>? items;
  Meta? meta;

  CustomerCompaniesResponseModel({this.items, this.meta});

  CustomerCompaniesResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? contactCountryCode;
  String? address;
  String? website;
  String? gst;
  String? logo;
  double? lat;
  double? lng;
  Customer? customer;
  Parent? parent;

  Items({
    this.id,
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.countryCode,
    this.contactPersonName,
    this.contactPersonNumber,
    this.contactCountryCode,
    this.address,
    this.website,
    this.gst,
    this.logo,
    this.lat,
    this.lng,
    this.customer,
    this.parent,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    countryCode = json['country_code'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactCountryCode = json['c_country_code'];
    address = json['address'];
    website = json['website'];
    gst = json['gst'];
    logo = json['logo'];
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
    customer = json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
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
    data['c_country_code'] = contactCountryCode;
    data['address'] = address;
    data['website'] = website;
    data['gst'] = gst;
    data['logo'] = logo;
    data['lat'] = lat;
    data['lng'] = lng;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    return data;
  }
}

class Customer {
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

  Customer({
    this.id,
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
    this.subStatus,
  });

  Customer.fromJson(Map<String, dynamic> json) {
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
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
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

class Parent {
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? contactCountryCode;
  String? address;
  String? website;
  String? gst;
  String? logo;
  double? lat;
  double? lng;

  Parent({
    this.id,
    this.companyName,
    this.companyEmail,
    this.companyPhone,
    this.countryCode,
    this.contactPersonName,
    this.contactPersonNumber,
    this.contactCountryCode,
    this.address,
    this.website,
    this.gst,
    this.logo,
    this.lat,
    this.lng,
  });

  Parent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    countryCode = json['country_code'];
    contactPersonName = json['contact_person_name'];
    contactPersonNumber = json['contact_person_number'];
    contactCountryCode = json['c_country_code'];
    address = json['address'];
    website = json['website'];
    gst = json['gst'];
    logo = json['logo'];
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
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
    data['c_country_code'] = contactCountryCode;
    data['address'] = address;
    data['website'] = website;
    data['gst'] = gst;
    data['logo'] = logo;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount,
  });

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
