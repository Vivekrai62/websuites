class AddProductIncentiveRequestModel {
  final int incentive;
  final String incentiveType;
  final bool isSale;
  final int minimumSalePrice;
  final String product;
  final String targetIncentive;

  AddProductIncentiveRequestModel({
    required this.incentive,
    required this.incentiveType,
    required this.isSale,
    required this.minimumSalePrice,
    required this.product,
    required this.targetIncentive,
  });

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      "incentive": incentive,
      "incentive_type": incentiveType,
      "is_sale": isSale,
      "minimum_sale_price": minimumSalePrice,
      "product": product,
      "target_incentive": targetIncentive,
    };
  }

  // Create a RequestModel from JSON
  factory AddProductIncentiveRequestModel.fromJson(Map<String, dynamic> json) {
    return AddProductIncentiveRequestModel(
      incentive: json["incentive"],
      incentiveType: json["incentive_type"],
      isSale: json["is_sale"],
      minimumSalePrice: json["minimum_sale_price"],
      product: json["product"],
      targetIncentive: json["target_incentive"],
    );
  }
}
