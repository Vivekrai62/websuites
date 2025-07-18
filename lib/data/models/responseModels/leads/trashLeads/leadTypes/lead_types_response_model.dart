class LeadTypesResponseModel {
  String? id;
  String? name;
  dynamic subTypes; // replaced Null? with dynamic
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  dynamic activityChartLabelY; // replaced Null? with dynamic
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? isSubtypeRequired;
  bool? removeFromTodo;
  bool? removeFromList;
  List<Children>? children;
  bool? hasReminderableChildren;

  LeadTypesResponseModel({
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
    this.children,
    this.hasReminderableChildren,
  });

  factory LeadTypesResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadTypesResponseModel(
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
      children: json['children'] != null
          ? (json['children'] as List)
          .map((e) => Children.fromJson(e))
          .toList()
          : null,
      hasReminderableChildren: json['hasReminderableChildren'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_types': subTypes,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'activity_chart_interval': activityChartInterval,
      'activity_chart_label_y': activityChartLabelY,
      'activity_chart_label_x': activityChartLabelX,
      'isReminderRequired': isReminderRequired,
      'isSubtypeRequired': isSubtypeRequired,
      'remove_from_todo': removeFromTodo,
      'remove_from_list': removeFromList,
      'children': children?.map((e) => e.toJson()).toList(),
      'hasReminderableChildren': hasReminderableChildren,
    };
  }

  /// ✅ Static method to parse list
  static List<LeadTypesResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => LeadTypesResponseModel.fromJson(json))
        .toList();
  }
}

class Children {
  String? id;
  String? name;
  dynamic subTypes; // replaced Null? with dynamic
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  dynamic activityChartLabelY; // replaced Null? with dynamic
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? isSubtypeRequired;
  bool? removeFromTodo;
  bool? removeFromList;

  Children({
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

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
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
    return {
      'id': id,
      'name': name,
      'sub_types': subTypes,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'activity_chart_interval': activityChartInterval,
      'activity_chart_label_y': activityChartLabelY,
      'activity_chart_label_x': activityChartLabelX,
      'isReminderRequired': isReminderRequired,
      'isSubtypeRequired': isSubtypeRequired,
      'remove_from_todo': removeFromTodo,
      'remove_from_list': removeFromList,
    };
  }
}
