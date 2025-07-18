class RequestModel {
  final String? fieldId;
  final List<String>? roleIds;

  RequestModel({
    this.fieldId,
    this.roleIds,
  });

  // Converts a RequestModel instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'fieldId': fieldId,
      'roleIds': roleIds,
    };
  }

  // Factory constructor to update a RequestModel from a JSON object
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      fieldId: json['fieldId'],
      roleIds: List<String>.from(json['roleIds'] ?? []),
    );
  }
}
