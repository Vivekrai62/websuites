class OrderPaymentRequestModel {
  // Use 'Null?' for nullable variables
  dynamic chequeDateRange;
  dynamic createdBy;
  dynamic customerId;
  dynamic dateRange;
  dynamic divisionId;
  int? limit;
  int? page;
  dynamic paymentDateRange;
  dynamic paymentMode;
  dynamic paymentType;
  dynamic product;
  String? search;
  dynamic status;

  OrderPaymentRequestModel({
    this.chequeDateRange,
    this.createdBy,
    this.customerId,
    this.dateRange,
    this.divisionId,
    this.limit,
    this.page,
    this.paymentDateRange,
    this.paymentMode,
    this.paymentType,
    this.product,
    this.search,
    this.status,
  });

  // Handle null checks explicitly in fromJson method
  OrderPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    chequeDateRange = json['cheque_date_range'];
    createdBy = json['created_by'];
    customerId = json['customerId'];
    dateRange = json['date_range'];
    divisionId = json['divisionId'];
    limit = json['limit'];
    page = json['page'];
    paymentDateRange = json['payment_date_range'];
    paymentMode = json['payment_mode'];
    paymentType = json['payment_type'];
    product = json['product'];
    search = json['search'] ?? '';
    status = json['status'];
  }

  // Handle null values properly in toJson method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cheque_date_range'] = chequeDateRange;
    data['created_by'] = createdBy;
    data['customerId'] = customerId;
    data['date_range'] = dateRange;
    data['divisionId'] = divisionId;
    data['limit'] = limit;
    data['page'] = page;
    data['payment_date_range'] = paymentDateRange;
    data['payment_mode'] = paymentMode;
    data['payment_type'] = paymentType;
    data['product'] = product;
    data['search'] = search ?? '';
    data['status'] = status;
    return data;
  }
}

class DateRange {
  String from;
  String to;

  DateRange({required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
