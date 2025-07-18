
// class LeadMasterTypesResponseModel {
// String? id;
// String? name;
// String? subTypes;
// String? status;
// String? createdAt;
// String? updatedAt;
// int? activityChartInterval;
// String? activityChartIntervalY;
// String? activityChartIntervalX;
// bool? isReminderRequired;
// bool? removeFromTodo;
// bool? removeFromList;
// List<Children>? children;
// bool? hasReminderableChildren;
//
// LeadMasterTypesResponseModel({
//   this.id,
//   this.name,
//   this.subTypes,
//   this.status,
//   this.createdAt,
//   this.updatedAt,
//   this.activityChartInterval,
//   this.activityChartIntervalY,
//   this.activityChartIntervalX,
//   this.isReminderRequired,
//   this.removeFromTodo,
//   this.removeFromList,
//   this.children,
//   this.hasReminderableChildren
// });
//
// LeadMasterTypesResponseModel.fromJson(Map<String, dynamic> json) {
// id = json['id'];
// name = json['name'];
// subTypes = json['sub_types'];
// status = json['status'];
// createdAt = json['created_at'];
// updatedAt = json['updated_at'];
// activityChartInterval = json['activity_chart_interval'];
// activityChartIntervalY = json['activity_chart_interval_y'];
// activityChartIntervalX = json['activity_chart_interval_x'];
// isReminderRequired = json['isReminderRequired'];
// removeFromTodo = json['remove_from_todo'];
// removeFromList = json['remove_from_list'];
// if (json['children'] != null) {
// children = <Children>[];
// json['children'].forEach((v) {
// children!.add(Children.fromJson(v));
// });
// hasReminderableChildren = json['hasReminderableChildren'];
// }
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = <String, dynamic>{};
// data['id'] = id;
// data['name'] = name;
// data['sub_types'] = subTypes;
// data['status'] = status;
// data['created_at'] = createdAt;
// data['updated_at'] = updatedAt;
// data['activity_chart_interval'] = activityChartInterval;
// data['activity_chart_interval_y'] = activityChartIntervalY;
// data['activity_chart_interval_x'] = activityChartIntervalX;
// data['isReminderRequired'] = isReminderRequired;
// data['remove_from_todo'] = removeFromTodo;
// data['remove_from_list'] = removeFromList;
// if (children != null) {
// data['children'] = children!.map((v) => v.toJson()).toList();
// }
// data['hasReminderableChildren'] = hasReminderableChildren;
// return data;
// }
//
// static List<LeadMasterTypesResponseModel> fromJsonList(List<dynamic> jsonList) {
// return jsonList.map((json) => LeadMasterTypesResponseModel.fromJson(json)).toList();
// }
// }

// class Children {
// String? id;
// String? name;
// String? subTypes;
// String? status;
// String? createdAt;
// String? updatedAt;
// int? activityChartInterval;
// String? activityChartLabelY;
// String? activityChartLabelX;
// bool? isReminderRequired;
// bool? removeFromTodo;
// bool? removeFromList;
//
// Children({
// this.id,
// this.name,
// this.subTypes,
// this.status,
// this.createdAt,
// this.updatedAt,
// this.activityChartInterval,
// this.activityChartLabelX,
// this.activityChartLabelY,
// this.isReminderRequired,
// this.removeFromTodo,
// this.removeFromList
// });
//
// Children.fromJson(Map<String, dynamic> json) {
// id = json['id'];
// name = json['name'];
// subTypes = json['sub_types'];
// status = json['status'];
// createdAt = json['created_at'];
// updatedAt = json['updated_at'];
// activityChartInterval = json['activity_chart_interval'];
// activityChartLabelX = json['activity_chart_label_x'];
// activityChartLabelY = json['activity_chart_label_y'];
// isReminderRequired = json['isReminderRequired'];
// removeFromTodo = json['remove_from_todo'];
// removeFromList = json['remove_from_list'];
// }
//
// Map<String, dynamic> toJson() {
// final Map<String, dynamic> data = <String, dynamic>{};
// data['id'] = id;
// data['name'] = name;
// data['sub_types'] = subTypes;
// data['status'] = status;
// data['created_at'] = createdAt;
// data['updated_at'] = updatedAt;
// data['activity_chart_label_x'] = activityChartLabelX;
// data['activity_chart_label_y'] = activityChartLabelY;
// data['activity_chart_interval'] = activityChartInterval;
// data['isReminderRequired'] = isReminderRequired;
// data['remove_from_todo'] = removeFromTodo;
// data['remove_from_list'] = removeFromList;
// return data;
// }
// }


class LeadMasterTypeResponseModel {
  String? id;
  String? name;
  dynamic subTypes; // Consider defining a specific type if possible
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  dynamic activityChartLabelY; // Consider defining a specific type if possible
  String? activityChartLabelX;
  bool? isReminderRequired;
  bool? removeFromTodo;
  bool? removeFromList;
  List<Children>? children;
  bool? hasReminderableChildren;

  LeadMasterTypeResponseModel({
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
    this.removeFromTodo,
    this.removeFromList,
    this.children,
    this.hasReminderableChildren,
  });

  factory LeadMasterTypeResponseModel.fromJson(Map<String, dynamic> json) {
    return LeadMasterTypeResponseModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subTypes: json['sub_types'], // No casting, keep as dynamic
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activityChartInterval: json['activity_chart_interval'] as int?,
      activityChartLabelY: json['activity_chart_label_y'], // No casting, keep as dynamic
      activityChartLabelX: json['activity_chart_label_x'] as String?,
      isReminderRequired: json['isReminderRequired'] as bool?,
      removeFromTodo: json['remove_from_todo'] as bool?,
      removeFromList: json['remove_from_list'] as bool?,
      children: json['children'] != null
          ? (json['children'] as List<dynamic>)
          .map((v) => Children.fromJson(v as Map<String, dynamic>))
          .toList()
          : null,
      hasReminderableChildren: json['hasReminderableChildren'] as bool?,
    );
  }

  static List<LeadMasterTypeResponseModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadMasterTypeResponseModel.fromJson(json as Map<String, dynamic>)).toList();
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
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    data['hasReminderableChildren'] = hasReminderableChildren;
    return data;
  }
}

class Children {
  String? id;
  String? name;
  dynamic subTypes; // Consider defining a specific type if possible
  String? status;
  String? createdAt;
  String? updatedAt;
  int? activityChartInterval;
  dynamic activityChartLabelY; // Consider defining a specific type if possible
  String? activityChartLabelX;
  bool? isReminderRequired;
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
    this.removeFromTodo,
    this.removeFromList,
  });

  factory Children.fromJson(Map<String, dynamic> json) {
    return Children(
      id: json['id'] as String?,
      name: json['name'] as String?,
      subTypes: json['sub_types'], // No casting, keep as dynamic
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      activityChartInterval: json['activity_chart_interval'] as int?,
      activityChartLabelY: json['activity_chart_label_y'], // No casting, keep as dynamic
      activityChartLabelX: json['activity_chart_label_x'] as String?,
      isReminderRequired: json['isReminderRequired'] as bool?,
      removeFromTodo: json['remove_from_todo'] as bool?,
      removeFromList: json['remove_from_list'] as bool?,
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
    data['remove_from_todo'] = removeFromTodo;
    data['remove_from_list'] = removeFromList;
    return data;
  }
}