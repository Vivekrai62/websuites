class LeadDetailActionServiceResModel {
  bool? success;
  int? statusCode;
  String? timestamp;
  String? path;
  String? message;

  LeadDetailActionServiceResModel(
      {this.success, this.statusCode, this.timestamp, this.path, this.message});

  LeadDetailActionServiceResModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['timestamp'] = this.timestamp;
    data['path'] = this.path;
    data['message'] = this.message;
    return data;
  }
}
