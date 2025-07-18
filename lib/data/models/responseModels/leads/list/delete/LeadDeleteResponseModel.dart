class LeadDeleteResponseModel {
  final String message;
  final bool success;

  LeadDeleteResponseModel({
    required this.message,
    required this.success,
  });

  factory LeadDeleteResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadDeleteResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
    };
  }
}
