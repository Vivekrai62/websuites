class DbProjecStatusReqModel {
  DbProjecStatusReqModel({
    required this.dateRange,
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
  });

  final DateProjectStatus? dateRange; // Updated type
  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;

  factory DbProjecStatusReqModel.fromJson(Map<String, dynamic> json) {
    return DbProjecStatusReqModel(
      dateRange: json["date_range"] == null
          ? null
          : DateProjectStatus.fromJson(json["date_range"]), // Updated reference
      filterUserId: json["filterUserId"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date_range": dateRange?.toJson(),
      "filterUserId": filterUserId,
      "division": division,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}

class DateProjectStatus { // Updated class name
  DateProjectStatus({
    required this.from,
    required this.to,
  });

  final DateTime? from;
  final DateTime? to;

  factory DateProjectStatus.fromJson(Map<String, dynamic> json) { // Updated factory method
    return DateProjectStatus(
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