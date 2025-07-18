class LeadReportsRequestModel {
  DateRange? dateRange;
  int? limit;
  int? page;
  String? userId;

  LeadReportsRequestModel({
    this.dateRange,
    this.limit,
    this.page,
    this.userId,
  });

  // From JSON factory method
  factory LeadReportsRequestModel.fromJson(Map<String, dynamic> json) {
    return LeadReportsRequestModel(
      dateRange: json['date_range'] != null
          ? DateRange.fromJson(json['date_range'])
          : null,
      limit: json['limit'] ?? 0,
      page: json['page'] ?? 0,
      userId: json['user_id'] ?? "",
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dateRange != null) {
      data['date_range'] = dateRange!.toJson();
    }
    data['limit'] = limit;
    data['page'] = page;
    data['user_id'] = userId;
    return data;
  }
}

// Class to handle date range
class DateRange {
  String? from;
  String? to;

  DateRange({this.from, this.to});

  // From JSON factory method
  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(
      from: json['from'] ?? "",
      to: json['to'] ?? "",
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
