class CreateReportListRequestModel {
  final String? title;
  final String? startDate;  // Changed to String to match API format
  final String? endDate;    // Changed to String to match API format
  final String? description;
  final Map<String, dynamic>? attachment;  // Changed to Map to match empty object in API
  final List<String> ccTo;
  final String? project;

  CreateReportListRequestModel({
    this.title,
    this.startDate,
    this.endDate,
    this.description,
    this.attachment,
    required this.ccTo,
    this.project,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start_date': startDate,
      'end_date': endDate,
      'description': description,
      'attachment': attachment ?? {},  // Send empty object if null
      'cc_to': ccTo,
      'project': project,
    };
  }

  factory CreateReportListRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateReportListRequestModel(
      title: json["title"],
      startDate: json["start_date"],
      endDate: json["end_date"],
      description: json["description"],
      attachment: json["attachment"] as Map<String, dynamic>? ?? {},
      ccTo: (json["cc_to"] as List<dynamic>?)?.map((x) => x.toString()).toList() ?? [],
      project: json["project"],
    );
  }

  // Helper method to create model from DateTime objects
  static CreateReportListRequestModel fromDateTime({
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    String? description,
    Map<String, dynamic>? attachment,
    required List<String> ccTo,
    String? project,
  }) {
    return CreateReportListRequestModel(
      title: title,
      startDate: startDate.toIso8601String().split('T')[0],  // Format as YYYY-MM-DD
      endDate: endDate.toIso8601String().split('T')[0],      // Format as YYYY-MM-DD
      description: description,
      attachment: attachment ?? {},
      ccTo: ccTo,
      project: project,
    );
  }
}