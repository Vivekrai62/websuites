class OrderListResponseModel {
  OrderListResponseModel({
    required this.items,
    required this.meta,
    required this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;

  factory OrderListResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderListResponseModel(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "items": items.map((x) => x.toJson()).toList(),
      "meta": meta?.toJson(),
      "user_key": userKey,
    };
  }
}

// Item Model
class Item {
  Item({
    required this.id,
    required this.orderSerialNumber,
    required this.currencyTotalAmount,
    required this.currencyDueAmount,
    required this.orderGeographyType,
    required this.orderDate,
    required this.status,
    required this.paymentStatus,
    required this.createdAt,
    required this.createdBy,
    required this.salesPerson,
    required this.division,
    required this.company,
    required this.orderProducts,
    required this.currency,
    required this.customer,
  });

  final String? id;
  final dynamic orderSerialNumber;
  final int? currencyTotalAmount;
  final int? currencyDueAmount;
  final String? orderGeographyType;
  final dynamic orderDate;
  final String? status;
  final String? paymentStatus;
  final DateTime? createdAt;
  final CreatedBy? createdBy;
  final CreatedBy? salesPerson;
  final Division? division;
  final Company? company;
  final List<OrderProduct> orderProducts;
  final Currency? currency;
  final CreatedBy? customer;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      orderSerialNumber: json["order_serial_number"],
      currencyTotalAmount: json["currency_total_amount"],
      currencyDueAmount: json["currency_due_amount"],
      orderGeographyType: json["order_geography_type"],
      orderDate: json["order_date"],
      status: json["status"],
      paymentStatus: json["payment_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
      salesPerson: json["salesPerson"] == null
          ? null
          : CreatedBy.fromJson(json["salesPerson"]),
      division: json["division"] == null ? null : Division.fromJson(json["division"]),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      orderProducts: json["order_products"] == null
          ? []
          : List<OrderProduct>.from(
          json["order_products"]!.map((x) => OrderProduct.fromJson(x))),
      currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
      customer: json["customer"] == null ? null : CreatedBy.fromJson(json["customer"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "order_serial_number": orderSerialNumber,
      "currency_total_amount": currencyTotalAmount,
      "currency_due_amount": currencyDueAmount,
      "order_geography_type": orderGeographyType,
      "order_date": orderDate,
      "status": status,
      "payment_status": paymentStatus,
      "created_at": createdAt?.toIso8601String(),
      "created_by": createdBy?.toJson(),
      "salesPerson": salesPerson?.toJson(),
      "division": division?.toJson(),
      "company": company?.toJson(),
      "order_products": orderProducts.map((x) => x.toJson()).toList(),
      "currency": currency?.toJson(),
      "customer": customer?.toJson(),
    };
  }
}

// Company Model
class Company {
  Company({
    required this.id,
    required this.companyName,
  });

  final String? id;
  final String? companyName;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"],
      companyName: json["company_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "company_name": companyName,
    };
  }
}

// CreatedBy Model
class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
    };
  }
}

// Currency Model
class Currency {
  Currency({
    required this.id,
    required this.symbol,
  });

  final String? id;
  final String? symbol;

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json["id"],
      symbol: json["symbol"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "symbol": symbol,
    };
  }
}

// Division Model
class Division {
  Division({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

// OrderProduct Model
class OrderProduct {
  OrderProduct({
    required this.id,
    required this.productName,
  });

  final String? id;
  final dynamic productName;

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json["id"],
      productName: json["product_name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "product_name": productName,
    };
  }
}

// Meta Model
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

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "currentPage": currentPage,
      "itemsPerPage": itemsPerPage,
      "totalPages": totalPages,
      "totalItems": totalItems,
      "itemCount": itemCount,
    };
  }
}