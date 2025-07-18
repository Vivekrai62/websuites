class TaskReportRequestModel {
  String? date;
  int? limit;
  Null reportOf;
  int? page;

  TaskReportRequestModel({this.date, this.limit, this.reportOf, this.page});

  TaskReportRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    limit = json['limit'];
    reportOf = json['report_of'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['limit'] = limit;
    data['report_of'] = reportOf;
    data['page'] = page;
    return data;
  }
}
