class ReportTaskStartResponseModel {
  TaskInfo? taskInfo;
  int? hours;
  double? minutes;

  ReportTaskStartResponseModel({this.taskInfo, this.hours, this.minutes});

  ReportTaskStartResponseModel.fromJson(Map<String, dynamic> json) {
    taskInfo =
        json['taskInfo'] != null ? TaskInfo.fromJson(json['taskInfo']) : null;
    hours = json['hours'];
    minutes = json['minutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (taskInfo != null) {
      data['taskInfo'] = taskInfo!.toJson();
    }
    data['hours'] = hours;
    data['minutes'] = minutes;
    return data;
  }
}

class TaskInfo {
  String? id;
  String? subject;
  String? description;
  String? startDate;
  dynamic completeDate;
  dynamic deadline;
  String? priority;
  dynamic statusDateTime;
  int? estimatedMinutes;
  int? timeTaken;
  String? createdAt;
  String? updatedAt;
  bool? isSequentialTask;
  int? order;
  CreatedBy? createdBy;
  dynamic relatedLead;
  List<Assigned>? assigned;
  List<Null>? histories;
  Status? status;
  TaskType? taskType;
  dynamic department;
  List<TaskDescriptions>? taskDescriptions;
  Project? project;
  dynamic customer;
  List<Null>? attachments;
  List<TimeTracker>? timeTracker;

  TaskInfo(
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
      this.createdBy,
      this.relatedLead,
      this.assigned,
      this.histories,
      this.status,
      this.taskType,
      this.department,
      this.taskDescriptions,
      this.project,
      this.customer,
      this.attachments,
      this.timeTracker});

  TaskInfo.fromJson(Map<String, dynamic> json) {
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
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    relatedLead = json['relatedLead'];
    if (json['assigned'] != null) {
      assigned = <Assigned>[];
      json['assigned'].forEach((v) {
        assigned!.add(Assigned.fromJson(v));
      });
    }
    if (json['histories'] != null) {
      histories = <Null>[];
      json['histories'].forEach((v) {
        histories!.add((v));
      });
    }
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    taskType =
        json['task_type'] != null ? TaskType.fromJson(json['task_type']) : null;
    department = json['department'];
    if (json['task_descriptions'] != null) {
      taskDescriptions = <TaskDescriptions>[];
      json['task_descriptions'].forEach((v) {
        taskDescriptions!.add(TaskDescriptions.fromJson(v));
      });
    }
    project =
        json['project'] != null ? Project.fromJson(json['project']) : null;
    customer = json['customer'];
    if (json['attachments'] != null) {
      attachments = <Null>[];
      json['attachments'].forEach((v) {
        attachments!.add((v));
      });
    }
    if (json['time_tracker'] != null) {
      timeTracker = <TimeTracker>[];
      json['time_tracker'].forEach((v) {
        timeTracker!.add(TimeTracker.fromJson(v));
      });
    }
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
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    data['relatedLead'] = relatedLead;
    if (assigned != null) {
      data['assigned'] = assigned!.map((v) => v.toJson()).toList();
    }
    if (histories != null) {
      data['histories'] = histories!.map((v) => ()).toList();
    }
    if (status != null) {
      data['status'] = status!.toJson();
    }
    if (taskType != null) {
      data['task_type'] = taskType!.toJson();
    }
    data['department'] = department;
    if (taskDescriptions != null) {
      data['task_descriptions'] =
          taskDescriptions!.map((v) => v.toJson()).toList();
    }
    if (project != null) {
      data['project'] = project!.toJson();
    }
    data['customer'] = customer;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => ()).toList();
    }
    if (timeTracker != null) {
      data['time_tracker'] = timeTracker!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;

  CreatedBy({this.id, this.firstName, this.lastName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Assigned {
  String? id;
  int? status;
  String? createdAt;
  String? updatedAt;
  AssignedTo? assignedTo;

  Assigned(
      {this.id, this.status, this.createdAt, this.updatedAt, this.assignedTo});

  Assigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    assignedTo = json['assigned_to'] != null
        ? AssignedTo.fromJson(json['assigned_to'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (assignedTo != null) {
      data['assigned_to'] = assignedTo!.toJson();
    }
    return data;
  }
}

class AssignedTo {
  String? id;
  String? firstName;
  String? lastName;
  bool? status;

  AssignedTo({this.id, this.firstName, this.lastName, this.status});

  AssignedTo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['status'] = status;
    return data;
  }
}

class Status {
  String? id;
  String? name;
  String? reference;
  bool? defaultAt;
  String? color;
  bool? status;
  int? order;
  Null description;
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

class TaskDescriptions {
  String? id;
  String? description;
  String? createdAt;
  CreatedBy? createdBy;

  TaskDescriptions({this.id, this.description, this.createdAt, this.createdBy});

  TaskDescriptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['description'] = description;
    data['created_at'] = createdAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }
}

class Project {
  String? id;
  String? projectName;
  String? startDate;
  Null deadline;
  List<Members>? members;

  Project(
      {this.id, this.projectName, this.startDate, this.deadline, this.members});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    if (json['members'] != null) {
      members = <Members>[];
      json['members'].forEach((v) {
        members!.add(Members.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    data['start_date'] = startDate;
    data['deadline'] = deadline;
    if (members != null) {
      data['members'] = members!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Members {
  String? id;
  String? firstName;
  String? lastName;
  String? email;

  Members({this.id, this.firstName, this.lastName, this.email});

  Members.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

class TimeTracker {
  String? dateTime;
  String? action;

  TimeTracker({this.dateTime, this.action});

  TimeTracker.fromJson(Map<String, dynamic> json) {
    dateTime = json['date_time'];
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = dateTime;
    data['action'] = action;
    return data;
  }
}
