class DbPaymentReminderReqModel {
  DbPaymentReminderReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;

  factory DbPaymentReminderReqModel.fromJson(Map<String, dynamic> json) {
    return DbPaymentReminderReqModel(
      filterUserId: json["filterUserId"],
      division: json["division"],
      isFilterUserWithTeam: json["isFilterUserWithTeam"],
    );
  }

  // Add this method
  Map<String, dynamic> toJson() {
    return {
      "filterUserId": filterUserId,
      "division": division,
      "isFilterUserWithTeam": isFilterUserWithTeam,
    };
  }
}
