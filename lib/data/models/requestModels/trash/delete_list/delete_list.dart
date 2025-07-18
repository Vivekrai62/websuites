class LeadTrashListResModel {
  LeadTrashListResModel({
    required this.page,
    required this.search,
    required this.reminderRange,
    required this.range,
    required this.dateRange,
    required this.deleteDateRange,
    required this.unhandle,
    required this.limit,
  });

  final int? page;
  final String? search;
  final dynamic reminderRange;
  final dynamic range;
  final dynamic dateRange;
  final dynamic deleteDateRange;
  final dynamic unhandle;
  final int? limit;

  factory LeadTrashListResModel.fromJson(Map<String, dynamic> json){
    return LeadTrashListResModel(
      page: json["page"],
      search: json["search"],
      reminderRange: json["reminder_range"],
      range: json["range"],
      dateRange: json["date_range"],
      deleteDateRange: json["delete_date_range"],
      unhandle: json["unhandle"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "page": page,
    "search": search,
    "reminder_range": reminderRange,
    "range": range,
    "date_range": dateRange,
    "delete_date_range": deleteDateRange,
    "unhandle": unhandle,
    "limit": limit,
  };

}
