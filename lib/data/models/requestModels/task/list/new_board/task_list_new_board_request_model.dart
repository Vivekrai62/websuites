class NewBoardRequestModel {
  String color;
  String name;

  NewBoardRequestModel({required this.color, required this.name});

  // Convert the RequestModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'color': color,
      'name': name,
    };
  }

  // Create a RequestModel from a JSON object
  factory NewBoardRequestModel.fromJson(Map<String, dynamic> json) {
    return NewBoardRequestModel(
      color: json['color'] ?? '',
      name: json['name'] ?? '',
    );
  }
}
