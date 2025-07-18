class UserListStatusRequestModel {
  String id;
  String status;  // Changed from bool to String

  UserListStatusRequestModel({
    required this.id,
    required bool statusBool,  // Accept bool but convert to String
  }) : status = statusBool ? "true" : "false";  // Convert bool to String

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,  // Will be "true" or "false" as String
    };
  }
}