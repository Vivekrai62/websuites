class LeadDetailsActiVisitOnlyResModel {
  LeadDetailsActiVisitOnlyResModel({
    required this.id,
    required this.action,
    required this.status,
    required this.companyName,
    required this.title,
    required this.meetingWith,
    required this.meetingWithMobile,
    required this.meetingWithEmail,
    required this.isVerifiedEmail,
    required this.isVerifiedMobile,
    required this.visitedWith,
    required this.remark,
    required this.createdAt,
    required this.department,
    required this.createdBy,
    required this.lat,
    required this.lng,
    required this.location,
    required this.reminderTo,
  });

  final String? id;
  final String? action;
  final String? status;
  final String? companyName;
  final String? title;
  final String? meetingWith;
  final String? meetingWithMobile;
  final String? meetingWithEmail;
  final bool? isVerifiedEmail;
  final bool? isVerifiedMobile;
  final String? visitedWith;
  final String? remark;
  final DateTime? createdAt;
  final dynamic department;
  final String? createdBy;
  final double? lat;
  final double? lng;
  final dynamic location;
  final String? reminderTo;

  factory LeadDetailsActiVisitOnlyResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsActiVisitOnlyResModel(
      id: json["id"] as String?,
      action: json["action"] as String?,
      status: json["status"] as String?,
      companyName: json["company_name"] as String?,
      title: json["title"] as String?,
      meetingWith: json["meeting_with"] as String?,
      meetingWithMobile: json["meeting_with_mobile"] as String?,
      meetingWithEmail: json["meeting_with_email"] as String?,
      isVerifiedEmail: json["is_verified_email"] as bool?,
      isVerifiedMobile: json["is_verified_mobile"] as bool?,
      visitedWith: json["visited_with"] as String?,
      remark: json["remark"] as String?,
      createdAt: json["created_at"] != null && json["created_at"] != ""
          ? DateTime.tryParse(json["created_at"])
          : null,
      department: json["department"],
      createdBy: json["created_By"] as String?,
      lat: (json["lat"] as num?)?.toDouble(),
      lng: (json["lng"] as num?)?.toDouble(),
      location: json["location"],
      reminderTo: json["reminder_to"] as String?,
    );
  }

  // Add this method to handle a list of JSON objects
  static List<LeadDetailsActiVisitOnlyResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiVisitOnlyResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}