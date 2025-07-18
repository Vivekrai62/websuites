class UserStatusResponseModel {
  String? status; // Assuming status is a String, adjust as necessary
  String? message; // Example additional field

  UserStatusResponseModel({this.status, this.message});

  // Factory method to update an instance from JSON
  factory UserStatusResponseModel.fromJson(Map<String, dynamic> json) {
    return UserStatusResponseModel(
      status: json['status'] as String?,
      message: json['message'] as String?, // Adjust based on your API response
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message, // Adjust based on your API response
    };
  }
}