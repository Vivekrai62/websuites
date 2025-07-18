// Removed invalid import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart'
// as it's not needed for these models

class SalesUpdateProjectionListResponseModel {
  String? id;
  int? amount;
  bool? isClosed;
  String? status;
  String? projectionDate;
  String? createdAt;
  String? updatedAt;
  ProductCategory? productCategory;
  Product? product;
  Lead? lead;
  dynamic customer; // Using dynamic as customer type can vary
  CreatedBy? createdBy;

  SalesUpdateProjectionListResponseModel({
    this.id,
    this.amount,
    this.isClosed,
    this.status,
    this.projectionDate,
    this.createdAt,
    this.updatedAt,
    this.productCategory,
    this.product,
    this.lead,
    this.customer,
    this.createdBy,
  });

  SalesUpdateProjectionListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    isClosed = json['isClosed'];
    status = json['status'];
    projectionDate = json['projection_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    productCategory = json['product_category'] != null
        ? ProductCategory.fromJson(json['product_category'])
        : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    lead = json['lead'] != null ? Lead.fromJson(json['lead']) : null;
    customer = json['customer'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
  }

  static List<SalesUpdateProjectionListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => SalesUpdateProjectionListResponseModel.fromJson(
            json as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['isClosed'] = isClosed;
    data['status'] = status;
    data['projection_date'] = projectionDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (productCategory != null) {
      data['product_category'] = productCategory!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    data['customer'] = customer;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
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

class Customer {
  String? id;
  String? name;

  Customer({this.id, this.name});

  Customer.fromJson(Map<String, dynamic> json) {
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

class Product {
  String? id;
  String? name;
  int? mrp;
  int? salePrice;

  Product({this.id, this.name, this.mrp, this.salePrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    return data;
  }
}

class Lead {
  String? id;
  String? firstName;
  String? lastName;
  String? organization;

  Lead({this.id, this.firstName, this.lastName, this.organization});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    organization = json['organization'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['organization'] = organization;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;

  CreatedBy({this.id, this.firstName, this.lastName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
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
