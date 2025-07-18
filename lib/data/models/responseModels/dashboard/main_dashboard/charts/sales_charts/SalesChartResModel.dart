class SalesChartResModel {
  SalesChartResModel({
    required this.statusCode,
    required this.timestamp,
    required this.path,
    required this.message,
  });

  final int? statusCode;
  final DateTime? timestamp;
  final String? path;
  final String? message;

  factory SalesChartResModel.fromJson(Map<String, dynamic> json){
    return SalesChartResModel(
      statusCode: json["statusCode"],
      timestamp: DateTime.tryParse(json["timestamp"] ?? ""),
      path: json["path"],
      message: json["message"],
    );
  }

}

