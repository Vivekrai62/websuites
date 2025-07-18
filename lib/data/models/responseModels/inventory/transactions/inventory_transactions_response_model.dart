class InventoryTransactionsResponseModel {
  Meta? meta;
  List<Items>? items;

  InventoryTransactionsResponseModel({this.meta, this.items});

  InventoryTransactionsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? price;
  String? batch;
  bool? cr;
  bool? dr;
  String? expiryDate;
  String? createdAt;
  String? updatedAt;
  Product? product;
  Manufacturer? manufacturer;
  String? order;
  InventoryReplenishment? inventoryReplenishment;
  CreatedBy? createdBy;

  Items(
      {this.id,
        this.quantity,
        this.price,
        this.batch,
        this.cr,
        this.dr,
        this.expiryDate,
        this.createdAt,
        this.updatedAt,
        this.product,
        this.manufacturer,
        this.order,
        this.inventoryReplenishment,
        this.createdBy});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    batch = json['batch'];
    cr = json['cr'];
    dr = json['dr'];
    expiryDate = json['expiry_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    manufacturer = json['manufacturer'] != null
        ? Manufacturer.fromJson(json['manufacturer'])
        : null;
    order = json['order'];
    inventoryReplenishment = json['inventoryReplenishment'] != null
        ? InventoryReplenishment.fromJson(json['inventoryReplenishment'])
        : null;
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
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
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (manufacturer != null) {
      data['manufacturer'] = manufacturer!.toJson();
    }
    data['order'] = order;
    if (inventoryReplenishment != null) {
      data['inventoryReplenishment'] = inventoryReplenishment!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
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

class InventoryReplenishment {
  String? id;
  String? createdAt;
  String? updatedAt;

  InventoryReplenishment({this.id, this.createdAt, this.updatedAt});

  InventoryReplenishment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;

  CreatedBy({this.id, this.firstName, this.lastName, this.email, this.mobile});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    return data;
  }
}