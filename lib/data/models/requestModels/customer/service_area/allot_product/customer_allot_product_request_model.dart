class CustomerAllotProductRequestModel {
  String customerId;
  String companyId;
  String districtId;
  bool completeDistrict;
  String pincodeId;
  String divisionId;
  bool completeDivision;
  List<String> productIds;

  CustomerAllotProductRequestModel({
    required this.customerId,
    required this.companyId,
    required this.districtId,
    required this.completeDistrict,
    required this.pincodeId,
    required this.divisionId,
    required this.completeDivision,
    required this.productIds,
  });

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'customerId': customerId,
      'companyId': companyId,
      'districtId': districtId,
      'completeDistrict': completeDistrict,
      'pincodeId': pincodeId,
      'divisionId': divisionId,
      'completeDivision': completeDivision,
      'productIds': productIds,
    };
  }

  // Optional: Convert JSON response to model
  factory CustomerAllotProductRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerAllotProductRequestModel(
      customerId: json['customerId'],
      companyId: json['companyId'],
      districtId: json['districtId'],
      completeDistrict: json['completeDistrict'],
      pincodeId: json['pincodeId'],
      divisionId: json['divisionId'],
      completeDivision: json['completeDivision'],
      productIds: List<String>.from(json['productIds']),
    );
  }
}
