class LeadTypeUpdateResModel {
  final String? id;
  final String? name;
  final dynamic? subTypes; // replace `dynamic?` with a more specific type if available
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final int? activityChartInterval;
  final dynamic? activityChartLabelY; // replace `dynamic?` with a more specific type if available
  final String? activityChartLabelX;
  final bool? isReminderRequired;
  final bool? isSubtypeRequired;

  LeadTypeUpdateResModel({
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

  factory LeadTypeUpdateResModel.fromJson(Map<String, dynamic> json) {
    return LeadTypeUpdateResModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subTypes: json['sub_types'], // dynamic? (could be List<Something> or Map<String, dynamic>, etc.)
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activityChartInterval: json['activity_chart_interval'] is int
          ? json['activity_chart_interval'] as int
          : int.tryParse(json['activity_chart_interval']?.toString() ?? ''),
      activityChartLabelY: json['activity_chart_label_y'], // dynamic?
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
