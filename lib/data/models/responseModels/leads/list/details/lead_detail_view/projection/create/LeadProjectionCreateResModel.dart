class LeadProjectionCreateResModel {
  int? statusCode;
  String? message;

  LeadProjectionCreateResModel({this.statusCode, this.message});

  LeadProjectionCreateResModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
