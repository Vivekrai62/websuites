class OrderListRequestModel {
  String? search;
  String? productType;
  String? product;
  String? paymentType;
  bool? isModalShow;
  String? isTaxable;
  String? modalType;
  String? dateRange;
  String? btnLabel;
  String? createdBy;
  String? customer;
  String? source;
  int? limit;
  String? status;
  String? fiscalYearLabel;
  int? page;

  OrderListRequestModel({
    this.search,
    this.productType,
    this.product,
    this.paymentType,
    this.isModalShow,
    this.isTaxable,
    this.modalType,
    this.dateRange,
    this.btnLabel,
    this.createdBy,
    this.customer,
    this.source,
    this.limit,
    this.status,
    this.fiscalYearLabel,
    this.page,
  });

  factory OrderListRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderListRequestModel(
      search: json['search'],
      productType: json['product_type'],
      product: json['product'],
      paymentType: json['payment_type'],
      isModalShow: json['isModalShow'],
      isTaxable: json['is_taxable'],
      modalType: json['modalType'],
      dateRange: json['date_range'],
      btnLabel: json['btnLabel'],
      createdBy: json['created_by'],
      customer: json['customer'],
      source: json['source'],
      limit: json['limit'],
      status: json['status'],
      fiscalYearLabel: json['fiscalYearLabel'],
      page: json['page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'search': search,
      'product_type': productType,
      'product': product,
      'payment_type': paymentType,
      'isModalShow': isModalShow,
      'is_taxable': isTaxable,
      'modalType': modalType,
      'date_range': dateRange,
      'btnLabel': btnLabel,
      'created_by': createdBy,
      'customer': customer,
      'source': source,
      'limit': limit,
      'status': status,
      'fiscalYearLabel': fiscalYearLabel,
      'page': page,
    };
  }
}
