class CustomerActivityListRequest {
  final int active;
  final String activity;
  final DateRange dateRange;
  final int limit;
  final int page;

  CustomerActivityListRequest({
    required this.active,
    required this.activity,
    required this.dateRange,
    required this.limit,
    required this.page,
  });

  // To convert to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'activity': activity,
      'date_range': dateRange.toJson(),
      'limit': limit,
      'page': page,
    };
  }
}

// DateRange model for the nested `date_range` field
class DateRange {
  final String from;
  final String to;

  DateRange({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
