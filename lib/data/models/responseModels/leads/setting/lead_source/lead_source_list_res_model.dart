class LeadSourceListResModel {
  final String id;
  final String name;
  final String status;
  final DateTime? createdAt; // Keep DateTime nullable if needed

  LeadSourceListResModel({
    required this.id,
    required this.name,
    required this.status,
    this.createdAt,
  });

  factory LeadSourceListResModel.fromJson(Map<String, dynamic> json) {
    return LeadSourceListResModel(
      id: json['id'] as String? ?? '', // Default to empty string if null
      name: json['name'] as String? ?? 'Unknown', // Default to 'Unknown' if null
      status: json['status'] as String? ?? 'Unknown', // Default to 'Unknown' if null
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'] as String) // Safely parse DateTime
          : null, // Allow null for createdAt if parsing fails
    );
  }

  static List<LeadSourceListResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => LeadSourceListResModel.fromJson(json)).toList();
  }
}