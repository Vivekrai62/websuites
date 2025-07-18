class CustomerServiceAreaProductRequestModel {
  final bool completeDistrict;
  final String districtId;
  final String divisionId;
  final String pincodeId;

  CustomerServiceAreaProductRequestModel({
    required this.completeDistrict,
    required this.districtId,
    required this.divisionId,
    required this.pincodeId,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'completeDistrict': completeDistrict,
      'districtId': districtId,
      'divisionId': divisionId,
      'pincodeId': pincodeId,
    };
  }

  factory CustomerServiceAreaProductRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerServiceAreaProductRequestModel(
      completeDistrict: json['completeDistrict'],
      districtId: json['districtId'],
      divisionId: json['divisionId'],
      pincodeId: json['pincodeId'],
    );
  }
}
