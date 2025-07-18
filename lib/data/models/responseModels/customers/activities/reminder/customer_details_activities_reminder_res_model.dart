class CustomerDetailsActiReminderResModel {
  CustomerDetailsActiReminderResModel({
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
    required this.company,
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
  final Company? company;
  final CreatedBy? reminderTo;
  final List<dynamic> notifyUsers;
  final CreatedBy? createdBy;

  factory CustomerDetailsActiReminderResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsActiReminderResModel(
      id: json["id"] as String?,
      title: json["title"] as String?,
      category: json["category"] as String?,
      type: json["type"] as String?,
      recurringFrequency: json["recurring_frequency"],
      recurringInterval: json["recurring_interval"],
      remark: json["remark"] as String?,
      reminderDate: json["reminder_date"] != null && json["reminder_date"] != ""
          ? DateTime.tryParse(json["reminder_date"])
          : null,
      reminderStatus: json["reminder_status"] as bool?,
      notifyCustomer: json["notify_customer"] as bool?,
      createdAt: json["created_at"] != null && json["created_at"] != ""
          ? DateTime.tryParse(json["created_at"])
          : null,
      updatedAt: json["updated_at"] != null && json["updated_at"] != ""
          ? DateTime.tryParse(json["updated_at"])
          : null,
      deletedAt: json["deleted_at"],
      company: json["company"] == null ? null : Company.fromJson(json["company"] as Map<String, dynamic>),
      reminderTo: json["reminder_to"] == null ? null : CreatedBy.fromJson(json["reminder_to"] as Map<String, dynamic>),
      notifyUsers: json["notify_users"] == null ? [] : List<dynamic>.from(json["notify_users"]),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"] as Map<String, dynamic>),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsActiReminderResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailsActiReminderResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"] as String?,
      companyName: json["company_name"] as String?,
      companyEmail: json["company_email"] as String?,
    );
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
      id: json["id"] as String?,
      firstName: json["first_name"] as String?,
      lastName: json["last_name"] as String?,
    );
  }
}


