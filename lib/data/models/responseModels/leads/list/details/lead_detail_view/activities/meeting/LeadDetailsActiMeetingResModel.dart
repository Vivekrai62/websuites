class LeadDetailsActiMeetingResModel {
  LeadDetailsActiMeetingResModel({
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

  factory LeadDetailsActiMeetingResModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailsActiMeetingResModel(
      id: json["id"],
      action: json["action"],
      status: json["status"],
      companyName: json["company_name"],
      title: json["title"],
      meetingWith: json["meeting_with"],
      meetingWithMobile: json["meeting_with_mobile"],
      meetingWithEmail: json["meeting_with_email"],
      isVerifiedEmail: json["is_verified_email"],
      isVerifiedMobile: json["is_verified_mobile"],
      visitedWith: json["visited_with"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      department: json["department"],
      createdBy: json["created_by"], // Fixed typo: "created_By" to "created_by"
      lat: json["lat"]?.toDouble(), // Ensure type safety for double
      lng: json["lng"]?.toDouble(), // Ensure type safety for double
      location: json["location"],
      reminderTo: json["reminder_to"],
    );
  }

  static List<LeadDetailsActiMeetingResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadDetailsActiMeetingResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
