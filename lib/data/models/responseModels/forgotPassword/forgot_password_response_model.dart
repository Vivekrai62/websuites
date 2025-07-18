class ForgotPasswordResponseModel {
  String? message;

  ForgotPasswordResponseModel({this.message});

  ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}