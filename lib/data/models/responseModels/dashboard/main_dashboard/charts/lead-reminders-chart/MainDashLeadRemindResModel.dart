class MainDashLeadRemindResModel {
  MainDashLeadRemindResModel({
    this.missing,
    this.today,
    this.upcomming,
    this.data = const [],
  });

  final int? missing;
  final int? today;
  final int? upcomming;
  final List<dynamic> data;

  factory MainDashLeadRemindResModel.fromJson(Map<String, dynamic> json) {
    return MainDashLeadRemindResModel(
      missing: json["missing"] as int?,
      today: json["today"] as int?,
      upcomming: json["upcomming"] as int?,
      data: json["data"] != null
          ? List<dynamic>.from(json["data"].map((x) => x))
          : [],
    );
  }
}
