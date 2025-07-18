class CustomerOrderProductSearchResponseModel {
  String? id;
  String? productType;
  String? serviceType; // Changed from Null to String?
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
  String? deletedAt; // Changed from Null to String?
  bool? distributorshipOnly;
  String? zohoItemId; // Changed from Null to String?
  bool? projectActivationDisabled;
  ProductCategory? productCategory;
  Gst? gst;

  CustomerOrderProductSearchResponseModel({
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
    this.productCategory,
    this.gst,
  });

  CustomerOrderProductSearchResponseModel.fromJson(Map<String, dynamic> json) {
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
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
    gst = json['gst'] != null ? Gst.fromJson(json['gst']) : null;
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
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    if (gst != null) {
      data['gst'] = gst!.toJson();
    }
    return data;
  }

  static List<CustomerOrderProductSearchResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerOrderProductSearchResponseModel.fromJson(json)).toList();
  }
}

class ProductCategory {
  String? id;
  String? name;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProductCategory({
    this.id,
    this.name,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Gst {
  String? id;
  String? name;
  int? sgst;
  int? cgst;
  int? igst;
  int? status;
  String? createdAt;
  String? updatedAt;

  Gst({
    this.id,
    this.name,
    this.sgst,
    this.cgst,
    this.igst,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Gst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sgst': sgst,
      'cgst': cgst,
      'igst': igst,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
