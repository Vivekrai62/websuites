class DateRangeTaskStatus {
  final String from;
  final String to;

  DateRangeTaskStatus({
    required this.from,
    required this.to,
  });

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory DateRangeTaskStatus.fromJson(Map<String, dynamic> json) {
    return DateRangeTaskStatus(
      from: json['from'] as String,
      to: json['to'] as String,
    );
  }
}


class DashTaskStatusReqModel {
  final DateRangeTaskStatus? dateRange;
  final dynamic division;
  final String filterUserId;
  final bool isFilterUserWithTeam;

  DashTaskStatusReqModel({
    this.dateRange,
    this.division,
    required this.filterUserId,
    required this.isFilterUserWithTeam,
  });

  Map<String, dynamic> toJson() {
    return {
      'dateRange': dateRange?.toJson(),
      'division': division,
      'filterUserId': filterUserId,
      'isFilterUserWithTeam': isFilterUserWithTeam,
    };
  }

  factory DashTaskStatusReqModel.fromJson(Map<String, dynamic> json) {
    return DashTaskStatusReqModel(
      dateRange: json['dateRange'] != null
          ? DateRangeTaskStatus.fromJson(json['dateRange'])
          : null,
      division: json['division'],
      filterUserId: json['filterUserId'] as String,
      isFilterUserWithTeam: json['isFilterUserWithTeam'] as bool,
    );
  }
}
