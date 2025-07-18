class AddLeaveTypeResponseModel {
  int? statusCode;
  String? timestamp;
  String? path;
  String? message;

  AddLeaveTypeResponseModel(
      {this.statusCode, this.timestamp, this.path, this.message});

  AddLeaveTypeResponseModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    timestamp = json['timestamp'];
    path = json['path'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['timestamp'] = timestamp;
    data['path'] = path;
    data['message'] = message;
    return data;
  }
}
