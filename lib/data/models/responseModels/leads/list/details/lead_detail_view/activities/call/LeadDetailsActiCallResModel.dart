class LeadDetailsActiCallResModel {
  LeadDetailsActiCallResModel({
    required this.id,
    required this.mobile,
    required this.countryCode,
    required this.status,
    required this.remark,
    required this.productCategories,
    required this.lat,
    required this.lng,
    required this.location,
    required this.duration,
    required this.recordingFile,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.reminder,
    required this.notifyUsers,
    required this.createdBy,
    required this.leadType,
    required this.leadSubType,
  });

  final String? id;
  final String? mobile;
  final String? countryCode;
  final String? status;
  final String? remark;
  final String? productCategories;
  final double? lat;
  final double? lng;
  final dynamic location;
  final int? duration;
  final dynamic recordingFile;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Reminder? reminder;
  final List<NotifyUser> notifyUsers;
  final CreatedBy? createdBy;
  final LeadType? leadType;
  final LeadType? leadSubType;

  factory LeadDetailsActiCallResModel.fromJson(Map<String, dynamic> json){
    return LeadDetailsActiCallResModel(
      id: json["id"],
      mobile: json["mobile"],
      countryCode: json["country_code"],
      status: json["status"],
      remark: json["remark"],
      productCategories: json["product_categories"],
      lat: json["lat"]?.toDouble(),
      lng: json["lng"]?.toDouble(),
      location: json["location"],
      duration: json["duration"],
      recordingFile: json["recording_file"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      reminder: json["reminder"] == null ? null : Reminder.fromJson(json["reminder"]),
      notifyUsers: json["notify_users"] == null ? [] : List<NotifyUser>.from(json["notify_users"]!.map((x) => NotifyUser.fromJson(x))),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      leadType: json["lead_type"] == null ? null : LeadType.fromJson(json["lead_type"]),
      leadSubType: json["lead_sub_type"] == null ? null : LeadType.fromJson(json["lead_sub_type"]),
    );
  }

  // Added static method to convert list of JSON objects to list of models
  static List<LeadDetailsActiCallResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiCallResModel.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "mobile": mobile,
    "country_code": countryCode,
    "status": status,
    "remark": remark,
    "product_categories": productCategories,
    "lat": lat,
    "lng": lng,
    "location": location,
    "duration": duration,
    "recording_file": recordingFile,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "reminder": reminder?.toJson(),
    "notify_users": notifyUsers.map((x) => x.toJson()).toList(),
    "created_by": createdBy?.toJson(),
    "lead_type": leadType?.toJson(),
    "lead_sub_type": leadSubType?.toJson(),
  };
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class LeadType {
  LeadType({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory LeadType.fromJson(Map<String, dynamic> json){
    return LeadType(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class NotifyUser {
  NotifyUser({
    required this.id,
    required this.user,
  });

  final String? id;
  final CreatedBy? user;

  factory NotifyUser.fromJson(Map<String, dynamic> json){
    return NotifyUser(
      id: json["id"],
      user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "user": user?.toJson(),
  };
}

class Reminder {
  Reminder({
    required this.id,
    required this.title,
    required this.category,
    required this.type,
    required this.recurringFrequency,
    required this.recurringInterval,
    required this.remark,
    required this.reminderDate,
    required this.reminderStatus,
    required this.notifyCustomer,
    required this.reminderTo,
  });

  final String? id;
  final String? title;
  final String? category;
  final String? type;
  final dynamic recurringFrequency;
  final dynamic recurringInterval;
  final String? remark;
  final DateTime? reminderDate;
  final bool? reminderStatus;
  final bool? notifyCustomer;
  final CreatedBy? reminderTo;

  factory Reminder.fromJson(Map<String, dynamic> json){
    return Reminder(
      id: json["id"],
      title: json["title"],
      category: json["category"],
      type: json["type"],
      recurringFrequency: json["recurring_frequency"],
      recurringInterval: json["recurring_interval"],
      remark: json["remark"],
      reminderDate: DateTime.tryParse(json["reminder_date"] ?? ""),
      reminderStatus: json["reminder_status"],
      notifyCustomer: json["notify_customer"],
      reminderTo: json["reminder_to"] == null ? null : CreatedBy.fromJson(json["reminder_to"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "type": type,
    "recurring_frequency": recurringFrequency,
    "recurring_interval": recurringInterval,
    "remark": remark,
    "reminder_date": reminderDate?.toIso8601String(),
    "reminder_status": reminderStatus,
    "notify_customer": notifyCustomer,
    "reminder_to": reminderTo?.toJson(),
  };
}