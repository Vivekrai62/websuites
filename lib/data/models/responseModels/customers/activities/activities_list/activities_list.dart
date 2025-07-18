class CustomerActivityListResponseModel {
  String? id;
  String? action;
  String? title;
  dynamic status;
  String? remark;
  String? companyName;
  String? meetingWith;
  String? meetingWithMobile;
  String? meetingWithEmail;
  bool? isVerifiedEmail;
  bool? isVerifiedMobile;
  String? createdAt;
  String? visitedWith;
  String? createdBy;
  String? department;
  double? lat;
  double? lng;
  String? location;
  String? reminder;

  CustomerActivityListResponseModel({
    this.id,
    this.action,
    this.title,
    this.status,
    this.remark,
    this.companyName,
    this.meetingWith,
    this.meetingWithMobile,
    this.meetingWithEmail,
    this.isVerifiedEmail,
    this.isVerifiedMobile,
    this.createdAt,
    this.visitedWith,
    this.createdBy,
    this.department,
    this.lat,
    this.lng,
    this.location,
    this.reminder,
  });

  CustomerActivityListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    action = json['action'];
    title = json['title'];
    status = json['status']; // Accept any type
    remark = json['remark'];
    companyName = json['company_name'];
    meetingWith = json['meeting_with'];
    meetingWithMobile = json['meeting_with_mobile'];
    meetingWithEmail = json['meeting_with_email'];
    isVerifiedEmail = json['is_verified_email'];
    isVerifiedMobile = json['is_verified_mobile'];
    createdAt = json['created_at'];
    visitedWith = json['visited_with'];
    createdBy = json['created_By'];
    department = json['department'];
    lat = json['lat']?.toDouble();
    lng = json['lng']?.toDouble();
    location = json['location'];
    reminder = json['reminder'];
  }

  String get statusDisplay {
    if (status == null) return 'Unknown';
    return status.toString();
  }

  int? get statusAsInt {
    if (status is int) return status as int;
    if (status is String) {
      return int.tryParse(status as String);
    }
    if (status is bool) {
      return (status as bool) ? 1 : 0;
    }
    return null;
  }

  bool get isActive {
    if (status is bool) return status as bool;
    if (status is int) return (status as int) > 0;
    if (status is String) return (status as String).toLowerCase() != 'inactive';
    return false;
  }

  static List<CustomerActivityListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerActivityListResponseModel.fromJson(json))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['action'] = action;
    data['title'] = title;
    data['status'] = status;
    data['remark'] = remark;
    data['company_name'] = companyName;
    data['meeting_with'] = meetingWith;
    data['meeting_with_mobile'] = meetingWithMobile;
    data['meeting_with_email'] = meetingWithEmail;
    data['is_verified_email'] = isVerifiedEmail;
    data['is_verified_mobile'] = isVerifiedMobile;
    data['created_at'] = createdAt;
    data['visited_with'] = visitedWith;
    data['created_By'] = createdBy;
    data['department'] = department;
    data['lat'] = lat;
    data['lng'] = lng;
    data['location'] = location;
    data['reminder'] = reminder;
    return data;
  }
}
