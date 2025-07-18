class CustomerPaymentsReminderResponseModel {
  List<Items>? items;
  Meta? meta;
  Null userKey;

  CustomerPaymentsReminderResponseModel({this.items, this.meta, this.userKey});

  CustomerPaymentsReminderResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    userKey = json['user_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['user_key'] = userKey;
    return data;
  }
}

class Items {
  String? id;
  int? amount;
  String? chequeDate;
  String? chequeNumber;
  String? cheque;
  String? reminderDate;
  String? status;
  String? createdAt;
  Orders? orders;
  Product? product;
  Customer? reminderTo;
  Customer? createdBy;

  Items(
      {this.id,
      this.amount,
      this.chequeDate,
      this.chequeNumber,
      this.cheque,
      this.reminderDate,
      this.status,
      this.createdAt,
      this.orders,
      this.product,
      this.reminderTo,
      this.createdBy});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    chequeDate = json['cheque_date'];
    chequeNumber = json['cheque_number'];
    cheque = json['cheque'];
    reminderDate = json['reminder_date'];
    status = json['status'];
    createdAt = json['created_at'];
    orders = json['orders'] != null ? Orders.fromJson(json['orders']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    reminderTo = json['reminder_to'] != null
        ? Customer.fromJson(json['reminder_to'])
        : null;
    createdBy = json['created_by'] != null
        ? Customer.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['cheque_date'] = chequeDate;
    data['cheque_number'] = chequeNumber;
    data['cheque'] = cheque;
    data['reminder_date'] = reminderDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    if (orders != null) {
      data['orders'] = orders!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (reminderTo != null) {
      data['reminder_to'] = reminderTo!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }
}

class Orders {
  String? id;
  int? orderNumber;
  Customer? customer;
  Company? company;

  Orders({this.id, this.orderNumber, this.customer, this.company});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;

  Customer({this.id, this.firstName, this.lastName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Company {
  String? id;
  String? companyName;

  Company({this.id, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class Product {
  String? id;
  String? name;
  ProductCategory? productCategory;
  ProductCategory? brand;

  Product({this.id, this.name, this.productCategory, this.brand});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
    brand =
        json['brand'] != null ? ProductCategory.fromJson(json['brand']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    return data;
  }
}

class ProductCategory {
  String? id;
  String? name;

  ProductCategory({this.id, this.name});

  ProductCategory.fromJson(Map<String, dynamic> json) {
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

class Meta {
  int? total;
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.total,
      this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}
