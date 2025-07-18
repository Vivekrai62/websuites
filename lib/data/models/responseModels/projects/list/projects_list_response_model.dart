class ProjectListResponseModel {
  ProjectListResponseModel({
    required this.items,
    required this.meta,
    required this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;

  factory ProjectListResponseModel.fromJson(Map<String, dynamic> json){
    return ProjectListResponseModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }

}

class Item {
  Item({
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
    required this.customer,
    required this.members,
    required this.tags,
  });

  final String? id;
  final String? projectName;
  final String? billingType;
  final String? status;
  final int? totalRate;
  final int? estimatedHours;
  final DateTime? startDate;
  final DateTime? deadline;
  final String? description;
  final String? demoUrl;
  final dynamic finishDate;
  final String? liveUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Customer? customer;
  final List<Member> members;
  final List<Tag> tags;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      projectName: json["project_name"],
      billingType: json["billing_type"],
      status: json["status"],
      totalRate: json["total_rate"],
      estimatedHours: json["estimated_hours"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      deadline: DateTime.tryParse(json["deadline"] ?? ""),
      description: json["description"],
      demoUrl: json["demo_url"],
      finishDate: json["finish_date"],
      liveUrl: json["live_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
      tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
    );
  }

}

class Customer {
  Customer({
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
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final int? countryCode;
  final String? primaryContact;
  final String? organization;
  final List<dynamic> websites;
  final String? primaryAddress;
  final dynamic profileImage;
  final DateTime? dob;
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

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      primaryEmail: json["primary_email"],
      countryCode: json["country_code"],
      primaryContact: json["primary_contact"],
      organization: json["organization"],
      websites: json["websites"] == null ? [] : List<dynamic>.from(json["websites"].map((x) => x)),
      primaryAddress: json["primary_address"],
      profileImage: json["profile_image"],
      dob: DateTime.tryParse(json["dob"] ?? ""),
      gstin: json["gstin"],
      aboutClient: json["about_client"],
      otherInformation: json["other_information"],
      lat: json["lat"] != null ? (json["lat"] as num).toDouble() : null,
      lng: json["lng"] != null ? (json["lng"] as num).toDouble() : null,
      joinedAt: json["joined_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoContactId: json["zoho_contact_id"],
      status: json["status"],
      subStatus: json["subStatus"],
    );
  }
}


class Member {
  Member({
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
    required this.memberDefault,
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
  final dynamic profilePic;
  final String? password;
  final bool? status;
  final dynamic rememberToken;
  final dynamic rememberTokenTime;
  final bool? memberDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
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
      memberDefault: json["default"],
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

class Tag {
  Tag({
    required this.id,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json){
    return Tag(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

}
