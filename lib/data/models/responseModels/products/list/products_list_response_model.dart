class ProductsListResponseModel {
  ProductsListResponseModel({
    required this.items,
    required this.meta,
  });

  final List<Item> items;
  final Meta? meta;

  factory ProductsListResponseModel.fromJson(Map<String, dynamic> json){
    return ProductsListResponseModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class Item {
  Item({
    required this.id,
    required this.productType,
    required this.serviceType,
    required this.name,
    required this.description,
    required this.mrp,
    required this.salePrice,
    required this.quantity,
    required this.duration,
    required this.downloadLink,
    required this.packing,
    required this.status,
    required this.isTaxable,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.distributorshipOnly,
    required this.zohoItemId,
    required this.projectActivationDisabled,
    required this.productCategory,
    required this.brand,
    required this.gst,
    required this.division,
    required this.productPrices,
    required this.inventory,
  });

  final String? id;
  final String? productType;
  final dynamic serviceType;
  final String? name;
  final String? description;
  final int? mrp;
  final int? salePrice;
  final int? quantity;
  final int? duration;
  final String? downloadLink;
  final String? packing;
  final bool? status;
  final bool? isTaxable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? distributorshipOnly;
  final dynamic zohoItemId;
  final bool? projectActivationDisabled;
  final Brand? productCategory;
  final Brand? brand;
  final Gst? gst;
  final Division? division;
  final List<ProductPrice> productPrices;
  final Inventory? inventory;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      productType: json["product_type"],
      serviceType: json["service_type"],
      name: json["name"],
      description: json["description"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      quantity: json["quantity"],
      duration: json["duration"],
      downloadLink: json["download_link"],
      packing: json["packing"],
      status: json["status"],
      isTaxable: json["is_taxable"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      distributorshipOnly: json["distributorshipOnly"],
      zohoItemId: json["zoho_item_id"],
      projectActivationDisabled: json["project_activation_disabled"],
      productCategory: json["product_category"] == null ? null : Brand.fromJson(json["product_category"]),
      brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      gst: json["gst"] == null ? null : Gst.fromJson(json["gst"]),
      division: json["division"] == null ? null : Division.fromJson(json["division"]),
      productPrices: json["productPrices"] == null ? [] : List<ProductPrice>.from(json["productPrices"]!.map((x) => ProductPrice.fromJson(x))),
      inventory: json["inventory"] == null ? null : Inventory.fromJson(json["inventory"]),
    );
  }

}

class Brand {
  Brand({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.image,
  });

  final String? id;
  final String? name;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic image;

  factory Brand.fromJson(Map<String, dynamic> json){
    return Brand(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      image: json["image"],
    );
  }

}

class Division {
  Division({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Division.fromJson(Map<String, dynamic> json){
    return Division(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Gst {
  Gst({
    required this.id,
    required this.name,
    required this.sgst,
    required this.cgst,
    required this.igst,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final int? sgst;
  final int? cgst;
  final int? igst;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Gst.fromJson(Map<String, dynamic> json){
    return Gst(
      id: json["id"],
      name: json["name"],
      sgst: json["sgst"],
      cgst: json["cgst"],
      igst: json["igst"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Inventory {
  Inventory({
    required this.id,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.inventoryStocks,
  });

  final String? id;
  final int? quantity;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<dynamic> inventoryStocks;

  factory Inventory.fromJson(Map<String, dynamic> json){
    return Inventory(
      id: json["id"],
      quantity: json["quantity"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      inventoryStocks: json["inventoryStocks"] == null ? [] : List<dynamic>.from(json["inventoryStocks"]!.map((x) => x)),
    );
  }

}

class ProductPrice {
  ProductPrice({
    required this.id,
    required this.mrp,
    required this.salePrice,
    required this.createdAt,
    required this.updatedAt,
    required this.currency,
  });

  final String? id;
  final int? mrp;
  final int? salePrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Currency? currency;

  factory ProductPrice.fromJson(Map<String, dynamic> json){
    return ProductPrice(
      id: json["id"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
    );
  }

}

class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? symbol;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Currency.fromJson(Map<String, dynamic> json){
    return Currency(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      symbol: json["symbol"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

}
