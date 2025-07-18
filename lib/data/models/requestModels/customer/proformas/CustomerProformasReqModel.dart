class CustomerProformasReqModel {
  final String? createdBy; // Changed to String? to hold the ID
  final Map<String, dynamic>? dateRange;
  final String division;
  final bool isWithTeam;
  final int limit;
  final int page;
  final String search;

  // Constructor
  CustomerProformasReqModel({
    this.createdBy, // Now a String
    this.dateRange,
    required this.division,
    required this.isWithTeam,
    required this.limit,
    required this.page,
    required this.search,
  });

  // Factory constructor to create a model from JSON
  factory CustomerProformasReqModel.fromJson(Map<String, dynamic> json) {
    return CustomerProformasReqModel(
      createdBy: json['created_by'] as String?, // Parse as String
      dateRange: json['date_range'] != null
          ? Map<String, dynamic>.from(json['date_range'])
          : null,
      division: json['division'],
      isWithTeam: json['is_with_team'],
      limit: json['limit'],
      page: json['page'],
      search: json['search'],
    );
  }

  // Method to convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'created_by': createdBy, // Send the ID as a String
      'date_range': dateRange,
      'division': division,
      'is_with_team': isWithTeam,
      'limit': limit,
      'page': page,
      'search': search,
    };
  }
}