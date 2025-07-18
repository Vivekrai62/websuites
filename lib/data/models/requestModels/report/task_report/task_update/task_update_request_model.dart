class TaskUpdateRequestModel {
  final String assignedTo;
  final String deadline;
  final String description;
  final String estimatedMinutes;
  final String priority;
  final String project;
  final String startDate;
  final String status;
  final String subject;
  final String taskType;

  TaskUpdateRequestModel({
    required this.assignedTo,
    required this.deadline,
    required this.description,
    required this.estimatedMinutes,
    required this.priority,
    required this.project,
    required this.startDate,
    required this.status,
    required this.subject,
    required this.taskType,
  });

  // Convert the object to a Map for API requests
  Map<String, dynamic> toJson() {
    return {
      "assigned_to": assignedTo,
      "deadline": deadline,
      "description": description,
      "estimated_minutes": estimatedMinutes,
      "priority": priority,
      "project": project,
      "start_date": startDate,
      "status": status,
      "subject": subject,
      "task_type": taskType,
    };
  }

  // Factory constructor to create a RequestModel from JSON (if needed)
  factory TaskUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskUpdateRequestModel(
      assignedTo: json["assigned_to"],
      deadline: json["deadline"],
      description: json["description"],
      estimatedMinutes: json["estimated_minutes"],
      priority: json["priority"],
      project: json["project"],
      startDate: json["start_date"],
      status: json["status"],
      subject: json["subject"],
      taskType: json["task_type"],
    );
  }
}
