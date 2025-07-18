class OrderSearchCustomerResponseModel {
  List<Items>? items;
  Meta? meta;
  Null userKey;

  OrderSearchCustomerResponseModel({this.items, this.meta, this.userKey});

  OrderSearchCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    userKey = json['user_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['user_key'] = userKey;
    return data;
  }
}

class Items {
  String? id;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  List<String>? websites;
  String? primaryAddress;
  dynamic profileImage;
  dynamic dob;
  String? gstin;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  dynamic joinedAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic deleteRemark;
  dynamic zohoContactId;
  String? status;
  dynamic subStatus;
  List<Companies>? companies;
  List<CustomerAssigned>? customerAssigned;

  Items(
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
      this.customerAssigned});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    websites = json['websites'].cast<String>();
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
    if (json['customer_assigned'] != null) {
      customerAssigned = <CustomerAssigned>[];
      json['customer_assigned'].forEach((v) {
        customerAssigned!.add(CustomerAssigned.fromJson(v));
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
    data['websites'] = websites;
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
    if (customerAssigned != null) {
      data['customer_assigned'] =
          customerAssigned!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companies {
  String? id;
  String? companyName;

  Companies({this.id, this.companyName});

  Companies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class CustomerAssigned {
  String? id;
  int? status;
  String? createdAt;
  User? user;

  CustomerAssigned({this.id, this.status, this.createdAt, this.user});

  CustomerAssigned.fromJson(Map<String, dynamic> json) {
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

  User({this.id, this.firstName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
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
