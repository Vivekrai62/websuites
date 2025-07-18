class SalesAddProductRequestModel {
  final String product;
  final int quantity;
  final String targetIncentive;

  SalesAddProductRequestModel({
    required this.product,
    required this.quantity,
    required this.targetIncentive,
  });

  // Method to convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'product': product,
      'quantity': quantity,
      'target_incentive': targetIncentive,
    };
  }

  // Method to update the model from a JSON map (optional)
  factory SalesAddProductRequestModel.fromJson(Map<String, dynamic> json) {
    return SalesAddProductRequestModel(
      product: json['product'],
      quantity: json['quantity'],
      targetIncentive: json['target_incentive'],
    );
  }
}
