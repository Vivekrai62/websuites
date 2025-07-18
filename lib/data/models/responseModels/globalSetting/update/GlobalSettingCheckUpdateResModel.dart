// File: lib/data/models/responseModels/globalSetting/update/GlobalSettingCheckUpdateResModel.dart

class GlobalSettingUpdateResModel {
  final String message;
  final bool? success;
  final int? statusCode;
  final String? path;
  final String? timestamp;

  GlobalSettingUpdateResModel({
    required this.message,
    this.success,
    this.statusCode,
    this.path,
    this.timestamp,
  });

  factory GlobalSettingUpdateResModel.fromJson(Map<String, dynamic> json) {
    return GlobalSettingUpdateResModel(
      message: json['message'] ?? '',
      success: json['success'],
      statusCode: json['statusCode'],
      path: json['path'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'statusCode': statusCode,
      'path': path,
      'timestamp': timestamp,
    };
  }

  // Modified to handle both List and single object responses
  static List<GlobalSettingUpdateResModel> fromJsonList(dynamic jsonData) {
    // If jsonData is already a List
    if (jsonData is List) {
      return jsonData
          .map((json) => GlobalSettingUpdateResModel.fromJson(json))
          .toList();
    }
    // If jsonData is a Map (single response)
    else if (jsonData is Map<String, dynamic>) {
      return [GlobalSettingUpdateResModel.fromJson(jsonData)];
    }
    // Return empty list for unexpected data types
    return [];
  }
}