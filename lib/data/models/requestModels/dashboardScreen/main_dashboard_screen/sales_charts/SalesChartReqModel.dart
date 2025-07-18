class SalesChartReqModel {
  SalesChartReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
    required this.dateRange,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;
  final DateRangeSalesChart? dateRange;

  factory SalesChartReqModel.fromJson(Map<String, dynamic> json) {
    return SalesChartReqModel(
      filterUserId: json["filterUser Id"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUser WithTeam"],
      dateRange: json["date_range"] == null
          ? null
          : DateRangeSalesChart.fromJson(json["date_range"]),
    );
  }

  // Convert the SalesChartReqModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "filterUser Id": filterUserId,
      "division": division,
      "isFilterUser WithTeam": isFilterUserWithTeam,
      "date_range": dateRange?.toJson(), // Call toJson on dateRange if it's not null
    };
  }
}

class DateRangeSalesChart {
  DateRangeSalesChart({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory DateRangeSalesChart.fromJson(Map<String, dynamic> json) {
    return DateRangeSalesChart(
      from: DateTime.tryParse(json["from"] ?? ""),
      to: DateTime.tryParse(json["to"] ?? ""),
    );
  }

  // Convert the DateRangeSalesChart instance to JSON
  Map<String, dynamic> toJson() {
    return {
      "from": from?.toIso8601String(), // Convert DateTime to String
      "to": to?.toIso8601String(),     // Convert DateTime to String
    };
  }
}

