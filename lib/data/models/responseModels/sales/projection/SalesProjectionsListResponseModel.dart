class SalesProjectionsListResponseModel {
  SalesProjectionsListResponseModel({
    required this.id,
    required this.amount,
    required this.isClosed,
    required this.status,
    required this.projectionDate,
    required this.createdAt,
    required this.updatedAt,
    required this.productCategory,
    required this.product,
    required this.lead,
    required this.customer,
    required this.createdBy,
  });

  final String? id;
  final int? amount;
  final bool? isClosed;
  final String? status;
  final DateTime? projectionDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductCategory? productCategory;
  final Product? product;
  final CreatedBy? lead;
  final CreatedBy? customer;
  final CreatedBy? createdBy;

  factory SalesProjectionsListResponseModel.fromJson(Map<String, dynamic> json){
    return SalesProjectionsListResponseModel(
      id: json["id"],
      amount: json["amount"],
      isClosed: json["isClosed"],
      status: json["status"],
      projectionDate: DateTime.tryParse(json["projection_date"] ?? ""),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      productCategory: json["product_category"] == null ? null : ProductCategory.fromJson(json["product_category"]),
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
      lead: json["lead"] == null ? null : CreatedBy.fromJson(json["lead"]),
      customer: json["customer"] == null ? null : CreatedBy.fromJson(json["customer"]),
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.organization,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? organization;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      organization: json["organization"],
    );
  }

}

class Product {
  Product({
    required this.id,
    required this.name,
    required this.mrp,
    required this.salePrice,
  });

  final String? id;
  final String? name;
  final int? mrp;
  final int? salePrice;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      name: json["name"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
    );
  }

}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory ProductCategory.fromJson(Map<String, dynamic> json){
    return ProductCategory(
      id: json["id"],
      name: json["name"],
    );
  }

}
