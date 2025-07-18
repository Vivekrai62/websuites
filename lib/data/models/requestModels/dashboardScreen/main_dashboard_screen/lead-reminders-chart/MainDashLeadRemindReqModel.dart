class MainDashLeadRemindReqModel {
  final String filterUserId;
  final dynamic division;
  final bool isFilterUserWithTeam;
  final DateRng? dateRange;  // Changed to DateRng?

  MainDashLeadRemindReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
    this.dateRange,
  });

  Map<String, dynamic> toJson() {
    return {
      'filterUserId': filterUserId,
      'division': division,
      'isFilterUserWithTeam': isFilterUserWithTeam,
      'date_range': dateRange?.toJson(), // Use toJson() of DateRng
    };
  }

  factory MainDashLeadRemindReqModel.fromJson(Map<String, dynamic> json) {
    return MainDashLeadRemindReqModel(
      filterUserId: json['filterUserId'],
      division: json['division'],
      isFilterUserWithTeam: json['isFilterUserWithTeam'],
      dateRange: json['date_range'] == null ? null : DateRng.fromJson(json['date_range']),
    );
  }
}


class DateRng {
  final String from;
  final String to;

  DateRng({required this.from, required this.to});

  // Implement toJson method for DateRng
  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }

  factory DateRng.fromJson(Map<String, dynamic> json) {
    return DateRng(
      from: json['from'],
      to: json['to'],
    );
  }
}

