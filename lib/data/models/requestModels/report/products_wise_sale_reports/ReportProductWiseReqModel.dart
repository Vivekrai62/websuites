class ReportProductWiseReqModel {
  String? dateRange;
  String? division;
  String? userId;
  bool isFilterUserWithTeam;
  List<dynamic>? products;
  int? limit;
  int? page;

  ReportProductWiseReqModel({
    this.dateRange,
    this.division,
    this.userId,
    this.isFilterUserWithTeam = false,
    this.products,
    this.limit,
    this.page,
  });

  factory ReportProductWiseReqModel.fromJson(Map<String, dynamic> json) {
    return ReportProductWiseReqModel(
      dateRange: json['date_range'] as String?,
      division: json['division'] as String?,
      userId: json['userId'] as String?,
      isFilterUserWithTeam: json['isFilterUserWithTeam'] ?? false,
      products: json['products'] != null
          ? List<dynamic>.from(json['products'])
          : null,
      limit: json['limit'] as int?,
      page: json['page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_range'] = dateRange;
    data['division'] = division;
    data['userId'] = userId;
    data['isFilterUserWithTeam'] = isFilterUserWithTeam;
    if (products != null) {
      data['products'] = products;
    }
    data['limit'] = limit;
    data['page'] = page;
    return data;
  }
}