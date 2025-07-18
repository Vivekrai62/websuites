class DbLeadTypeReqModel {
  DbLeadTypeReqModel({
    required this.dateRange,
    required this.division,
    required this.filterUserId,
    required this.isFilterUserWithTeam,
  });

  final DateRangeLeadType? dateRange;
  final dynamic division;
  final String? filterUserId;
  final bool? isFilterUserWithTeam;

  // Factory method to create an instance from JSON
  factory DbLeadTypeReqModel.fromJson(Map<String, dynamic> json) {
    return DbLeadTypeReqModel(
      dateRange: json["date_range"] != null ? DateRangeLeadType.fromJson(json["date_range"]) : null,
      division: json["division"],
      filterUserId: json["filterUserId"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  // Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      "date_range": dateRange?.toJson(),
      "division": division,
      "filterUserId": filterUserId,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}

class DateRangeLeadType {
  DateRangeLeadType({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  // Factory method to create an instance from JSON
  factory DateRangeLeadType.fromJson(Map<String, dynamic> json) {
    return DateRangeLeadType(
      from: json["from"] != null ? DateTime.tryParse(json["from"]) : null,
      to: json["to"] != null ? DateTime.tryParse(json["to"]) : null,
    );
  }

  // Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      "from": from?.toIso8601String(),
      "to": to?.toIso8601String(),
    };
  }
}
