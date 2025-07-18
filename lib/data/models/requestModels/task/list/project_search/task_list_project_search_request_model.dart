class ProjectSearchRequestModel {
  String search;

  ProjectSearchRequestModel({required this.search});

  // Convert the RequestModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'search': search,
    };
  }

  // Create a RequestModel from a JSON object
  factory ProjectSearchRequestModel.fromJson(Map<String, dynamic> json) {
    return ProjectSearchRequestModel(
      search: json['search'] ?? '',
    );
  }
}
