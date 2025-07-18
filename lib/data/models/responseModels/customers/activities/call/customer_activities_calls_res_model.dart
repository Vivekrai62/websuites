class CustomerDetailsActivitiesCallResModel {
  CustomerDetailsActivitiesCallResModel({
    required this.id,
    required this.mobile,
    required this.countryCode,
    required this.status,
    required this.remark,
    required this.productCategories,
    required this.lat,
    required this.lng,
    this.location,
    required this.duration,
    this.recordingFile,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.reminder,
    required this.notifyUsers,
    required this.createdBy,
    this.leadType,
    this.leadSubType,
  });

  final String id;
  final String mobile;
  final String countryCode;
  final String status;
  final String remark;
  final String productCategories;
  final double lat;
  final double lng;
  final String? location;
  final int duration;
  final String? recordingFile;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final String? reminder;
  final List<dynamic> notifyUsers;
  final CreatedBy createdBy;
  final LeadType? leadType;
  final String? leadSubType;

  factory CustomerDetailsActivitiesCallResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsActivitiesCallResModel(
      id: json['id'] ?? '',
      mobile: json['mobile'] ?? '',
      countryCode: json['country_code'] ?? '',
      status: json['status'] ?? '',
      remark: json['remark'] ?? '',
      productCategories: json['product_categories'] ?? '',
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
      location: json['location'] as String?,
      duration: json['duration'] ?? 0,
      recordingFile: json['recording_file'] as String?,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: json['updated_at'] != null ? DateTime.tryParse(json['updated_at']) : null,
      deletedAt: json['deleted_at'] as String?,
      reminder: json['reminder'] as String?,
      notifyUsers: json['notify_users'] != null ? List<dynamic>.from(json['notify_users']) : [],
      createdBy: CreatedBy.fromJson(json['created_by'] ?? {'id': '', 'first_name': '', 'last_name': ''}),
      leadType: json['lead_type'] != null ? LeadType.fromJson(json['lead_type']) : null,
      leadSubType: json['lead_sub_type'] as String?,
    );
  }

  static List<CustomerDetailsActivitiesCallResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsActivitiesCallResModel.fromJson(json)).toList();
  }
}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String id;
  final String firstName;
  final String lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}

class LeadType {
  LeadType({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory LeadType.fromJson(Map<String, dynamic> json) {
    return LeadType(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
    );
  }
}


