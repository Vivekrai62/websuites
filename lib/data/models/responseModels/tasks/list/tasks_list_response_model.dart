class TasksListResponseModel {
  TasksListResponseModel({
    required this.items,
    required this.meta,
    required this.userKey,
    required this.members,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;
  final dynamic members;

  factory TasksListResponseModel.fromJson(Map<String, dynamic> json){
    return TasksListResponseModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
      members: json["members"],
    );
  }

}

class Item {
  Item({
    required this.id,
    required this.subject,
    required this.description,
    required this.startDate,
    required this.completeDate,
    required this.deadline,
    required this.priority,
    required this.estimatedMinutes,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.assigned,
    required this.taskType,
    required this.status,
    required this.project,
    required this.totalTrackTime,
  });

  final String? id;
  final String? subject;
  final String? description;
  final DateTime? startDate;
  final DateTime? completeDate;
  final DateTime? deadline;
  final String? priority;
  final double? estimatedMinutes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CreatedBy? createdBy;
  final List<Assigned> assigned;
  final TaskType? taskType;
  final Status? status;
  final Project? project;
  final double? totalTrackTime;

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      subject: json["subject"],
      description: json["description"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      completeDate: DateTime.tryParse(json["complete_date"] ?? ""),
      deadline: DateTime.tryParse(json["deadline"] ?? ""),
      priority: json["priority"],
      estimatedMinutes: json["estimated_minutes"] != null
          ? (json["estimated_minutes"] is int
          ? (json["estimated_minutes"] as int).toDouble()
          : json["estimated_minutes"] as double)
          : null,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
      assigned: json["assigned"] == null
          ? []
          : List<Assigned>.from(
          json["assigned"]!.map((x) => Assigned.fromJson(x))),
      taskType: json["task_type"] == null
          ? null
          : TaskType.fromJson(json["task_type"]),
      status: json["status"] == null ? null : Status.fromJson(json["status"]),
      project: json["project"] == null
          ? null
          : Project.fromJson(json["project"]),
      totalTrackTime: json["total_track_time"] != null
          ? (json["total_track_time"] is int
          ? (json["total_track_time"] as int).toDouble()
          : json["total_track_time"] as double)
          : null,
    );
  }
}

class Assigned {
  Assigned({
    required this.id,
    required this.status,
    required this.assignedTo,
  });

  final String? id;
  final int? status;
  final CreatedBy? assignedTo;

  factory Assigned.fromJson(Map<String, dynamic> json){
    return Assigned(
      id: json["id"],
      status: json["status"],
      assignedTo: json["assigned_to"] == null ? null : CreatedBy.fromJson(json["assigned_to"]),
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.status,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final bool? status;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      status: json["status"],
    );
  }

}

class Project {
  Project({
    required this.id,
    required this.projectName,
  });

  final String? id;
  final String? projectName;

  factory Project.fromJson(Map<String, dynamic> json){
    return Project(
      id: json["id"],
      projectName: json["project_name"],
    );
  }

}

class Status {
  Status({
    required this.id,
    required this.name,
    required this.color,
  });

  final String? id;
  final String? name;
  final String? color;

  factory Status.fromJson(Map<String, dynamic> json){
    return Status(
      id: json["id"],
      name: json["name"],
      color: json["color"],
    );
  }

}

class TaskType {
  TaskType({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory TaskType.fromJson(Map<String, dynamic> json){
    return TaskType(
      id: json["id"],
      name: json["name"],
    );
  }

}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

}
