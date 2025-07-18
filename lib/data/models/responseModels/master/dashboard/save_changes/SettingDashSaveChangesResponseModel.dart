class SettingDashSaveChangesMessageResponseModel {
  final String? message;

  SettingDashSaveChangesMessageResponseModel({this.message});

  factory SettingDashSaveChangesMessageResponseModel.fromJson(Map<String, dynamic> json) {
    return SettingDashSaveChangesMessageResponseModel(
      message: json['message'] as String?,
    );
  }
}