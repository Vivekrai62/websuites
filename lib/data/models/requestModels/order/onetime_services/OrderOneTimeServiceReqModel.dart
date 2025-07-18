class OrderOneTimeServiceReqModel {
  OrderOneTimeServiceReqModel({
    required this.dateRange,
    required this.dateRangeTo,
    required this.filterDays,
    required this.filterDaysType,
    required this.limit,
    required this.page,
    required this.search,
    required this.statusType,
  });

  final dynamic dateRange;
  final dynamic dateRangeTo;
  final dynamic filterDays;
  final dynamic filterDaysType;
  final int? limit;
  final int? page;
  final String? search;
  final dynamic statusType;

  factory OrderOneTimeServiceReqModel.fromJson(Map<String, dynamic> json) {
    return OrderOneTimeServiceReqModel(
      dateRange: json["date_range"],
      dateRangeTo: json["date_range_to"],
      filterDays: json["filterDays"],
      filterDaysType: json["filterDaysType"],
      limit: json["limit"],
      page: json["page"],
      search: json["search"],
      statusType: json["status_type"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date_range": dateRange,
      "date_range_to": dateRangeTo,
      "filterDays": filterDays,
      "filterDaysType": filterDaysType,
      "limit": limit,
      "page": page,
      "search": search,
      "status_type": statusType,
    };
  }
}