class DashboardLeadsByTypeCountRequestModel {
  String? from;
  String? to;
  String? filterUser;
  String? division;
  int? limit;
  int? page;

  DashboardLeadsByTypeCountRequestModel({
    this.from,
    this.to,
    this.filterUser,
    this.division,
    this.limit,
    this.page,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_range'] = {"from": from, "to": to};
    data['filterUser'] = filterUser;
    data['division'] = division;
    data['limit'] = limit;
    data['page'] = page;
    return data;
  }
}