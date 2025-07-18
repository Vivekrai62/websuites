class MasterAddProductResponseModel {
  Product? product;
  int? incentive;
  String? incentiveType;
  bool? isSale;
  int? minimumSalePrice;
  String? id;
  String? createdAt;
  String? updatedAt;

  MasterAddProductResponseModel(
      {this.product,
      this.incentive,
      this.incentiveType,
      this.isSale,
      this.minimumSalePrice,
      this.id,
      this.createdAt,
      this.updatedAt});

  MasterAddProductResponseModel.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    incentive = json['incentive'];
    incentiveType = json['incentive_type'];
    isSale = json['is_sale'];
    minimumSalePrice = json['minimum_sale_price'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['incentive'] = incentive;
    data['incentive_type'] = incentiveType;
    data['is_sale'] = isSale;
    data['minimum_sale_price'] = minimumSalePrice;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Product {
  String? id;
  String? productType;
  Null serviceType;
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
  Null deletedAt;
  bool? distributorshipOnly;
  Null zohoItemId;
  bool? projectActivationDisabled;

  Product(
      {this.id,
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
      this.projectActivationDisabled});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    serviceType = json['service_type'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    quantity = json['quantity'];
    duration = json['duration'];
    downloadLink = json['download_link'];
    packing = json['packing'];
    status = json['status'];
    isTaxable = json['is_taxable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    distributorshipOnly = json['distributorshipOnly'];
    zohoItemId = json['zoho_item_id'];
    projectActivationDisabled = json['project_activation_disabled'];
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
