class CustomerDetailViewActivitiesResponseModel {
  List<Items>? items;
  Meta? meta;
  String? userKey;

  CustomerDetailViewActivitiesResponseModel(
      {this.items, this.meta, this.userKey});

  CustomerDetailViewActivitiesResponseModel.fromJson(
      Map<String, dynamic> json) {
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
  String? activity;
  String? remark;
  String? reminder;
  bool? reminderStatus;
  String? meetingWith;
  String? meetingWithName;
  String? meetingWithPhone;
  Null dateContacted;
  Null services;
  String? lat;
  String? lng;
  Null remoteLocation;
  Null ccTo;
  bool? informedToCustomer;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  int? callDuration;
  Null recordFile;
  String? callActivtyDescription;
  Customer? customer;
  SubActivity? subActivity;
  Null customerType;
  Null screenshot;
  VisitedWith? visitedWith;
  VisitedWith? createdBy;
  VisitedWith? reminderTo;

  Items(
      {this.id,
      this.activity,
      this.remark,
      this.reminder,
      this.reminderStatus,
      this.meetingWith,
      this.meetingWithName,
      this.meetingWithPhone,
      this.dateContacted,
      this.services,
      this.lat,
      this.lng,
      this.remoteLocation,
      this.ccTo,
      this.informedToCustomer,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.callDuration,
      this.recordFile,
      this.callActivtyDescription,
      this.customer,
      this.subActivity,
      this.customerType,
      this.screenshot,
      this.visitedWith,
      this.createdBy,
      this.reminderTo});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activity = json['activity'];
    remark = json['remark'];
    reminder = json['reminder'];
    reminderStatus = json['reminder_status'];
    meetingWith = json['meeting_with'];
    meetingWithName = json['meeting_with_name'];
    meetingWithPhone = json['meeting_with_phone'];
    dateContacted = json['date_contacted'];
    services = json['services'];
    lat = json['lat'];
    lng = json['lng'];
    remoteLocation = json['remote_location'];
    ccTo = json['cc_to'];
    informedToCustomer = json['informed_to_customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    callDuration = json['call_duration'];
    recordFile = json['record_file'];
    callActivtyDescription = json['call_activty_description'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    subActivity = json['sub_activity'] != null
        ? SubActivity.fromJson(json['sub_activity'])
        : null;
    customerType = json['customer_type'];
    screenshot = json['screenshot'];
    visitedWith = json['visited_with'] != null
        ? VisitedWith.fromJson(json['visited_with'])
        : null;
    createdBy = json['created_by'] != null
        ? VisitedWith.fromJson(json['created_by'])
        : null;
    reminderTo = json['reminder_to'] != null
        ? VisitedWith.fromJson(json['reminder_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['activity'] = activity;
    data['remark'] = remark;
    data['reminder'] = reminder;
    data['reminder_status'] = reminderStatus;
    data['meeting_with'] = meetingWith;
    data['meeting_with_name'] = meetingWithName;
    data['meeting_with_phone'] = meetingWithPhone;
    data['date_contacted'] = dateContacted;
    data['services'] = services;
    data['lat'] = lat;
    data['lng'] = lng;
    data['remote_location'] = remoteLocation;
    data['cc_to'] = ccTo;
    data['informed_to_customer'] = informedToCustomer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['call_duration'] = callDuration;
    data['record_file'] = recordFile;
    data['call_activty_description'] = callActivtyDescription;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (subActivity != null) {
      data['sub_activity'] = subActivity!.toJson();
    }
    data['customer_type'] = customerType;
    data['screenshot'] = screenshot;
    if (visitedWith != null) {
      data['visited_with'] = visitedWith!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (reminderTo != null) {
      data['reminder_to'] = reminderTo!.toJson();
    }
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
  List<String>? websites;
  String? primaryAddress;
  Null profileImage;
  Null dob;
  String? gstin;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  Null joinedAt;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  Null deleteRemark;
  Null zohoContactId;
  String? status;
  Null subStatus;

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
      this.subStatus});

  Customer.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class SubActivity {
  String? id;
  String? type;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;

  SubActivity(
      {this.id,
      this.type,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SubActivity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class VisitedWith {
  String? id;
  String? firstName;
  String? lastName;

  VisitedWith({this.id, this.firstName, this.lastName});

  VisitedWith.fromJson(Map<String, dynamic> json) {
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
