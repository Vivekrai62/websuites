class TaskMasterUpdateRequestModel {
  TaskMasterUpdateRequestModel({
    required this.name,
    required this.status,
  });

  final String name;
  final bool status;

  factory TaskMasterUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return TaskMasterUpdateRequestModel(
      name: json["name"] as String, // Casting to String to ensure non-null
      status: json["status"] as bool, // Casting to bool to ensure non-null
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'status': status,
  };
}