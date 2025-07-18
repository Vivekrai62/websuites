class LeadDetailsActivitiesAllResModel {
  String? id;
  String? action;
  String? title;
  dynamic status; // Can be bool or String based on your API response
  String? remark;
  String? createdAt;
  String? reminder;
  String? meetingWith;
  String? meetingWithMobile;
  String? meetingWithEmail;
  bool? isVerifiedEmail;
  bool? isVerifiedMobile;
  String? visitedWith;
  String? createdBy;
  String? department;
  double? lat;
  double? lng;
  String? location;
  String? companyName;

  LeadDetailsActivitiesAllResModel({
    this.id,
    this.action,
    this.title,
    this.status,
    this.remark,
    this.createdAt,
    this.reminder,
    this.meetingWith,
    this.meetingWithMobile,
    this.meetingWithEmail,
    this.isVerifiedEmail,
    this.isVerifiedMobile,
    this.visitedWith,
    this.createdBy,
    this.department,
    this.lat,
    this.lng,
    this.location,
    this.companyName,
  });

  LeadDetailsActivitiesAllResModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    action = json['action'];
    title = json['title'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    reminder = json['reminder'];
    meetingWith = json['meeting_with'];
    meetingWithMobile = json['meeting_with_mobile'];
    meetingWithEmail = json['meeting_with_email'];
    isVerifiedEmail = json['is_verified_email'];
    isVerifiedMobile = json['is_verified_mobile'];
    visitedWith = json['visited_with'];
    createdBy = json['created_By'];
    department = json['department'];
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
    location = json['location'];
    companyName = json['company_name'];
  }

  // Static method to convert List of JSON to List of models
  static List<LeadDetailsActivitiesAllResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadDetailsActivitiesAllResModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['action'] = action;
    data['title'] = title;
    data['status'] = status;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    data['reminder'] = reminder;
    data['meeting_with'] = meetingWith;
    data['meeting_with_mobile'] = meetingWithMobile;
    data['meeting_with_email'] = meetingWithEmail;
    data['is_verified_email'] = isVerifiedEmail;
    data['is_verified_mobile'] = isVerifiedMobile;
    data['visited_with'] = visitedWith;
    data['created_By'] = createdBy;
    data['department'] = department;
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
    data['company_name'] = companyName;
    return data;
  }
}