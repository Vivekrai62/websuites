class TaskTrackerEventRequestModel {
  final String task;
  final String type;

  TaskTrackerEventRequestModel({
    required this.task,
    required this.type,
  });

  // Convert a RequestModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'task': task,
      'type': type,
    };
  }

  // Create a RequestModel instance from JSON
  factory TaskTrackerEventRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskTrackerEventRequestModel(
      task: json['task'],
      type: json['type'],
    );
  }
}
