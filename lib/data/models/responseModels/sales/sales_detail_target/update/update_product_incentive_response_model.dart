class UpdateProductIncentiveResponseModel {
  String? id;
  String? incentiveType;
  int? minimumSalePrice;
  int? incentive;
  bool? isSale;
  String? createdAt;
  String? updatedAt;
  Product? product;

  UpdateProductIncentiveResponseModel({
    this.id,
    this.incentiveType,
    this.minimumSalePrice,
    this.incentive,
    this.isSale,
    this.createdAt,
    this.updatedAt,
    this.product,
  });

  UpdateProductIncentiveResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    incentiveType = json['incentive_type'] as String?;
    minimumSalePrice = json['minimum_sale_price'] as int?;
    incentive = json['incentive'] as int?;
    isSale = json['is_sale'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    product = json['product'] != null
        ? Product.fromJson(json['product'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['incentive_type'] = incentiveType;
    data['minimum_sale_price'] = minimumSalePrice;
    data['incentive'] = incentive;
    data['is_sale'] = isSale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? productType;
  String? serviceType;
  String? name;
  String? description;
  int? mrp;
  int? salePrice;
  int? quantity;
  int? duration;
  String? downloadLink;
  String? packing;
  bool? status;
  bool? isTaxable;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  bool? distributorshipOnly;
  String? zohoItemId;
  bool? projectActivationDisabled;

  Product({
    this.id,
    this.productType,
    this.serviceType,
    this.name,
    this.description,
    this.mrp,
    this.salePrice,
    this.quantity,
    this.duration,
    this.downloadLink,
    this.packing,
    this.status,
    this.isTaxable,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.distributorshipOnly,
    this.zohoItemId,
    this.projectActivationDisabled,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    productType = json['product_type'] as String?;
    serviceType = json['service_type'] as String?;
    name = json['name'] as String?;
    description = json['description'] as String?;
    mrp = json['mrp'] as int?;
    salePrice = json['sale_price'] as int?;
    quantity = json['quantity'] as int?;
    duration = json['duration'] as int?;
    downloadLink = json['download_link'] as String?;
    packing = json['packing'] as String?;
    status = json['status'] as bool?;
    isTaxable = json['is_taxable'] as bool?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    deletedAt = json['deleted_at'] as String?;
    distributorshipOnly = json['distributorshipOnly'] as bool?;
    zohoItemId = json['zoho_item_id'] as String?;
    projectActivationDisabled = json['project_activation_disabled'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
    data['service_type'] = serviceType;
    data['name'] = name;
    data['description'] = description;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['download_link'] = downloadLink;
    data['packing'] = packing;
    data['status'] = status;
    data['is_taxable'] = isTaxable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['distributorshipOnly'] = distributorshipOnly;
    data['zoho_item_id'] = zohoItemId;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}
