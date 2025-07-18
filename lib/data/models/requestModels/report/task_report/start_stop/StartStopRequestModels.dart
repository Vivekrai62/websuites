class StartStopRequestModels {
  String? task;
  String? type;

  StartStopRequestModels({this.task, this.type});

  StartStopRequestModels.fromJson(Map<String, dynamic> json) {
    task = json['task'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['task'] = task;
    data['type'] = type;
    return data;
  }
}
