class DateRanges {
  String from;
  String to;

  DateRanges({required this.from, required this.to});

  factory DateRanges.fromJson(Map<String, dynamic> json) {
    return DateRanges(
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}

class DailySalesReportRequestModel {
  DateRanges dateRange;
  int limit;
  int page;
  String userId;

  DailySalesReportRequestModel({
    required this.dateRange,
    required this.limit,
    required this.page,
    required this.userId,
  });

  factory DailySalesReportRequestModel.fromJson(Map<String, dynamic> json) {
    return DailySalesReportRequestModel(
      dateRange: DateRanges.fromJson(json['date_range']),
      limit: json['limit'],
      page: json['page'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date_range': dateRange.toJson(),
      'limit': limit,
      'page': page,
      'user_id': userId,
    };
  }
}


