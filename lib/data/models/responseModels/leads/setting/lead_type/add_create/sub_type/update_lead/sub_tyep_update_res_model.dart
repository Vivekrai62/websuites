class LeadSubtypeUpdateResModel {
  String? id;
  String? name;
  dynamic subTypes; // changed from Null? to dynamic to support any type including null
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  dynamic activityChartLabelY; // changed from Null? to dynamic for future flexibility
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? isSubtypeRequired;

  LeadSubtypeUpdateResModel({
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
  });

  factory LeadSubtypeUpdateResModel.fromJson(Map<String, dynamic> json) {
    return LeadSubtypeUpdateResModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subTypes: json['sub_types'],
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activityChartInterval: json['activity_chart_interval'] as int?,
      activityChartLabelY: json['activity_chart_label_y'],
      activityChartLabelX: json['activity_chart_label_x'] as String?,
      isReminderRequired: json['isReminderRequired'] as bool?,
      isSubtypeRequired: json['isSubtypeRequired'] as bool?,
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
    };
  }
}
