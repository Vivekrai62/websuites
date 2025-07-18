class DailyAnalyticsRequestModel {
  int? month;
  int? year;
  String? date;

  DailyAnalyticsRequestModel({this.month, this.year, this.date});

  DailyAnalyticsRequestModel.fromJson(Map<String, dynamic> json) {
    month = json['month'] != null ? json['month'] as int : null;
    year = json['year'] != null ? json['year'] as int : null;
    date = json['date'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (month != null) data['month'] = month;
    if (year != null) data['year'] = year;
    if (date != null) data['date'] = date;
    return data;
  }
}
