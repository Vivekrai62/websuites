class CustomerNoActivityRequestModel {
  List<dynamic>? activities;
  String? assignedTo;
  bool? isFilterUserWithTeam;
  int? limit;
  int? page;

  CustomerNoActivityRequestModel({
    this.activities,
    this.assignedTo,
    this.isFilterUserWithTeam,
    this.limit,
    this.page,
  });

  // Factory method to update an instance from JSON
  factory CustomerNoActivityRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerNoActivityRequestModel(
      activities: json['activities'] ?? [],
      assignedTo: json['assignedTo'],
      isFilterUserWithTeam: json['isFilterUserWithTeam'] ?? true,
      limit: json['limit'] ?? 15,
      page: json['page'] ?? 1,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'activities': activities,
      'assignedTo': assignedTo,
      'isFilterUserWithTeam': isFilterUserWithTeam,
      'limit': limit,
      'page': page,
    };
  }
}
