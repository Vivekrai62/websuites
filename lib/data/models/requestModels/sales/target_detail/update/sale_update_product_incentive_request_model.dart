class UpdateProductIncentiveRequestModel {
  final int incentive;
  final String incentiveType;
  final bool isSale;
  final int minimumSalePrice;
  final String product;
  final String targetIncentive;

  UpdateProductIncentiveRequestModel({
    required this.incentive,
    required this.incentiveType,
    required this.isSale,
    required this.minimumSalePrice,
    required this.product,
    required this.targetIncentive,
  });

  // Method to convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'incentive': incentive,
      'incentive_type': incentiveType,
      'is_sale': isSale,
      'minimum_sale_price': minimumSalePrice,
      'product': product,
      'target_incentive': targetIncentive,
    };
  }

  // Method to update the model from a JSON map (optional)
  factory UpdateProductIncentiveRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProductIncentiveRequestModel(
      incentive: json['incentive'],
      incentiveType: json['incentive_type'],
      isSale: json['is_sale'],
      minimumSalePrice: json['minimum_sale_price'],
      product: json['product'],
      targetIncentive: json['target_incentive'],
    );
  }
}
