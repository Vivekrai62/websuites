class CallDetailsResModel {
  final String status;

  CallDetailsResModel({required this.status});

  // Factory method to create instance from JSON
  factory CallDetailsResModel.fromJson(Map<String, dynamic> json) {
    return CallDetailsResModel(
      status: json['status'] as String,
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }

  // Optional: Enum for valid statuses
  static const List<String> validStatuses = [
    'Answered',
    'Not Answered',
    'Rejected',
    'Not Reachable',
    'Wrong Number',
    'Busy',
    'Switched Off',
  ];

  // Optional: Validation method
  bool isValidStatus() {
    return validStatuses.contains(status);
  }
}