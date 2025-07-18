class MasterAddProductRequestModel {
  final int incentive;
  final String incentiveType;
  final bool isSale;
  final int minimumSalePrice;
  final String product;

  MasterAddProductRequestModel({
    required this.incentive,
    required this.incentiveType,
    required this.isSale,
    required this.minimumSalePrice,
    required this.product,
  });

  Map<String, dynamic> toJson() {
    return {
      'incentive': incentive,
      'incentive_type': incentiveType,
      'is_sale': isSale,
      'minimum_sale_price': minimumSalePrice,
      'product': product,
    };
  }
}
