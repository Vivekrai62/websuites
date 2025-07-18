class CustomizeLeadSourceRequestModel {
  List<String> modules;

  CustomizeLeadSourceRequestModel({required this.modules});

  // Factory method to update a RequestModel from a JSON map
  factory CustomizeLeadSourceRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomizeLeadSourceRequestModel(
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