class ProjectListRequest {
  int? page;
  int? limit;
  dynamic range; // Use dynamic for potentially null or mixed types
  dynamic customer;
  dynamic billingType;
  dynamic subActivity;
  List<dynamic>? tags; // Use List<dynamic> for generic or null lists
  dynamic divisionId;
  bool? isFilterMemberWithTeam;
  dynamic member;
  Sort? sort;
  dynamic status;

  ProjectListRequest({
    this.page,
    this.limit,
    this.range,
    this.customer,
    this.billingType,
    this.subActivity,
    this.tags,
    this.divisionId,
    this.isFilterMemberWithTeam,
    this.member,
    this.sort,
    this.status,
  });

  ProjectListRequest.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    range = json['range'];
    customer = json['customer'];
    billingType = json['billing_type'];
    subActivity = json['sub_activity'];
    tags = json['tags'] != null ? List<dynamic>.from(json['tags']) : null;
    divisionId = json['divisionId'];
    isFilterMemberWithTeam = json['isFilterMemberWithTeam'];
    member = json['member'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    data['limit'] = limit;
    data['range'] = range;
    data['customer'] = customer;
    data['billing_type'] = billingType;
    data['sub_activity'] = subActivity;
    if (tags != null) {
      data['tags'] = tags;
    }
    data['divisionId'] = divisionId;
    data['isFilterMemberWithTeam'] = isFilterMemberWithTeam;
    data['member'] = member;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Sort {
  dynamic q; // Use dynamic for mixed or null types
  String? sortBy;

  Sort({this.q, this.sortBy});

  Sort.fromJson(Map<String, dynamic> json) {
    q = json['q'];
    sortBy = json['sortBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['q'] = q;
    data['sortBy'] = sortBy;
    return data;
  }
}
