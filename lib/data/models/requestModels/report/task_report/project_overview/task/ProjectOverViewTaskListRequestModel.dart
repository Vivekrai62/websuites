class ProjectOverviewTaskRequestModel {
  final String? lead;
  final String? assignedTo;
  final String? status;
  final String? priority;
  final int? limit;
  final String? taskType;
  final DateRange? dateRange;
  final String? dateType;
  final int? page;
  final Sort? sort;
  final String? startDateRange;
  final String? project;

  ProjectOverviewTaskRequestModel({
    this.lead,
    this.assignedTo,
    this.status,
    this.priority,
    this.limit,
    this.taskType,
    this.dateRange,
    this.dateType,
    this.page,
    this.sort,
    this.startDateRange,
    this.project,
  });

  Map<String, dynamic> toJson() {
    return {
      "lead": lead,
      "assigned_to": assignedTo,
      "status": status,
      "priority": priority,
      "limit": limit,
      "task_type": taskType,
      "date_range": dateRange?.toJson(),
      "date_type": dateType,
      "page": page,
      "sort": sort?.toJson(),
      "start_date_range": startDateRange,
      "project": project,
    };
  }
}

class DateRange {
  final String from;
  final String to;

  DateRange({required this.from, required this.to});

  Map<String, dynamic> toJson() {
    return {
      "from": from,
      "to": to,
    };
  }
}

class Sort {
  final String? q;
  final String? sortBy;

  Sort({this.q, this.sortBy});

  Map<String, dynamic> toJson() {
    return {
      "q": q,
      "sortBy": sortBy,
    };
  }
}