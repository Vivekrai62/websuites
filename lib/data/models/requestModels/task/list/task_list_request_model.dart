class TaskListRequestModel {
  String? assignedTo;
  String? company;
  String? completeDateRange;
  String? createdBy;
  String? customer;
  String? dateRange;
  String? dateType;
  String? divisionId;
  bool? isFilterAssigneeWithTeam;
  bool? isFilterCreatedByWithTeam;
  String? lastUpdateDateRange;
  String? lead;
  int? limit;
  int? page;
  String? priority;
  String? project;
  Sort? sort;
  String? startDateRange;
  List<String?>? status;
  String? taskType;

  TaskListRequestModel({
    this.assignedTo,
    this.company,
    this.completeDateRange,
    this.createdBy,
    this.customer,
    this.dateRange,
    this.dateType,
    this.divisionId,
    this.isFilterAssigneeWithTeam,
    this.isFilterCreatedByWithTeam,
    this.lastUpdateDateRange,
    this.lead,
    this.limit,
    this.page,
    this.priority,
    this.project,
    this.sort,
    this.startDateRange,
    this.status,
    this.taskType,
  });

  TaskListRequestModel.fromJson(Map<String, dynamic> json) {
    assignedTo = json['assigned_to'];
    company = json['company'];
    completeDateRange = json['complete_date_range'];
    createdBy = json['created_by'];
    customer = json['customer'];
    dateRange = json['date_range'];
    dateType = json['date_type'];
    divisionId = json['divisionId'];
    isFilterAssigneeWithTeam = json['isFilterAssigneeWithTeam'];
    isFilterCreatedByWithTeam = json['isFilterCreatedByWithTeam'];
    lastUpdateDateRange = json['last_update_date_range'];
    lead = json['lead'];
    limit = json['limit'];
    page = json['page'];
    priority = json['priority'];
    project = json['project'];
    sort = json['sort'] != null ? Sort.fromJson(json['sort']) : null;
    startDateRange = json['start_date_range'];
    if (json['status'] != null) {
      status = <String?>[];
      json['status'].forEach((v) {
        status!.add(v);
      });
    }
    taskType = json['task_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['assigned_to'] = assignedTo;
    data['company'] = company;
    data['complete_date_range'] = completeDateRange;
    data['created_by'] = createdBy;
    data['customer'] = customer;
    data['date_range'] = dateRange;
    data['date_type'] = dateType;
    data['divisionId'] = divisionId;
    data['isFilterAssigneeWithTeam'] = isFilterAssigneeWithTeam;
    data['isFilterCreatedByWithTeam'] = isFilterCreatedByWithTeam;
    data['last_update_date_range'] = lastUpdateDateRange;
    data['lead'] = lead;
    data['limit'] = limit;
    data['page'] = page;
    data['priority'] = priority;
    data['project'] = project;
    if (sort != null) {
      data['sort'] = sort!.toJson();
    }
    data['start_date_range'] = startDateRange;
    if (status != null) {
      data['status'] = status!.map((v) => v).toList();
    }
    data['task_type'] = taskType;
    return data;
  }
}

class Sort {
  String? q;
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
