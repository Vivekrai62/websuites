class CustomerActivityStatusReportsResponseModel {
  Meta? meta;
  List<Items>? items;

  CustomerActivityStatusReportsResponseModel({this.meta, this.items});

  CustomerActivityStatusReportsResponseModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
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
  String? profileImage;
  String? dob;
  String? gstin;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  String? joinedAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deleteRemark;
  String? zohoContactId;
  String? status;
  String? subStatus;
  LastOrder? lastOrder;
  Projects? projects;
  List<RunningServices>? runningServices;
  RunningServices? lastService;

  Items({
    this.id,
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
    this.lastOrder,
    this.projects,
    this.runningServices,
    this.lastService,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    websites = json['websites'] != null ? List<String>.from(json['websites']) : null;
    primaryAddress = json['primary_address'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gstin = json['gstin'];
    aboutClient = json['about_client'];
    otherInformation = json['other_information'];
    lat = json['lat']?.toDouble(); // Ensure double conversion
    lng = json['lng']?.toDouble(); // Ensure double conversion
    joinedAt = json['joined_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoContactId = json['zoho_contact_id'];
    status = json['status'];
    subStatus = json['subStatus'];
    lastOrder = json['lastOrder'] != null ? LastOrder.fromJson(json['lastOrder']) : null;
    projects = json['projects'] != null ? Projects.fromJson(json['projects']) : null;

    if (json['runningServices'] != null) {
      runningServices = <RunningServices>[];
      json['runningServices'].forEach((v) {
        runningServices!.add(RunningServices.fromJson(v));
      });
    }

    lastService = json['lastService'] != null ? RunningServices.fromJson(json['lastService']) : null;
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

    if (lastOrder != null) {
      data['lastOrder'] = lastOrder!.toJson();
    }

    if (projects != null) {
      data['projects'] = projects!.toJson();
    }

    if (runningServices != null) {
      data['runningServices'] = runningServices!.map((v) => v.toJson()).toList();
    }

    if (lastService != null) {
      data['lastService'] = lastService!.toJson();
    }

    return data;
  }
}

class LastOrder {
  String? orderId;
  String? orderDate;
  String? status;

  LastOrder({this.orderId, this.orderDate, this.status});

  LastOrder.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    orderDate = json['orderDate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orderId'] = orderId;
    data['orderDate'] = orderDate;
    data['status'] = status;
    return data;
  }
}

class Projects {
  String? projectId;
  String? projectName;

  Projects({this.projectId, this.projectName});

  Projects.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    projectName = json['projectName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['projectId'] = projectId;
    data['projectName'] = projectName;
    return data;
  }
}

class RunningServices {
  String? serviceId;
  String? serviceName;

  RunningServices({this.serviceId, this.serviceName});

  RunningServices.fromJson(Map<String, dynamic> json) {
    serviceId = json['serviceId'];
    serviceName = json['serviceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceId'] = serviceId;
    data['serviceName'] = serviceName;
    return data;
  }
}
