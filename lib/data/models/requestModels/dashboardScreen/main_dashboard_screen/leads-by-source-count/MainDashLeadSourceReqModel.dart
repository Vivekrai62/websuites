class MainDashLeadSourceReqModel {
  MainDashLeadSourceReqModel({
    required this.dateRange,
    required this.division,
    required this.filterUserId,
    required this.isFilterUserWithTeam,
  });

  final DateRanges? dateRange;
  final dynamic division;
  final String? filterUserId;
  final bool? isFilterUserWithTeam;

  factory MainDashLeadSourceReqModel.fromJson(Map<String, dynamic> json) {
    return MainDashLeadSourceReqModel(
      dateRange: json["date_range"] == null ? null : DateRanges.fromJson(json["date_range"]),
      division: json["division"],
      filterUserId: json["filterUserId"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date_range": dateRange?.toJson(),
      "division": division,
      "filterUserId": filterUserId,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}

class DateRanges {
  DateRanges({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory DateRanges.fromJson(Map<String, dynamic> json) {
    return DateRanges(
      from: DateTime.tryParse(json["from"] ?? ""),
      to: DateTime.tryParse(json["to"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "from": from?.toIso8601String(),
      "to": to?.toIso8601String(),
    };
  }
}
