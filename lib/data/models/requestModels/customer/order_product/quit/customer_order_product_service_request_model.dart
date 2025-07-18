class CustomerOrderProductQuitRequestModel {
  final String reason;

  CustomerOrderProductQuitRequestModel({required this.reason});

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "reason": reason,
    };
  }
}
