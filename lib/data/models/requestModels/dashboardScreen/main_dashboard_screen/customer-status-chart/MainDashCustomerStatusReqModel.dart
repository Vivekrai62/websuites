class MainDashCustomerStatusReqModel {
  MainDashCustomerStatusReqModel({
    required this.dateRange,
    required this.division,
    required this.filterUserId,
    required this.isFilterUserWithTeam,
  });

  final DateRange? dateRange;
  final String division;
  final String filterUserId;
  final bool isFilterUserWithTeam;

  factory MainDashCustomerStatusReqModel.fromJson(Map<String, dynamic> json) {
    return MainDashCustomerStatusReqModel(
      dateRange: json["date_range"] == null ? null : DateRange.fromJson(json["date_range"]),
      division: json["division"] ?? '',
      filterUserId: json["filterUserId"] ?? '',
      isFilterUserWithTeam: json["isFilterUserWithTeam"] ?? false,
    );
  }
}

class DateRange {
  DateRange({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(
      from: DateTime.tryParse(json["from"] ?? ''),
      to: DateTime.tryParse(json["to"] ?? ''),
    );
  }
}
