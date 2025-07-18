class LeadColumnSettingEditUpdateResModel {
  final String message;

  LeadColumnSettingEditUpdateResModel({required this.message});

  factory LeadColumnSettingEditUpdateResModel.fromJson(Map<String, dynamic> json) {
    return LeadColumnSettingEditUpdateResModel(
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
    return 'LeadColumnSettingEditUpdateResModel(message: $message)';
  }
}
