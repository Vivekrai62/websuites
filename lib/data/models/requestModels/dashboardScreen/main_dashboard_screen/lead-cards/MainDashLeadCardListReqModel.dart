class MainDashLeadCardListReqModel {
  MainDashLeadCardListReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
    required this.dateRange,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;
  final DateRange? dateRange;

  factory MainDashLeadCardListReqModel.fromJson(Map<String, dynamic> json){
    return MainDashLeadCardListReqModel(
      filterUserId: json["filterUserId"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
      dateRange: json["date_range"] == null ? null : DateRange.fromJson(json["date_range"]),
    );
  }

}

class DateRange {
  DateRange({
    required this.from,
    required this.to,
  });

  final String? from;
  final String? to;

  factory DateRange.fromJson(Map<String, dynamic> json){
    return DateRange(
      from: json["from"],
      to: json["to"],
    );
  }

}

