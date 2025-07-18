class DashCusRemReqModel {
  DashCusRemReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;

  // Factory method to create an instance from JSON
  factory DashCusRemReqModel.fromJson(Map<String, dynamic> json) {
    return DashCusRemReqModel(
      filterUserId: json["filterUserId"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  // Method to convert the object back to JSON
  Map<String, dynamic> toJson() {
    return {
      "filterUserId": filterUserId,
      "division": division,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}
