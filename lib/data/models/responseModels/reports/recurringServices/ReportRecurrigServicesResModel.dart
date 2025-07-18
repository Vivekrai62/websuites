class ReportRecurringServicesResModel {
  bool? success;
  int? statusCode;
  String? timestamp;
  String? path;
  String? message;

  ReportRecurringServicesResModel({
    this.success,
    this.statusCode,
    this.timestamp,
    this.path,
    this.message,
  });

  ReportRecurringServicesResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['statusCode'] = statusCode;
    data['timestamp'] = timestamp;
    data['path'] = path;
    data['message'] = message;
    return data;
  }
}
