class LeadDetailUpdateStatusResponseModel {
  String? message;

  LeadDetailUpdateStatusResponseModel({this.message});

  LeadDetailUpdateStatusResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
