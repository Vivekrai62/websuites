class CustomerSearchAssignRequestModel {
  String? data; // For passing "" parameter
  String? userId; // For passing userId

  CustomerSearchAssignRequestModel ({
    this.data,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'userId': userId,
    };
  }
}
