class CustomerDetailsActiServicesResModel {
  CustomerDetailsActiServicesResModel({
    required this.id,
    required this.service,
    required this.isFree,
    required this.status,
    required this.statusType,
    required this.serviceType,
    required this.startDate,
    required this.endDate,
    required this.category,
    required this.company,
    required this.orderProduct,
  });

  final String? id;
  final String? service;
  final bool? isFree;
  final bool? status;
  final String? statusType;
  final String? serviceType;
  final DateTime? startDate;
  final DateTime? endDate;
  final Category? category;
  final Company? company;
  final OrderProduct? orderProduct;

  factory CustomerDetailsActiServicesResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsActiServicesResModel(
      id: json["id"],
      service: json["service"],
      isFree: json["is_free"],
      status: json["status"],
      statusType: json["status_type"],
      serviceType: json["service_type"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      category: json["category"] == null ? null : Category.fromJson(json["category"]),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      orderProduct: json["order_product"] == null ? null : OrderProduct.fromJson(json["order_product"]),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsActiServicesResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsActiServicesResModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final int? countryCode;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      companyName: json["company_name"],
      companyEmail: json["company_email"],
      companyPhone: json["company_phone"],
      countryCode: json["country_code"],
    );
  }

}

class OrderProduct {
  OrderProduct({
    required this.id,
    required this.productType,
    required this.productName,
    required this.paymentMode,
    required this.paymentType,
    required this.mrp,
    required this.salePrice,
    required this.currencyAmount,
    required this.currencyDiscountAmount,
    required this.currencyTotalAmount,
    required this.currencyGstAmount,
    required this.currencyReceivedAmount,
    required this.currencyDueAmount,
    required this.currencyUnapprovedAmount,
    required this.currencyPdcAmount,
    required this.status,
    required this.currencyMrp,
    required this.currencySalePrice,
    required this.paymentStatus,
    required this.total,
    required this.product,
  });

  final String? id;
  final String? productType;
  final String? productName;
  final dynamic paymentMode;
  final dynamic paymentType;
  final int? mrp;
  final int? salePrice;
  final int? currencyAmount;
  final int? currencyDiscountAmount;
  final int? currencyTotalAmount;
  final int? currencyGstAmount;
  final int? currencyReceivedAmount;
  final int? currencyDueAmount;
  final int? currencyUnapprovedAmount;
  final int? currencyPdcAmount;
  final String? status;
  final int? currencyMrp;
  final int? currencySalePrice;
  final String? paymentStatus;
  final int? total;
  final Product? product;

  factory OrderProduct.fromJson(Map<String, dynamic> json){
    return OrderProduct(
      id: json["id"],
      productType: json["product_type"],
      productName: json["product_name"],
      paymentMode: json["payment_mode"],
      paymentType: json["payment_type"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      currencyAmount: json["currency_amount"],
      currencyDiscountAmount: json["currency_discount_amount"],
      currencyTotalAmount: json["currency_total_amount"],
      currencyGstAmount: json["currency_gst_amount"],
      currencyReceivedAmount: json["currency_received_amount"],
      currencyDueAmount: json["currency_due_amount"],
      currencyUnapprovedAmount: json["currency_unapproved_amount"],
      currencyPdcAmount: json["currency_pdc_amount"],
      status: json["status"],
      currencyMrp: json["currency_mrp"],
      currencySalePrice: json["currency_sale_price"],
      paymentStatus: json["payment_status"],
      total: json["total"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
    );
  }

}

class Product {
  Product({
    required this.id,
    required this.productCategory,
  });

  final String? id;
  final Category? productCategory;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      productCategory: json["product_category"] == null ? null : Category.fromJson(json["product_category"]),
    );
  }

}
