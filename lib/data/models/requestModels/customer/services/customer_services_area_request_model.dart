class CustomerServicesRequestModel {
  double? dateRange;
  double? dateRangeTo;
  String? filterDays;
  String? filterDaysType;
  int limit;
  int page;
  String search;
  String? statusType;

  CustomerServicesRequestModel({
    this.dateRange,
    this.dateRangeTo,
    this.filterDays,
    this.filterDaysType,
    this.limit = 15,
    this.page = 1,
    this.search = "",
    this.statusType,
  });

  // Method to convert model to JSON format
  Map<String, dynamic> toJson() {
    return {
      'date_range': dateRange,
      'date_range_to': dateRangeTo,
      'filterDays': filterDays,
      'filterDaysType': filterDaysType,
      'limit': limit,
      'page': page,
      'search': search,
      'status_type': statusType,
    };
  }

  // Optional: Method to update an instance from JSON (if needed)
  factory CustomerServicesRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerServicesRequestModel(
      dateRange: json['date_range'],
      dateRangeTo: json['date_range_to'],
      filterDays: json['filterDays'],
      filterDaysType: json['filterDaysType'],
      limit: json['limit'] ?? 15,
      page: json['page'] ?? 1,
      search: json['search'] ?? "",
      statusType: json['status_type'],
    );
  }
}
