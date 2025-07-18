class CustomerOrderlessServiceRequestModel {
  String? dateRange;
  String? statusType;
  int? limit;
  String? dateRangeTo;
  String? search;
  int? filterDays;
  String? filterDaysType;
  int? page;

  CustomerOrderlessServiceRequestModel({
    this.dateRange,
    this.statusType,
    this.limit = 15,
    this.dateRangeTo,
    this.search = "",
    this.filterDays,
    this.filterDaysType,
    this.page = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      "date_range": dateRange,
      "status_type": statusType,
      "limit": limit,
      "date_range_to": dateRangeTo,
      "search": search,
      "filterDays": filterDays,
      "filterDaysType": filterDaysType,
      "page": page,
    };
  }
}
