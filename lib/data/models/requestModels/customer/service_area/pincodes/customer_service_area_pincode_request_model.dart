class CustomerServiceAreaPincodeRequestModel {
  final String districtId;
  final String divisionId;

  CustomerServiceAreaPincodeRequestModel({
    required this.districtId,
    required this.divisionId,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'districtId': districtId,
      'divisionId': divisionId,
    };
  }

  // Factory method to update model from JSON
  factory CustomerServiceAreaPincodeRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerServiceAreaPincodeRequestModel(
      districtId: json['districtId'],
      divisionId: json['divisionId'],
    );
  }
}
