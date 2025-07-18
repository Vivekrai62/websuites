class LeadListBulkUnAssignRequestModel {
  final List<String> lead;

  LeadListBulkUnAssignRequestModel({required this.lead});

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'lead': lead,
    };
  }

  // Create RequestModel from JSON
  factory LeadListBulkUnAssignRequestModel.fromJson(Map<String, dynamic> json) {
    return LeadListBulkUnAssignRequestModel(
      lead: List<String>.from(json['lead'] ?? []),
    );
  }
}
