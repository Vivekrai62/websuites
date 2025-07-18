class TaskListProjectSearchResponseModel {
  String? id;
  String? projectName;

  TaskListProjectSearchResponseModel({this.id, this.projectName});

  TaskListProjectSearchResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectName = json['project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_name'] = projectName;
    return data;
  }


  static List<TaskListProjectSearchResponseModel > fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) =>TaskListProjectSearchResponseModel .fromJson(json)).toList();
  }

}