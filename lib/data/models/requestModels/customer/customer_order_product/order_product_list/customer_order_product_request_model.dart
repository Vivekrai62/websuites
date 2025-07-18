class CustomerOrderProductRequestModel {
  String btnLabel;
  String? createdBy;
  String? customer;
  String? dateRange;
  String? fiscalYearLabel;
  bool isModalShow;
  String isTaxable;
  int limit;
  String modalType;
  int page;
  String? paymentType;
  String? product;
  String? productType;
  String search;
  String? status;

  CustomerOrderProductRequestModel({
    required this.btnLabel,
    this.createdBy,
    this.customer,
    this.dateRange,
    this.fiscalYearLabel,
    required this.isModalShow,
    required this.isTaxable,
    required this.limit,
    required this.modalType,
    required this.page,
    this.paymentType,
    this.product,
    this.productType,
    required this.search,
    this.status,
  });

  // Function to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'btnLabel': btnLabel,
      'created_by': createdBy,
      'customer': customer,
      'date_range': dateRange,
      'fiscalYearLabel': fiscalYearLabel,
      'isModalShow': isModalShow,
      'is_taxable': isTaxable,
      'limit': limit,
      'modalType': modalType,
      'page': page,
      'payment_type': paymentType,
      'product': product,
      'product_type': productType,
      'search': search,
      'status': status,
    };
  }

  // Optional: Function to update model from JSON
  factory CustomerOrderProductRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerOrderProductRequestModel(
      btnLabel: json['btnLabel'],
      createdBy: json['created_by'],
      customer: json['customer'],
      dateRange: json['date_range'],
      fiscalYearLabel: json['fiscalYearLabel'],
      isModalShow: json['isModalShow'],
      isTaxable: json['is_taxable'],
      limit: json['limit'],
      modalType: json['modalType'],
      page: json['page'],
      paymentType: json['payment_type'],
      product: json['product'],
      productType: json['product_type'],
      search: json['search'],
      status: json['status'],
    );
  }
}
