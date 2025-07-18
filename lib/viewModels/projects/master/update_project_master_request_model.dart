class UpdateProjectMasterRequestModel {
  final String name;
  final bool status;

  UpdateProjectMasterRequestModel({
    required this.name,
    required this.status,
  });

  // Factory constructor to update an UpdateProjectMasterRequestModel from JSON
  factory UpdateProjectMasterRequestModel.fromJson(Map<String, dynamic> json) {
    return UpdateProjectMasterRequestModel(
      name: json['name'],
      status: json['status'],
    );
  }

  // Method to convert UpdateProjectMasterRequestModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status,
    };
  }
}
