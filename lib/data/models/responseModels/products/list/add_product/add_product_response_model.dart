class AddProductResponseModel {
  String? productType;
  String? name;
  String? description;
  int? quantity;
  int? duration;
  String? downloadLink;
  String? packing;
  bool? status;
  bool? isTaxable;
  ProductCategory? productCategory;
  Brand? brand;
  Brand? division;
  dynamic gst;
  dynamic serviceType;
  dynamic zohoItemId;
  String? id;
  int? mrp;
  int? salePrice;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  bool? distributorshipOnly;
  bool? projectActivationDisabled;

  AddProductResponseModel(
      {this.productType,
      this.name,
      this.description,
      this.quantity,
      this.duration,
      this.downloadLink,
      this.packing,
      this.status,
      this.isTaxable,
      this.productCategory,
      this.brand,
      this.division,
      this.gst,
      this.serviceType,
      this.zohoItemId,
      this.id,
      this.mrp,
      this.salePrice,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.distributorshipOnly,
      this.projectActivationDisabled});

  AddProductResponseModel.fromJson(Map<String, dynamic> json) {
    productType = json['product_type'];
    name = json['name'];
    description = json['description'];
    quantity = json['quantity'];
    duration = json['duration'];
    downloadLink = json['download_link'];
    packing = json['packing'];
    status = json['status'];
    isTaxable = json['is_taxable'];
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    division =
        json['division'] != null ? Brand.fromJson(json['division']) : null;
    gst = json['gst'];
    serviceType = json['service_type'];
    zohoItemId = json['zoho_item_id'];
    id = json['id'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    distributorshipOnly = json['distributorshipOnly'];
    projectActivationDisabled = json['project_activation_disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_type'] = productType;
    data['name'] = name;
    data['description'] = description;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['download_link'] = downloadLink;
    data['packing'] = packing;
    data['status'] = status;
    data['is_taxable'] = isTaxable;
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    data['gst'] = gst;
    data['service_type'] = serviceType;
    data['zoho_item_id'] = zohoItemId;
    data['id'] = id;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['distributorshipOnly'] = distributorshipOnly;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}

class ProductCategory {
  String? id;
  String? name;
  String? description;
  dynamic image;
  String? createdAt;
  String? updatedAt;

  ProductCategory(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Brand {
  String? id;
  Brand({this.id});
  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
