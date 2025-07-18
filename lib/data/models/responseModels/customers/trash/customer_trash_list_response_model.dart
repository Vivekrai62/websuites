class CustomerTrashResponseModel {
  final List<CustomerItem>? items;
  final MetaData? meta;

  CustomerTrashResponseModel({
    this.items,
    this.meta,
  });

  factory CustomerTrashResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerTrashResponseModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => CustomerItem.fromJson(item))
          .toList(),
      meta: json['meta'] != null ? MetaData.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((item) => item.toJson()).toList(),
      'meta': meta?.toJson(),
    };
  }
}

class CustomerItem {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final String? organization;
  final List<String>? websites;
  final String? primaryAddress;
  final String? profileImage;
  final String? dob;
  final String? gstin;
  final String? aboutClient;
  final String? otherInformation;
  final double? lat;
  final double? lng;
  final String? joinedAt;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? deleteRemark;
  final String? zohoContactId;
  final String? status;
  final String? subStatus;
  final DeletedBy? deletedBy;

  CustomerItem({
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
    this.deletedBy,
  });

  factory CustomerItem.fromJson(Map<String, dynamic> json) {
    return CustomerItem(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      primaryEmail: json['primary_email'],
      countryCode: json['country_code'],
      primaryContact: json['primary_contact'],
      organization: json['organization'],
      websites: List<String>.from(json['websites'] ?? []),
      primaryAddress: json['primary_address'],
      profileImage: json['profile_image'],
      dob: json['dob'],
      gstin: json['gstin'],
      aboutClient: json['about_client'],
      otherInformation: json['other_information'],
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
      joinedAt: json['joined_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      deleteRemark: json['delete_remark'],
      zohoContactId: json['zoho_contact_id'],
      status: json['status'],
      subStatus: json['subStatus'],
      deletedBy: json['deleted_by'] != null
          ? DeletedBy.fromJson(json['deleted_by'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'primary_email': primaryEmail,
      'country_code': countryCode,
      'primary_contact': primaryContact,
      'organization': organization,
      'websites': websites,
      'primary_address': primaryAddress,
      'profile_image': profileImage,
      'dob': dob,
      'gstin': gstin,
      'about_client': aboutClient,
      'other_information': otherInformation,
      'lat': lat,
      'lng': lng,
      'joined_at': joinedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'delete_remark': deleteRemark,
      'zoho_contact_id': zohoContactId,
      'status': status,
      'subStatus': subStatus,
      'deleted_by': deletedBy?.toJson(),
    };
  }
}

class DeletedBy {
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
  final String? rememberTokenTime;
  final bool? defaultUser;
  final String? createdAt;
  final String? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;

  DeletedBy({
    this.id,
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
    this.defaultUser,
    this.createdAt,
    this.updatedAt,
    this.deviceId,
    this.tracking,
    this.crmCategory,
    this.mobileApp,
    this.superSettings,
  });

  factory DeletedBy.fromJson(Map<String, dynamic> json) {
    return DeletedBy(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      bio: json['bio'],
      profilePic: json['profile_pic'],
      password: json['password'],
      status: json['status'],
      rememberToken: json['remember_token'],
      rememberTokenTime: json['remember_token_time'],
      defaultUser: json['default'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deviceId: json['device_id'],
      tracking: json['tracking'],
      crmCategory: json['crm_category'],
      mobileApp: json['mobile_app'],
      superSettings: json['superSettings'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'address': address,
      'bio': bio,
      'profile_pic': profilePic,
      'password': password,
      'status': status,
      'remember_token': rememberToken,
      'remember_token_time': rememberTokenTime,
      'default': defaultUser,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'device_id': deviceId,
      'tracking': tracking,
      'crm_category': crmCategory,
      'mobile_app': mobileApp,
      'superSettings': superSettings,
    };
  }
}

class MetaData {
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  MetaData({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount,
  });

  factory MetaData.fromJson(Map<String, dynamic> json) {
    return MetaData(
      currentPage: json['currentPage'],
      itemsPerPage: json['itemsPerPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemCount': itemCount,
    };
  }
}
