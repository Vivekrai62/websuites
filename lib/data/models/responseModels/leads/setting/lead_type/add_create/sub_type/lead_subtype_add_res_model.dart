
class LeadSubTypeAddResModel {
  String? name;
  Parent? parent;
  bool? isReminderRequired;
  dynamic subTypes;
  String? activityChartLabelY;
  String? id;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  String? activityChartLabelX;
  bool? isSubtypeRequired;
  bool? removeFromTodo;
  bool? removeFromList;

  LeadSubTypeAddResModel({
    this.name,
    this.parent,
    this.isReminderRequired,
    this.subTypes,
    this.activityChartLabelY,
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.activityChartInterval,
    this.activityChartLabelX,
    this.isSubtypeRequired,
    this.removeFromTodo,
    this.removeFromList,
  });

  factory LeadSubTypeAddResModel.fromJson(Map<String, dynamic> json) {
    return LeadSubTypeAddResModel(
      name: json['name'],
      parent: json['parent'] != null ? Parent.fromJson(json['parent']) : null,
      isReminderRequired: json['isReminderRequired'],
      subTypes: json['sub_types'],
      activityChartLabelY: json['activity_chart_label_y'],
      id: json['id'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      activityChartInterval: json['activity_chart_interval'],
      activityChartLabelX: json['activity_chart_label_x'],
      isSubtypeRequired: json['isSubtypeRequired'],
      removeFromTodo: json['remove_from_todo'],
      removeFromList: json['remove_from_list'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    data['isReminderRequired'] = isReminderRequired;
    data['sub_types'] = subTypes;
    data['activity_chart_label_y'] = activityChartLabelY;
    data['id'] = id;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['activity_chart_interval'] = activityChartInterval;
    data['activity_chart_label_x'] = activityChartLabelX;
    data['isSubtypeRequired'] = isSubtypeRequired;
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    return data;
  }
}

class Parent {
  String? id;
  String? name;
  dynamic subTypes;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  String? activityChartLabelY;
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? isSubtypeRequired;
  bool? removeFromTodo;
  bool? removeFromList;

  Parent({
    this.id,
    this.name,
    this.subTypes,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.activityChartInterval,
    this.activityChartLabelY,
    this.activityChartLabelX,
    this.isReminderRequired,
    this.isSubtypeRequired,
    this.removeFromTodo,
    this.removeFromList,
  });

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(
      id: json['id'],
      name: json['name'],
      subTypes: json['sub_types'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      activityChartInterval: json['activity_chart_interval'],
      activityChartLabelY: json['activity_chart_label_y'],
      activityChartLabelX: json['activity_chart_label_x'],
      isReminderRequired: json['isReminderRequired'],
      isSubtypeRequired: json['isSubtypeRequired'],
      removeFromTodo: json['remove_from_todo'],
      removeFromList: json['remove_from_list'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    data['sub_types'] = subTypes;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['activity_chart_interval'] = activityChartInterval;
    data['activity_chart_label_y'] = activityChartLabelY;
    data['activity_chart_label_x'] = activityChartLabelX;
    data['isReminderRequired'] = isReminderRequired;
    data['isSubtypeRequired'] = isSubtypeRequired;
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    return data;
  }
}
