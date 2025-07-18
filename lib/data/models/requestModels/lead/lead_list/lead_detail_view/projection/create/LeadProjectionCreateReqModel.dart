class LeadProjectionCreateReqModel {
  String id;
  String type;
  List<ProjectionProduct> projectionProduct;

  LeadProjectionCreateReqModel({
    required this.id,
    required this.type,
    required this.projectionProduct,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'projection_product': projectionProduct.map((product) => product.toJson()).toList(),
    };
  }
}

class ProjectionProduct {
  String productCategory;
  String product;
  double amount;
  String projectionDate;

  ProjectionProduct({
    required this.productCategory,
    required this.product,
    required this.amount,
    required this.projectionDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_category': productCategory,
      'product': product,
      'amount': amount,
      'projection_date': projectionDate,
    };
  }
}