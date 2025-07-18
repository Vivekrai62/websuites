import 'dart:convert';


class LeadListResponseModel {
  LeadListResponseModel({
    required this.items,
    required this.meta,
    required this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;

  factory LeadListResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadListResponseModel(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": List<dynamic>.from(items.map((x) => x.toJson())),
      "meta": meta?.toJson(),
      "user_key": userKey,
    };
  }
}

class Item {
  Item({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.countryCode,
    required this.mobile,
    required this.mobileWithCountrycode,
    required this.email,
    required this.organization,
    required this.address,
    required this.city,
    required this.state,
    required this.deadRemark,
    required this.createdAt,
    required this.updatedAt,
    required this.latestEnquiryDate,
    required this.leadStatus,
    required this.type,
    required this.subType,
    required this.enquiries,
    required this.leadAssigned,
    required this.lastReminder,
    required this.lastActivity,
    required this.pincode,
    required this.leadCity,
    required this.leadState,
    required this.leadCountry,
    required this.source,
    required this.divisions,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final int? countryCode;
  final String? mobile;
  final String? mobileWithCountrycode;
  final String? email;
  final String? organization;
  final String? address;
  final dynamic city;
  final dynamic state;
  final dynamic deadRemark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? latestEnquiryDate;
  final String? leadStatus;
  final LeadCountry? type;
  final LeadCountry? subType;
  final List<Enquiry> enquiries;
  final List<LeadAssigned> leadAssigned;
  final LastReminder? lastReminder;
  final LastActivity? lastActivity;
  final dynamic pincode;
  final dynamic leadCity;
  final dynamic leadState;
  final LeadCountry? leadCountry;
  final LeadCountry? source;
  final List<LeadCountry> divisions;

  factory Item.fromJson(Map<String, dynamic> json) {
    print("Raw JSON for Item: ${jsonEncode(json)}");
    print("Address field: ${json["address"]}");
    return Item(
      id: json["id"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      countryCode: json["country_code"] ?? 0,
      mobile: json["mobile"] ?? "",
      mobileWithCountrycode: json["mobile_with_countrycode"] ?? "",
      email: json["email"] ?? "",
      organization: json["organization"] ?? "",
      address: json["address"]?.toString() ?? "", // Converts null to ""
      city: json["city"] ?? "",
      state: json["state"] ?? "",
      deadRemark: json["dead_remark"] ?? "",
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      latestEnquiryDate: json["latest_enquiry_date"] != null ? DateTime.tryParse(json["latest_enquiry_date"]) : null,
      leadStatus: json["lead_status"] ?? "",
      type: json["type"] == null ? null : LeadCountry.fromJson(json["type"]),
      subType: json["sub_type"] == null ? null : LeadCountry.fromJson(json["sub_type"]),
      enquiries: json["enquiries"] == null
          ? []
          : List<Enquiry>.from(json["enquiries"]!.map((x) => Enquiry.fromJson(x))),
      leadAssigned: json["lead_assigned"] == null
          ? []
          : List<LeadAssigned>.from(json["lead_assigned"]!.map((x) => LeadAssigned.fromJson(x))),
      lastReminder: json["last_reminder"] == null ? null : LastReminder.fromJson(json["last_reminder"]),
      lastActivity: json["last_activity"] == null ? null : LastActivity.fromJson(json["last_activity"]),
      pincode: json["pincode"] ?? "",
      leadCity: json["lead_city"] ?? "",
      leadState: json["lead_state"] ?? "",
      leadCountry: json["lead_country"] == null ? null : LeadCountry.fromJson(json["lead_country"]),
      source: json["source"] == null ? null : LeadCountry.fromJson(json["source"]),
      divisions: json["divisions"] == null
          ? []
          : List<LeadCountry>.from(json["divisions"]!.map((x) => LeadCountry.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "country_code": countryCode,
      "mobile": mobile,
      "mobile_with_countrycode": mobileWithCountrycode,
      "email": email,
      "organization": organization,
      "address": address,
      "city": city,
      "state": state,
      "dead_remark": deadRemark,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "latest_enquiry_date": latestEnquiryDate?.toIso8601String(),
      "lead_status": leadStatus, // Fixed: "leadStatus" -> "lead_status"
      "type": type?.toJson(),
      "sub_type": subType?.toJson(),
      "enquiries": List<dynamic>.from(enquiries.map((x) => x.toJson())),
      "lead_assigned": List<dynamic>.from(leadAssigned.map((x) => x.toJson())),
      "last_reminder": lastReminder?.toJson(),
      "last_activity": lastActivity?.toJson(),
      "pincode": pincode,
      "lead_city": leadCity,
      "lead_state": leadState,
      "lead_country": leadCountry?.toJson(),
      "source": source?.toJson(),
      "divisions": List<dynamic>.from(divisions.map((x) => x.toJson())),
    };
  }
}

class LeadCountry {
  LeadCountry({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory LeadCountry.fromJson(Map<String, dynamic> json) {
    return LeadCountry(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class Enquiry {
  Enquiry({
    required this.id,
  });

  final String? id;

  factory Enquiry.fromJson(Map<String, dynamic> json) {
    return Enquiry(
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
    };
  }
}

class LastActivity {
  LastActivity({
    required this.id,
    required this.activity,
    required this.remark,
    required this.createdAt,
  });

  final String? id;
  final String? activity;
  final String? remark;
  final DateTime? createdAt;

  factory LastActivity.fromJson(Map<String, dynamic> json) {
    return LastActivity(
      id: json["id"],
      activity: json["activity"],
      remark: json["remark"],
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "activity": activity,
      "remark": remark,
      "created_at": createdAt?.toIso8601String(),
    };
  }
}

class LastReminder {
  LastReminder({
    required this.id,
    required this.remark,
    required this.reminder,
    required this.reminderStatus,
    required this.createdAt,
  });

  final String? id;
  final String? remark;
  final DateTime? reminder;
  final bool? reminderStatus;
  final DateTime? createdAt;

  factory LastReminder.fromJson(Map<String, dynamic> json) {
    return LastReminder(
      id: json["id"],
      remark: json["remark"],
      reminder: json["reminder"] != null ? DateTime.tryParse(json["reminder"]) : null,
      reminderStatus: json["reminder_status"],
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "remark": remark,
      "reminder": reminder?.toIso8601String(),
      "reminder_status": reminderStatus,
      "created_at": createdAt?.toIso8601String(),
    };
  }
}

class LeadAssigned {
  LeadAssigned({
    required this.id,
    required this.status,
    required this.workStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  final String? id;
  final int? status;
  final int? workStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final User? user;

  factory LeadAssigned.fromJson(Map<String, dynamic> json) {
    return LeadAssigned(
      id: json["id"],
      status: json["status"],
      workStatus: json["work_status"],
      createdAt: json["created_at"] != null ? DateTime.tryParse(json["created_at"]) : null,
      updatedAt: json["updated_at"] != null ? DateTime.tryParse(json["updated_at"]) : null,
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "status": status,
      "work_status": workStatus,
      "created_at": createdAt?.toIso8601String(),
      "updated_at": updatedAt?.toIso8601String(),
      "user": user?.toJson(),
    };
  }
}

class User {
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
    };
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["current_page"], // Fixed: "currentPage" -> "current_page"
      itemsPerPage: json["items_per_page"], // Fixed: "itemsPerPage" -> "items_per_page"
      totalPages: json["total_pages"], // Fixed: "totalPages" -> "total_pages"
      totalItems: json["total_items"], // Fixed: "totalItems" -> "total_items"
      itemCount: json["item_count"], // Fixed: "itemCount" -> "item_count"
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "current_page": currentPage, // Fixed: "currentPage" -> "current_page"
      "items_per_page": itemsPerPage, // Fixed: "itemsPerPage" -> "items_per_page"
      "total_pages": totalPages, // Fixed: "totalPages" -> "total_pages"
      "total_items": totalItems, // Fixed: "totalItems" -> "total_items"
      "item_count": itemCount, // Fixed: "itemCount" -> "item_count"
    };
  }
}