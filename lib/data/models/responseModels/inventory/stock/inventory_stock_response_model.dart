class InventoryStocksResponseModel {
  Meta? meta;
  List<Items>? items;

  InventoryStocksResponseModel({this.meta, this.items});

  InventoryStocksResponseModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? totalPages;
  int? totalItems;
  int? itemCount;

  Meta({this.totalPages, this.totalItems, this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}

class Items {
  String? id;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;
  List<InventoryStocks>? inventoryStocks;

  Items(
      {this.id,
        this.quantity,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.inventoryStocks});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    if (json['inventoryStocks'] != null) {
      inventoryStocks = <InventoryStocks>[];
      json['inventoryStocks'].forEach((v) {
        inventoryStocks!.add(InventoryStocks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (inventoryStocks != null) {
      data['inventoryStocks'] =
          inventoryStocks!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String? id;
  String? productType;
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
  String? zohoItemId;
  bool? projectActivationDisabled;

  Product(
      {this.id,
        this.productType,
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
        this.zohoItemId,
        this.projectActivationDisabled});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
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
    zohoItemId = json['zoho_item_id'];
    projectActivationDisabled = json['project_activation_disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
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
    data['zoho_item_id'] = zohoItemId;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}

class InventoryStocks {
  String? id;
  int? quantity;
  int? price;
  String? batch;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  InventoryTransaction? inventoryTransaction;
  Manufacturer? manufacturer;

  InventoryStocks(
      {this.id,
        this.quantity,
        this.price,
        this.batch,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
        this.inventoryTransaction,
        this.manufacturer});

  InventoryStocks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    batch = json['batch'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    inventoryTransaction = json['inventoryTransaction'] != null
        ? InventoryTransaction.fromJson(json['inventoryTransaction'])
        : null;
    manufacturer = json['manufacturer'] != null
        ? Manufacturer.fromJson(json['manufacturer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    data['batch'] = batch;
    data['expiry_date'] = expiryDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (inventoryTransaction != null) {
      data['inventoryTransaction'] = inventoryTransaction!.toJson();
    }
    if (manufacturer != null) {
      data['manufacturer'] = manufacturer!.toJson();
    }
    return data;
  }
}

class InventoryTransaction {
  String? id;
  int? quantity;
  int? price;
  String? batch;
  bool? cr;
  bool? dr;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;

  InventoryTransaction(
      {this.id,
        this.quantity,
        this.price,
        this.batch,
        this.cr,
        this.dr,
        this.expiryDate,
        this.createdAt,
        this.updatedAt});

  InventoryTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    batch = json['batch'];
    cr = json['cr'];
    dr = json['dr'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['price'] = price;
    data['batch'] = batch;
    data['cr'] = cr;
    data['dr'] = dr;
    data['expiry_date'] = expiryDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Manufacturer {
  String? id;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? createdAt;
  String? updatedAt;

  Manufacturer(
      {this.id,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.createdAt,
        this.updatedAt});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    data['email'] = email;
    data['address'] = address;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}