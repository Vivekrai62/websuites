class TeamLeadReqModel {
  DateRange? dateRange;

  TeamLeadReqModel({this.dateRange});

  TeamLeadReqModel.fromJson(Map<String, dynamic> json) {
    dateRange = json['date_range'] != null
        ? DateRange.fromJson(json['date_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dateRange != null) {
      data['date_range'] = dateRange!.toJson();
    }
    return data;
  }
}

class DateRange {
  String? from;
  String? to;

  DateRange({this.from, this.to});

  DateRange.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}
