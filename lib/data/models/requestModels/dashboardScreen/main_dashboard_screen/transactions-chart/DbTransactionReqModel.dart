class DbTransactionReqModel {
  DbTransactionReqModel({
    required this.filterUserId,
    required this.division,
    required this.isFilterUserWithTeam,
  });

  final String? filterUserId;
  final dynamic division;
  final bool? isFilterUserWithTeam;

  factory DbTransactionReqModel.fromJson(Map<String, dynamic> json) {
    return DbTransactionReqModel(
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