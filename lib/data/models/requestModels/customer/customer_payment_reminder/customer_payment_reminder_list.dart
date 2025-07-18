class CustomerPaymentRequestModel {
  String? customer;
  String? dateRange;
  String? dateRangeTo; // assuming it should be a String
  String? division;
  int? limit;
  int? page;
  String? reminderTo;
  String? reminderType;
  int? rowsPerPage;
  String? status;

  CustomerPaymentRequestModel({
    this.customer,
    this.dateRange,
    this.dateRangeTo,
    this.division,
    this.limit,
    this.page,
    this.reminderTo,
    this.reminderType,
    this.rowsPerPage,
    this.status,
  });

  // Convert JSON to Request Model
  CustomerPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    dateRange = json['date_range'];
    dateRangeTo = json['date_range_to'];
    division = json['division'];
    limit = json['limit'];
    page = json['page'];
    reminderTo = json['reminder_to'];
    reminderType = json['reminder_type'];
    rowsPerPage = json['rowsPerPage'];
    status = json['status'];
  }

  // Convert Request Model to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer'] = customer;
    data['date_range'] = dateRange;
    data['date_range_to'] = dateRangeTo;
    data['division'] = division;
    data['limit'] = limit;
    data['page'] = page;
    data['reminder_to'] = reminderTo;
    data['reminder_type'] = reminderType;
    data['rowsPerPage'] = rowsPerPage;
    data['status'] = status;
    return data;
  }
}
