class ReportRecurringServicesReqModel {
  Map<String, dynamic>? dateRange; // Nullable map for date range
  String? statusType; // Nullable string for status type
  int? limit; // Nullable int for limit
  String? range; // Nullable string for range
  String? search; // Nullable string for search
  int? expiringInDays; // Nullable int for expiring in days
  int? expiredDaysAgo; // Nullable int for expired days ago
  int? page; // Nullable int for page

  ReportRecurringServicesReqModel({
    this.dateRange,
    this.statusType,
    this.limit,
    this.range,
    this.search,
    this.expiringInDays,
    this.expiredDaysAgo,
    this.page,
  });

  ReportRecurringServicesReqModel.fromJson(Map<String, dynamic> json)
      : dateRange = json['date_range'] as Map<String, dynamic>?,
        statusType = json['status_type'] as String?,
        limit = json['limit'] as int?,
        range = json['range'] as String?,
        search = json['search'] as String?,
        expiringInDays = json['expiringInDays'] as int?,
        expiredDaysAgo = json['expiredDaysAgo'] as int?,
        page = json['page'] as int?;

  Map<String, dynamic> toJson() {
    return {
      'date_range': dateRange,
      'status_type': statusType,
      'limit': limit,
      'range': range,
      'search': search,
      'expiringInDays': expiringInDays,
      'expiredDaysAgo': expiredDaysAgo,
      'page': page,
    };
  }
}
