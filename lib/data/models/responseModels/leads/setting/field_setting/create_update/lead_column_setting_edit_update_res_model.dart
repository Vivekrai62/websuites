class LeadFieldSettingEditUpdateResModel {
  final String message;

  LeadFieldSettingEditUpdateResModel({required this.message});

  factory LeadFieldSettingEditUpdateResModel.fromJson(Map<String, dynamic> json) {
    return LeadFieldSettingEditUpdateResModel(
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }

  @override
  String toString() {
    return 'LeadFieldSettingEditUpdateResModel(message: $message)';
  }
}
