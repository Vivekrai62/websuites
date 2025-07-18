class CustomerDetailsProjectsResModel {
  CustomerDetailsProjectsResModel({
    required this.id,
    required this.projectName,
    required this.billingType,
    required this.status,
    required this.totalRate,
    required this.estimatedHours,
    required this.startDate,
    required this.deadline,
    required this.description,
    required this.demoUrl,
    required this.finishDate,
    required this.liveUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final String? projectName;
  final String? billingType;
  final String? status;
  final int? totalRate;
  final int? estimatedHours;
  final DateTime? startDate;
  final DateTime? deadline;
  final String? description;
  final String? demoUrl;
  final dynamic finishDate;
  final String? liveUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory CustomerDetailsProjectsResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsProjectsResModel(
      id: json["id"],
      projectName: json["project_name"],
      billingType: json["billing_type"],
      status: json["status"],
      totalRate: json["total_rate"],
      estimatedHours: json["estimated_hours"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      deadline: DateTime.tryParse(json["deadline"] ?? ""),
      description: json["description"],
      demoUrl: json["demo_url"],
      finishDate: json["finish_date"],
      liveUrl: json["live_url"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsProjectsResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerDetailsProjectsResModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}