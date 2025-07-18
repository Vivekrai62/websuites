class TaskReportResponseModel {
  final List<Items>? items;
  final Meta? meta;
  final String? userKey;

  const TaskReportResponseModel({
    this.items,
    this.meta,
    this.userKey,
  });

  factory TaskReportResponseModel.fromJson(Map<String, dynamic> json) {
    return TaskReportResponseModel(
      items: json['items'] != null
          ? List<Items>.from(
        json['items'].map((v) => Items.fromJson(v)),
      )
          : null,
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
      userKey: json['user_key'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (items != null) 'items': items!.map((v) => v.toJson()).toList(),
      if (meta != null) 'meta': meta!.toJson(),
      'user_key': userKey,
    };
  }
}

class Items {
  final String? user;
  final String? email;
  final CurrentTask? currentTask;
  final List<dynamic>? taskList;

  const Items({
    this.user,
    this.email,
    this.currentTask,
    this.taskList,
  });

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      user: json['user'],
      email: json['email'],
      currentTask: json['currentTask'] != null
          ? CurrentTask.fromJson(json['currentTask'])
          : null,
      taskList: json['taskList'] != null
          ? List<dynamic>.from(json['taskList'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'email': email,
      if (currentTask != null) 'currentTask': currentTask!.toJson(),
      if (taskList != null) 'taskList': taskList,
    };
  }
}

class CurrentTask {
  final String? id;
  final String? dateTime;
  final String? action;
  final String? createdAt;
  final String? updatedAt;
  final Task? task;
  final String? todayStart;

  const CurrentTask({
    this.id,
    this.dateTime,
    this.action,
    this.createdAt,
    this.updatedAt,
    this.task,
    this.todayStart,
  });

  factory CurrentTask.fromJson(Map<String, dynamic> json) {
    return CurrentTask(
      id: json['id'],
      dateTime: json['date_time'],
      action: json['action'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      task: json['task'] != null ? Task.fromJson(json['task']) : null,
      todayStart: json['today_start'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_time': dateTime,
      'action': action,
      'created_at': createdAt,
      'updated_at': updatedAt,
      if (task != null) 'task': task!.toJson(),
      'today_start': todayStart,
    };
  }
}

class Task {
  final String? id;
  final String? subject;
  final String? description;
  final String? startDate;
  final dynamic completeDate;
  final dynamic deadline;
  final String? priority;
  final dynamic statusDateTime;
  final int? estimatedMinutes;
  final int? timeTaken;
  final String? createdAt;
  final String? updatedAt;
  final bool? isSequentialTask;
  final int? order;

  const Task({
    this.id,
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
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      subject: json['subject'],
      description: json['description'],
      startDate: json['start_date'],
      completeDate: json['complete_date'],
      deadline: json['deadline'],
      priority: json['priority'],
      statusDateTime: json['status_date_time'],
      estimatedMinutes: json['estimated_minutes'],
      timeTaken: json['time_taken'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      isSequentialTask: json['is_sequential_task'],
      order: json['order'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'description': description,
      'start_date': startDate,
      'complete_date': completeDate,
      'deadline': deadline,
      'priority': priority,
      'status_date_time': statusDateTime,
      'estimated_minutes': estimatedMinutes,
      'time_taken': timeTaken,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'is_sequential_task': isSequentialTask,
      'order': order,
    };
  }
}

class Meta {
  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  const Meta({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['currentPage'],
      itemsPerPage: json['itemsPerPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      itemCount: json['itemCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'itemsPerPage': itemsPerPage,
      'totalPages': totalPages,
      'totalItems': totalItems,
      'itemCount': itemCount,
    };
  }
}

