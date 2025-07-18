class ReportEmployeeReportReqModel {
  final int? limit;
  final DateRange? dateRange;
  final int? page;
  final bool? isWithTeam;
  final dynamic reportOn;
  final dynamic userId;

  ReportEmployeeReportReqModel({
    this.limit,
    this.dateRange,
    this.page,
    this.isWithTeam,
    this.reportOn,
    this.userId,
  });

  factory ReportEmployeeReportReqModel.fromJson(Map<String, dynamic> json) {
    return ReportEmployeeReportReqModel(
      limit: json['limit'],
      dateRange: json['date_range'] != null
          ? DateRange.fromJson(json['date_range'])
          : null,
      page: json['page'],
      isWithTeam: json['is_with_team'],
      reportOn: json['report_on'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      if (dateRange != null) 'date_range': dateRange!.toJson(),
      'page': page,
      'is_with_team': isWithTeam,
      'report_on': reportOn,
      'user_id': userId,
    };
  }
}

class DateRange {
  final String? from;
  final String? to;

  DateRange({this.from, this.to});

  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
