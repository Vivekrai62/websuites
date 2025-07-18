class LeadListBulkDeleteRequestModel {
  final List<String> lead; // Updated field for 'lead'
  final String remark; // Added field for 'remark'

  LeadListBulkDeleteRequestModel({
    required this.lead,
    required this.remark,
  });

  // Convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'lead': lead,
      'remark': remark,
    };
  }

  // Create an object from a JSON map (optional if you need deserialization)
  factory LeadListBulkDeleteRequestModel.fromJson(Map<String, dynamic> json) {
    return LeadListBulkDeleteRequestModel(
      lead: List<String>.from(json['lead']),
      remark: json['remark'],
    );
  }
}
