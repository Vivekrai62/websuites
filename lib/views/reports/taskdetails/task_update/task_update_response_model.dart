class ReportTaskUpdateResponseModel {
  String? id;
  String? subject;
  String? description;
  String? startDate;
  dynamic completeDate;
  String? deadline;
  String? priority;
  String? statusDateTime;
  int? estimatedMinutes;
  int? timeTaken;
  String? createdAt;
  String? updatedAt;
  bool? isSequentialTask;
  int? order;
  Status? status;
  Project? project;
  TaskType? taskType;

  ReportTaskUpdateResponseModel(
      {this.id,
      this.subject,
      this.description,
      this.startDate,
      this.completeDate,
      this.deadline,
      this.priority,
      this.statusDateTime,
      this.estimatedMinutes,
      this.timeTaken,
      this.createdAt,
      this.updatedAt,
      this.isSequentialTask,
      this.order,
      this.status,
      this.project,
      this.taskType});

  ReportTaskUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    description = json['description'];
    startDate = json['start_date'];
    completeDate = json['complete_date'];
    deadline = json['deadline'];
    priority = json['priority'];
    statusDateTime = json['status_date_time'];
    estimatedMinutes = json['estimated_minutes'];
    timeTaken = json['time_taken'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSequentialTask = json['is_sequential_task'];
    order = json['order'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    taskType =
        json['task_type'] != null ? TaskType.fromJson(json['task_type']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject'] = subject;
    data['description'] = description;
    data['start_date'] = startDate;
    data['complete_date'] = completeDate;
    data['deadline'] = deadline;
    data['priority'] = priority;
    data['status_date_time'] = statusDateTime;
    data['estimated_minutes'] = estimatedMinutes;
    data['time_taken'] = timeTaken;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_sequential_task'] = isSequentialTask;
    data['order'] = order;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (taskType != null) {
      data['task_type'] = taskType!.toJson();
    }
    return data;
  }
}

class Status {
  String? id;
  String? name;
  dynamic reference;
  bool? defaultAt;
  String? color;
  bool? status;
  int? order;
  dynamic description;
  String? createdAt;
  String? updatedAt;

  Status(
      {this.id,
      this.name,
      this.reference,
      this.defaultAt,
      this.color,
      this.status,
      this.order,
      this.description,
      this.createdAt,
      this.updatedAt});

  Status.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    reference = json['reference'];
    defaultAt = json['default'];
    color = json['color'];
    status = json['status'];
    order = json['order'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['reference'] = reference;
    data['default'] = defaultAt;
    data['color'] = color;
    data['status'] = status;
    data['order'] = order;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Project {
  String? id;
  String? projectName;
  String? billingType;
  String? status;
  int? totalRate;
  int? estimatedHours;
  String? startDate;
  dynamic deadline;
  String? description;
  String? demoUrl;
  dynamic finishDate;
  String? liveUrl;
  String? createdAt;
  String? updatedAt;

  Project(
      {this.id,
      this.projectName,
      this.billingType,
      this.status,
      this.totalRate,
      this.estimatedHours,
      this.startDate,
      this.deadline,
      this.description,
      this.demoUrl,
      this.finishDate,
      this.liveUrl,
      this.createdAt,
      this.updatedAt});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    billingType = json['billing_type'];
    status = json['status'];
    totalRate = json['total_rate'];
    estimatedHours = json['estimated_hours'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    description = json['description'];
    demoUrl = json['demo_url'];
    finishDate = json['finish_date'];
    liveUrl = json['live_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['billing_type'] = billingType;
    data['status'] = status;
    data['total_rate'] = totalRate;
    data['estimated_hours'] = estimatedHours;
    data['start_date'] = startDate;
    data['deadline'] = deadline;
    data['description'] = description;
    data['demo_url'] = demoUrl;
    data['finish_date'] = finishDate;
    data['live_url'] = liveUrl;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TaskType {
  String? id;
  String? name;
  bool? status;
  String? createdAt;
  String? updatedAt;

  TaskType({this.id, this.name, this.status, this.createdAt, this.updatedAt});

  TaskType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
