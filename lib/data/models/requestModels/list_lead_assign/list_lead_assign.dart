class LeadAssignRequestModel {
  String? data; // For passing "" parameter
  String? userId; // For passing userId
  LeadAssignRequestModel({
    this.data,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'search': data,
      'userId': userId,
    };
  }
}
