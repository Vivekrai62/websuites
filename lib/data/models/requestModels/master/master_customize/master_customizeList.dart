class MasterCustomizeRequestModel {
  List<String> modules;

  MasterCustomizeRequestModel({required this.modules});

  // Factory method to update a RequestModel from a JSON map
  factory MasterCustomizeRequestModel.fromJson(Map<String, dynamic> json) {
    return MasterCustomizeRequestModel(
      modules: List<String>.from(json['modules']),
    );
  }

  // Method to convert a RequestModel into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'modules': modules,
    };
  }
}