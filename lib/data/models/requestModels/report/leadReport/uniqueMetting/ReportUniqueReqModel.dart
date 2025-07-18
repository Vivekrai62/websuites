class ReportUniqueReqModel {
  int? limit;
  dynamic dateRange;
  int? page;
  bool? isFilterUserWithTeam;
  dynamic assignedTo;

  ReportUniqueReqModel({
    this.limit,
    this.dateRange,
    this.page,
    this.isFilterUserWithTeam,
    this.assignedTo,
  });

  ReportUniqueReqModel.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    dateRange = json['dateRange'];
    page = json['page'];
    isFilterUserWithTeam = json['isFilterUserWithTeam'];
    assignedTo = json['assignedTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['limit'] = limit;
    data['dateRange'] = dateRange;
    data['page'] = page;
    data['isFilterUserWithTeam'] = isFilterUserWithTeam;
    data['assignedTo'] = assignedTo;
    return data;
  }
}