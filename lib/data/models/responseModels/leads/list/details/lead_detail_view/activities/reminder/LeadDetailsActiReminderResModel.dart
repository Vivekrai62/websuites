class LeadDetailsActiReminderResModel {
  LeadDetailsActiReminderResModel({
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
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.reminderTo,
    required this.notifyUsers,
    required this.createdBy,
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final CreatedBy? reminderTo;
  final List<NotifyUser> notifyUsers;
  final CreatedBy? createdBy;

  factory LeadDetailsActiReminderResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsActiReminderResModel(
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
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      reminderTo: json["reminder_to"] == null ? null : CreatedBy.fromJson(json["reminder_to"]),
      notifyUsers: json["notify_users"] == null
          ? []
          : List<NotifyUser>.from(
          json["notify_users"]!.map((x) => NotifyUser.fromJson(x))),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "reminder_to": reminderTo?.toJson(),
    "notify_users": notifyUsers.map((x) => x.toJson()).toList(),
    "created_by": createdBy?.toJson(),
  };

  /// ✅ Added method to convert list of JSON objects to list of model instances
  static List<LeadDetailsActiReminderResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiReminderResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
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

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
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

class NotifyUser {
  NotifyUser({
    required this.id,
    required this.user,
  });

  final String? id;
  final CreatedBy? user;

  factory NotifyUser.fromJson(Map<String, dynamic> json) {
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
