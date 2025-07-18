class CustomerReportRequestModel {
  String? customer;
  DateRange dateRange;
  int limit;
  int page;

  CustomerReportRequestModel({
    required this.customer,
    required this.dateRange,
    required this.limit,
    required this.page,
  });

  // Convert model to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'customer': customer,
      'date_range': dateRange.toJson(),
      'limit': limit,
      'page': page,
    };
  }
}

class DateRange {
  String from;
  String to;

  DateRange({required this.from, required this.to});

  // Convert DateRange to JSON for nested date range parameter
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}

// Example usage
