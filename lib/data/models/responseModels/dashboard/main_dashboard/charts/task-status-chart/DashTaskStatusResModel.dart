class DashTaskStatusResModelDart {
  final TaskStatusDetail? notStarted;
  final TaskStatusDetail? inProgress;
  final TaskStatusDetail? inPending;
  final TaskStatusDetail? reOpen;
  final List<CompleteTask> complete;

  DashTaskStatusResModelDart({
    this.notStarted,
    this.inProgress,
    this.inPending,
    this.reOpen,
    required this.complete,
  });

  factory DashTaskStatusResModelDart.fromJson(Map<String, dynamic> json) {
    return DashTaskStatusResModelDart(
      notStarted: json['notStarted'] != null
          ? TaskStatusDetail.fromJson(json['notStarted'])
          : null,
      inProgress: json['inProgress'] != null
          ? TaskStatusDetail.fromJson(json['inProgress'])
          : null,
      inPending: json['inPending'] != null
          ? TaskStatusDetail.fromJson(json['inPending'])
          : null,
      reOpen: json['reOpen'] != null
          ? TaskStatusDetail.fromJson(json['reOpen'])
          : null,
      complete: (json['complete'] as List<dynamic>?)
          ?.map((e) => CompleteTask.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }
}

class TaskStatusDetail {
  final int count;
  final String id;

  TaskStatusDetail({
    required this.count,
    required this.id,
  });

  factory TaskStatusDetail.fromJson(Map<String, dynamic> json) {
    return TaskStatusDetail(
      count: json['count'] as int,
      id: json['id'] as String,
    );
  }
}

class CompleteTask {
  final String day;
  final int count;

  CompleteTask({required this.day, required this.count});

  factory CompleteTask.fromJson(Map<String, dynamic> json) {
    return CompleteTask(
      day: json['day'] as String,
      count: json['count'] as int,
    );
  }
}