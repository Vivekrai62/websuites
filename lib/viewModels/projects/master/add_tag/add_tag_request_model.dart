class AddTagMasterRequestModel {
  final String name;

  AddTagMasterRequestModel({
    required this.name,
  });

  // Factory constructor to update an instance from JSON
  factory AddTagMasterRequestModel.fromJson(Map<String, dynamic> json) {
    return AddTagMasterRequestModel(
      name: json['name'] as String,
    );
  }

  // Method to convert the instance to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
