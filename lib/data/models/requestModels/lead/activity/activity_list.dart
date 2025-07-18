class LeadActivityRequestModel {
  int? page;
  int? limit;
  DateRange? dateRange;

  LeadActivityRequestModel({this.page, this.limit, this.dateRange});

  LeadActivityRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    dateRange = json['date_range'] != null
        ? DateRange.fromJson(json['date_range'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
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
