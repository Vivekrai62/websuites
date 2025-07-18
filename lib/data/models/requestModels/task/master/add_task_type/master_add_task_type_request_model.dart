class AddTaskTypeRequestModel {
  String name;

  AddTaskTypeRequestModel({required this.name});

  // Convert a TestingRequestModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }

  // Create a TestingRequestModel from a JSON object
  factory AddTaskTypeRequestModel.fromJson(Map<String, dynamic> json) {
    return AddTaskTypeRequestModel(
      name: json['name'],
    );
  }
}
