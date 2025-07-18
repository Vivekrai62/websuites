class OrderExportRequestModel {
  String? createdBy;
  String? customer;
  String? dateRange;
  String? paymentType;
  String? product;
  String? productType;
  String? search;

  OrderExportRequestModel({
    this.createdBy,
    this.customer,
    this.dateRange,
    this.paymentType,
    this.product,
    this.productType,
    this.search = "",
  });

  // Method to convert a RequestModel object into a Map (for API requests)
  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy,
      'customer': customer,
      'date_range': dateRange,
      'payment_type': paymentType,
      'product': product,
      'product_type': productType,
      'search': search,
    };
  }

  // Factory method to update a RequestModel object from a JSON map
  factory OrderExportRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderExportRequestModel(
      createdBy: json['created_by'] as String?,
      customer: json['customer'] as String?,
      dateRange: json['date_range'] as String?,
      paymentType: json['payment_type'] as String?,
      product: json['product'] as String?,
      productType: json['product_type'] as String?,
      search: json['search'] as String? ?? "",
    );
  }
}
