// RoleCheckEditResponseModel.dart

class RoleCheckEditResponseModel {
  final bool success;
  final String? message;

  RoleCheckEditResponseModel({required this.success, this.message});

  // Convert JSON to the response model
  factory RoleCheckEditResponseModel.fromJson(Map<String, dynamic> json) {
    return RoleCheckEditResponseModel(
      success: json['success'] ?? false,  // Success flag (assumed to be a boolean)
      message: json['message'],           // Optional message
    );
  }

  // Convert response model to JSON format (if required)
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}
