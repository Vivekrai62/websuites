class MainDashCustomerStatusResModel {
  final int? projectNotStarted;
  final int? projectInProgress;
  final int? projectOnHold;
  final int? servicesRunning;
  final int? noServices;

  MainDashCustomerStatusResModel({
    this.projectNotStarted,
    this.projectInProgress,
    this.projectOnHold,
    this.servicesRunning,
    this.noServices,
  });

  factory MainDashCustomerStatusResModel.fromJson(Map<String, dynamic> json) {
    return MainDashCustomerStatusResModel(
      projectNotStarted: json['Project not started'],
      projectInProgress: json['Project in progress'],
      projectOnHold: json['Project on hold'],
      servicesRunning: json['Services running'],
      noServices: json['No services'],
    );
  }
}

class DateRange {
  final String from;
  final String to;

  DateRange({required this.from, required this.to});

  Map<String, dynamic> toJson() => {
    'from': from,
    'to': to,
  };
}

class MainDashCustomerStatusReqModel {
  final DateRange? dateRange;
  final String filterUserId;
  final dynamic division;
  final bool isFilterUserWithTeam;

  MainDashCustomerStatusReqModel({
    this.dateRange,
    required this.filterUserId,
    this.division,
    required this.isFilterUserWithTeam,
  });

  Map<String, dynamic> toJson() => {
    'date_range': dateRange?.toJson(),
    'filterUserId': filterUserId,
    'division': division,
    'isFilterUserWithTeam': isFilterUserWithTeam,
  };
}