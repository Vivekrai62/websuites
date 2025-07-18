class StartStopResponseModels {
  String? dateTime;
  String? action;
  Null task;
  Null actionBy;
  String? id;
  String? createdAt;
  String? updatedAt;

  StartStopResponseModels(
      {this.dateTime,
      this.action,
      this.task,
      this.actionBy,
      this.id,
      this.createdAt,
      this.updatedAt});

  StartStopResponseModels.fromJson(Map<String, dynamic> json) {
    dateTime = json['date_time'];
    action = json['action'];
    task = json['task'];
    actionBy = json['action_by'];
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date_time'] = dateTime;
    data['action'] = action;
    data['task'] = task;
    data['action_by'] = actionBy;
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
