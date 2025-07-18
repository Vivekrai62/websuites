class LeadSettingDeadReasonListDelete {
  final String? message;

  LeadSettingDeadReasonListDelete({this.message});

  factory LeadSettingDeadReasonListDelete.fromJson(Map<String, dynamic> json) {
    return LeadSettingDeadReasonListDelete(
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
