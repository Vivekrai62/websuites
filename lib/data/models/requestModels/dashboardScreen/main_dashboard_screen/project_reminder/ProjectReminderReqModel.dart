class ProjectReminderReqModel {
  ProjectReminderReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;

  factory ProjectReminderReqModel.fromJson(Map<String, dynamic> json) {
    return ProjectReminderReqModel(
      filterUserId: json["filterUser Id"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUser WithTeam"],
    );
  }

  // Add the toJson method
  Map<String, dynamic> toJson() {
    return {
      "filterUser Id": filterUserId,
      "division": division,
      "isFilterUser WithTeam": isFilterUserWithTeam,
    };
  }
}