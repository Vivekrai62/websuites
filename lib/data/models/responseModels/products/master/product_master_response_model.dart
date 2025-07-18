class ProductMasterResponseModel {
  List<Items>? items;
  Meta? meta;

  ProductMasterResponseModel({
    this.items,
    this.meta,
  });

  ProductMasterResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null; // Corrected here
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList(); // Corrected here
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? incentive_type;
  int? minimum_sale_price;
  int? incentive;
  bool? is_sale;
  String? created_at;
  String? updated_at;
  Product? product;

  Items({
    this.id,
    this.incentive_type,
    this.minimum_sale_price,
    this.is_sale,
    this.created_at,
    this.updated_at,
    this.product,
    this.incentive,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    incentive = json['incentive'];
    minimum_sale_price = json['minimum_sale_price'];
    is_sale = json['is_sale'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    incentive_type = json['incentive_type'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['incentive'] = incentive;
    data['incentive_type'] = incentive_type;
    data['minimum_sale_price'] = minimum_sale_price;
    data['is_sale'] = is_sale;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? product_type;
  String? name;
  String? description;
  int? mrp;
  int? sale_price;
  int? quantity;
  int? duration;
  String? download_link;
  String? packing;
  bool? status;
  bool? is_taxable;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  String? zoho_item_id;
  bool? project_activation_disabled;

  Product({
    this.id,
    this.product_type,
    this.name,
    this.description,
    this.mrp,
    this.sale_price,
    this.quantity,
    this.duration,
    this.download_link,
    this.packing,
    this.status,
    this.is_taxable,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.project_activation_disabled,
    this.zoho_item_id,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_type = json['product_type'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    sale_price = json['sale_price'];
    quantity = json['quantity'];
    duration = json['duration'];
    download_link = json['download_link'];
    packing = json['packing'];
    status = json['status'];
    is_taxable = json['is_taxable'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
    project_activation_disabled = json['project_activation_disabled'];
    zoho_item_id = json['zoho_item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = product_type;
    data['name'] = name;
    data['description'] = description;
    data['mrp'] = mrp;
    data['sale_price'] = sale_price;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['download_link'] = download_link;
    data['packing'] = packing;
    data['status'] = status;
    data['is_taxable'] = is_taxable;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['deleted_at'] = deleted_at;
    data['project_activation_disabled'] = project_activation_disabled;
    data['zoho_item_id'] = zoho_item_id;
    return data;
  }
}

class Meta {
  int? totalItems;
  int? itemCount;
  int? itemsPerPage;
  int? totalPages;
  int? currentPage;

  Meta({
    this.totalItems,
    this.itemCount,
    this.itemsPerPage,
    this.totalPages,
    this.currentPage,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    totalItems = json['totalItems'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    itemCount = json['itemCount'];
    currentPage = json['currentPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalItems'] = totalItems;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['itemCount'] = itemCount;
    data['currentPage'] = currentPage; // Added missing semicolon here
    return data;
  }
}