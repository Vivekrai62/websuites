class LeadDetailProjectionRequestModel {
  String id;
  String projectionDate;
  List<ProjectionProduct> projectionProduct;
  String type;

  LeadDetailProjectionRequestModel({
    required this.id,
    required this.projectionDate,
    required this.projectionProduct,
    required this.type,
  });

  // Convert a ProjectionRequest object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'projection_date': projectionDate,
      'projection_product':
          projectionProduct.map((product) => product.toJson()).toList(),
      'type': type,
    };
  }
}

// Model for individual product category and amount
class ProjectionProduct {
  String productCategory;
  double amount;

  ProjectionProduct({
    required this.productCategory,
    required this.amount,
  });

  // Convert a ProjectionProduct object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'product_category': productCategory,
      'amount': amount,
    };
  }
}
