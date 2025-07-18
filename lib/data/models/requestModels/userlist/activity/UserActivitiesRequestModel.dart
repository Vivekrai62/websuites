class UserActivitiesRequestModel {
  int? page;
  int? limit;
  DateRange? dateRange;
  int? active;

  UserActivitiesRequestModel({this.page, this.limit, this.dateRange, this.active});

  UserActivitiesRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    dateRange = json['date_range'] != null ? DateRange.fromJson(json['date_range']) : null;
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['page'] = page;
    data['limit'] = limit;
    if (dateRange != null) {
      data['date_range'] = dateRange!.toJson();
    }
    data['active'] = active;
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
    final Map<String, dynamic> data = {};
    data['from'] = from;
    data['to'] = to;
    return data;
  }
}