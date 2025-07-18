class AddLeadTypeResModel {
  final String name;
  final bool isReminderRequired;
  final dynamic subTypes;
  final dynamic activityChartLabelY;
  final String id;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int activityChartInterval;
  final String activityChartLabelX;
  final bool isSubtypeRequired;
  final bool removeFromTodo;
  final bool removeFromList;

  AddLeadTypeResModel({
    required this.name,
    required this.isReminderRequired,
    required this.subTypes,
    required this.activityChartLabelY,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.activityChartInterval,
    required this.activityChartLabelX,
    required this.isSubtypeRequired,
    required this.removeFromTodo,
    required this.removeFromList,
  });

  factory AddLeadTypeResModel.fromJson(Map<String, dynamic> json) {
    return AddLeadTypeResModel(
      name: json['name'] ?? '',
      isReminderRequired: json['isReminderRequired'] ?? false,
      subTypes: json['sub_types'],
      activityChartLabelY: json['activity_chart_label_y'],
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      activityChartInterval: json['activity_chart_interval'] ?? 0,
      activityChartLabelX: json['activity_chart_label_x'] ?? '',
      isSubtypeRequired: json['isSubtypeRequired'] ?? false,
      removeFromTodo: json['remove_from_todo'] ?? false,
      removeFromList: json['remove_from_list'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isReminderRequired': isReminderRequired,
      'sub_types': subTypes,
      'activity_chart_label_y': activityChartLabelY,
      'id': id,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'activity_chart_interval': activityChartInterval,
      'activity_chart_label_x': activityChartLabelX,
      'isSubtypeRequired': isSubtypeRequired,
      'remove_from_todo': removeFromTodo,
      'remove_from_list': removeFromList,
    };
  }
}
