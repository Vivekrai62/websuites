class NoActivitiesRequestModel {
  List<dynamic> activities;
  String assignedTo;
  dynamic days; // Use int or String depending on your requirement
  bool isFilterUserWithTeam;
  int limit;
  int page;

  NoActivitiesRequestModel({
    required this.activities,
    required this.assignedTo,
    this.days, // Optional
    required this.isFilterUserWithTeam,
    required this.limit,
    required this.page,
  });

  // Factory method to update an instance from a JSON map
  factory NoActivitiesRequestModel.fromJson(Map<String, dynamic> json) {
    return NoActivitiesRequestModel(
      activities: json['activities'] ?? [],
      assignedTo: json['assignedTo'] ?? "",
      days: json['days'], // Adjust type based on your requirements
      isFilterUserWithTeam: json['isFilterUserWithTeam'] ?? false,
      limit: json['limit'] ?? 0,
      page: json['page'] ?? 0,
    );
  }

  // Method to convert the instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'activities': activities,
      'assignedTo': assignedTo,
      'days': days,
      'isFilterUserWithTeam': isFilterUserWithTeam,
      'limit': limit,
      'page': page,
    };
  }
}

