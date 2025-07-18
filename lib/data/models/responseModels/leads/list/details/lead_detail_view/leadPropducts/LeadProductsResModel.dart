class LeadProductsRes {
  LeadProductsRes({
    required this.items,
    required this.meta,
  });

  final List<Item> items;
  final Meta meta;

  factory LeadProductsRes.fromJson(Map<String, dynamic> json) {
    return LeadProductsRes(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      meta: Meta.fromJson(json["meta"] ?? (throw FormatException("Missing meta"))),
    );
  }

  static List<LeadProductsRes> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadProductsRes.fromJson(json as Map<String, dynamic>)).toList();
  }
}

// Rest of the classes (Item, Brand, Division, Gst, ProductCategory, Meta) remain the same as in the previous response.

class Item {
  Item({
    required this.id,
    required this.productType,
    required this.serviceType,
    required this.name,
    required this.description,
    required this.composition,
    required this.mrp,
    required this.salePrice,
    required this.recurringFrequency,
    required this.customRecurringFrequency,
    required this.packing,
    required this.status,
    required this.isTaxable,
    required this.createdAt,
    required this.updatedAt,
    required this.projectActivationDisabled,
    required this.productCategory,
    required this.brand,
    required this.gst,
    required this.division,
  });

  final String id;
  final String productType;
  final String? serviceType;
  final String name;
  final String? description;
  final String? composition;
  final int mrp;
  final int salePrice;
  final String? recurringFrequency;
  final String? customRecurringFrequency;
  final String? packing;
  final bool status;
  final bool isTaxable;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool projectActivationDisabled;
  final ProductCategory? productCategory;
  final Brand? brand;
  final Gst? gst;
  final Division? division;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"] ?? (throw FormatException("Missing id")),
      productType: json["product_type"] ?? (throw FormatException("Missing product_type")),
      serviceType: json["service_type"],
      name: json["name"] ?? (throw FormatException("Missing name")),
      description: json["description"],
      composition: json["composition"],
      mrp: json["mrp"] ?? (throw FormatException("Missing mrp")),
      salePrice: json["sale_price"] ?? (throw FormatException("Missing sale_price")),
      recurringFrequency: json["recurring_frequency"],
      customRecurringFrequency: json["custom_recurring_frequency"],
      packing: json["packing"],
      status: json["status"] ?? (throw FormatException("Missing status")),
      isTaxable: json["is_taxable"] ?? (throw FormatException("Missing is_taxable")),
      createdAt: DateTime.parse(json["created_at"] ?? (throw FormatException("Missing created_at"))),
      updatedAt: DateTime.parse(json["updated_at"] ?? (throw FormatException("Missing updated_at"))),
      projectActivationDisabled:
      json["project_activation_disabled"] ?? (throw FormatException("Missing project_activation_disabled")),
      productCategory: json["product_category"] == null
          ? null
          : ProductCategory.fromJson(json["product_category"]),
      brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
      gst: json["gst"] == null ? null : Gst.fromJson(json["gst"]),
      division: json["division"] == null ? null : Division.fromJson(json["division"]),
    );
  }
}

class Brand {
  Brand({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json["id"] ?? (throw FormatException("Missing id")),
      name: json["name"] ?? (throw FormatException("Missing name")),
    );
  }
}

class Division {
  Division({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json["id"] ?? (throw FormatException("Missing id")),
      name: json["name"] ?? (throw FormatException("Missing name")),
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
  });

  final String id;
  final String name;
  final int sgst;
  final int cgst;
  final int igst;

  factory Gst.fromJson(Map<String, dynamic> json) {
    return Gst(
      id: json["id"] ?? (throw FormatException("Missing id")),
      name: json["name"] ?? (throw FormatException("Missing name")),
      sgst: json["sgst"] ?? (throw FormatException("Missing sgst")),
      cgst: json["cgst"] ?? (throw FormatException("Missing cgst")),
      igst: json["igst"] ?? (throw FormatException("Missing igst")),
    );
  }
}

class ProductCategory {
  ProductCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
  });

  final String id;
  final String name;
  final String description;
  final String image;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json["id"] ?? (throw FormatException("Missing id")),
      name: json["name"] ?? (throw FormatException("Missing name")),
      description: json["description"] ?? (throw FormatException("Missing description")),
      image: json["image"] ?? (throw FormatException("Missing image")),
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

  final int currentPage;
  final int itemsPerPage;
  final int totalPages;
  final int totalItems;
  final int itemCount;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["currentPage"] ?? (throw FormatException("Missing currentPage")),
      itemsPerPage: json["itemsPerPage"] ?? (throw FormatException("Missing itemsPerPage")),
      totalPages: json["totalPages"] ?? (throw FormatException("Missing totalPages")),
      totalItems: json["totalItems"] ?? (throw FormatException("Missing totalItems")),
      itemCount: json["itemCount"] ?? (throw FormatException("Missing itemCount")),
    );
  }
}