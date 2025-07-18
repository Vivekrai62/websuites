class CustomerOrderlessServiceQuitRequestModel {
  final String reason;
  CustomerOrderlessServiceQuitRequestModel({
    required this.reason,
  });

  // Convert the model to JSON to send in a request
  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
    };
  }


  factory CustomerOrderlessServiceQuitRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerOrderlessServiceQuitRequestModel(
      reason: json['reason'],
    );
  }
}
