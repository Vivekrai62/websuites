class ProductsServicesResModel {
  List<Items>? items;
  Meta? meta;

  ProductsServicesResModel({this.items, this.meta});

  ProductsServicesResModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? serviceType;
  String? name;
  String? description;
  int? mrp;
  int? salePrice;
  String? recurringFrequency;
  Null customRecurringFrequency;
  bool? status;
  bool? isTaxable;
  String? createdAt;
  String? updatedAt;
  bool? projectActivationDisabled;
  ProductCategory? productCategory;
  Brand? brand;
  Gst? gst;
  Brand? division;
  List<ProductPrices>? productPrices;

  Items(
      {this.id,
      this.serviceType,
      this.name,
      this.description,
      this.mrp,
      this.salePrice,
      this.recurringFrequency,
      this.customRecurringFrequency,
      this.status,
      this.isTaxable,
      this.createdAt,
      this.updatedAt,
      this.projectActivationDisabled,
      this.productCategory,
      this.brand,
      this.gst,
      this.division,
      this.productPrices});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceType = json['service_type'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    recurringFrequency = json['recurring_frequency'];
    customRecurringFrequency = json['custom_recurring_frequency'];
    status = json['status'];
    isTaxable = json['is_taxable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    projectActivationDisabled = json['project_activation_disabled'];
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
    brand = json['brand'] != null ? Brand.fromJson(json['brand']) : null;
    gst = json['gst'] != null ? Gst.fromJson(json['gst']) : null;
    division =
        json['division'] != null ? Brand.fromJson(json['division']) : null;
    if (json['productPrices'] != null) {
      productPrices = <ProductPrices>[];
      json['productPrices'].forEach((v) {
        productPrices!.add(ProductPrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['service_type'] = serviceType;
    data['name'] = name;
    data['description'] = description;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['recurring_frequency'] = recurringFrequency;
    data['custom_recurring_frequency'] = customRecurringFrequency;
    data['status'] = status;
    data['is_taxable'] = isTaxable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['project_activation_disabled'] = projectActivationDisabled;
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    if (gst != null) {
      data['gst'] = gst!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (productPrices != null) {
      data['productPrices'] = productPrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductCategory {
  String? id;
  String? name;
  String? description;
  String? image;

  ProductCategory({this.id, this.name, this.description, this.image});

  ProductCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}

class Brand {
  String? id;
  String? name;

  Brand({this.id, this.name});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Gst {
  String? id;
  String? name;
  int? sgst;
  int? cgst;
  int? igst;

  Gst({this.id, this.name, this.sgst, this.cgst, this.igst});

  Gst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sgst = json['sgst'];
    cgst = json['cgst'];
    igst = json['igst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['sgst'] = sgst;
    data['cgst'] = cgst;
    data['igst'] = igst;
    return data;
  }
}

class ProductPrices {
  String? id;
  int? mrp;
  int? salePrice;
  Currency? currency;

  ProductPrices({this.id, this.mrp, this.salePrice, this.currency});

  ProductPrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class Currency {
  String? id;
  String? name;
  String? code;
  String? symbol;
  bool? isBaseCurrency;

  Currency({this.id, this.name, this.code, this.symbol, this.isBaseCurrency});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    symbol = json['symbol'];
    isBaseCurrency = json['is_base_currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    data['symbol'] = symbol;
    data['is_base_currency'] = isBaseCurrency;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}
