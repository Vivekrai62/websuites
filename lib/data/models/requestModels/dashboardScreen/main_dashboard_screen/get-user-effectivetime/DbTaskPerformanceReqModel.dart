class DbTaskPerformanceReqModel {
  DbTaskPerformanceReqModel({
    required this.date,
    required this.filterUserId,
    required this.isFilterUserWithTeam,
  });

  final DateTime? date;
  final String? filterUserId;
  final bool? isFilterUserWithTeam;

  // Factory method to create an instance from JSON
  factory DbTaskPerformanceReqModel.fromJson(Map<String, dynamic> json) {
    return DbTaskPerformanceReqModel(
      date: json["date"] != null ? DateTime.tryParse(json["date"]) : null,
      filterUserId: json["filterUserId"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  // Method to convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      "date": date?.toIso8601String(),
      "filterUserId": filterUserId,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}
