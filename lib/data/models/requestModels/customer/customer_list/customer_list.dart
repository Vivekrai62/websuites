class CustomerRequestModel {
  String? assignedRange;
  String? assignedTo;
  String? city;
  Map<String, dynamic>? customFields;
  bool? customerAssignedToTeam;
  String? customerType;
  String? division;
  String? source;
  int? limit;
  String? notificationId;
  int? page;
  String? paginationType;
  String? productCategory;
  String? projectStatus;
  Range? range;
  Range? reminderRange;
  String? reminderType;
  String? search;
  String? serviceStatus;
  String? status;
  String? typeId;

  CustomerRequestModel({
    this.assignedRange,
    this.assignedTo,
    this.city,
    this.customFields,
    this.customerAssignedToTeam,
    this.customerType,
    this.division,
    this.source,
    this.limit,
    this.notificationId,
    this.page,
    this.paginationType,
    this.productCategory,
    this.projectStatus,
    this.range,
    this.reminderRange,
    this.reminderType,
    this.search,
    this.serviceStatus,
    this.status,
    this.typeId,
  });

  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerRequestModel(
      assignedRange: json['assigned_range'] as String?,
      assignedTo: json['assigned_to'] as String?,
      city: json['city'] as String?,
      customFields: json['custom_fields'] as Map<String, dynamic>?,
      customerAssignedToTeam: json['customer_assigned_to_team'] as bool?,
      customerType: json['customer_type'] as String?,
      division: json['division'] as String?,
      source: json['source'] as String?,
      limit: json['limit'] as int?,
      notificationId: json['notification_id'] as String?,
      page: json['page'] as int?,
      paginationType: json['pagination_type'] as String?,
      productCategory: json['product_category'] as String?,
      projectStatus: json['project_status'] as String?, // Consistent with API
      range: json['range'] != null ? Range.fromJson(json['range'] as Map<String, dynamic>) : null,
      reminderRange: json['reminder_range'] != null ? Range.fromJson(json['reminder_range'] as Map<String, dynamic>) : null,
      reminderType: json['reminder_type'] as String?,
      search: json['search'] as String?,
      serviceStatus: json['service_status'] as String?, // Consistent with API
      status: json['status'] as String?,
      typeId: json['type_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_range'] = assignedRange;
    data['assigned_to'] = assignedTo;
    data['city'] = city;
    data['custom_fields'] = customFields;
    data['customer_assigned_to_team'] = customerAssignedToTeam;
    data['customer_type'] = customerType;
    data['division'] = division;
    data['source'] = source;
    data['limit'] = limit;
    data['notification_id'] = notificationId;
    data['page'] = page;
    data['pagination_type'] = paginationType;
    data['product_category'] = productCategory;
    data['project_status'] = projectStatus; // Consistent with API
    if (range != null) data['range'] = range!.toJson();
    if (reminderRange != null) data['reminder_range'] = reminderRange!.toJson();
    data['reminder_type'] = reminderType;
    data['search'] = search;
    data['service_status'] = serviceStatus; // Consistent with API
    data['status'] = status;
    data['type_id'] = typeId;
    return data;
  }
}

class Range {
  final String from;
  final String to;

  Range({required this.from, required this.to});

  factory Range.fromJson(Map<String, dynamic> json) {
    return Range(
      from: json['from'] as String,
      to: json['to'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}

