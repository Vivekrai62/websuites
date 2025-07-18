class DbProjecStatusResModel {
  DbProjecStatusResModel({
    required this.notStarted,
    required this.inProgress,
    required this.onHold,
    required this.complete,
  });

  final int? notStarted;
  final int? inProgress;
  final int? onHold;
  final List<Complete> complete;

  factory DbProjecStatusResModel.fromJson(Map<String, dynamic> json) {
    return DbProjecStatusResModel(
      notStarted: json["notStarted"],
      inProgress: json["inProgress"],
      onHold: json["onHold"],
      complete: json["complete"] == null
          ? []
          : List<Complete>.from(json["complete"].map((x) => Complete.fromJson(x))),
    );
  }
}

class Complete {
  Complete({
    required this.month,
    required this.count,
  });

  final String? month;
  final int? count;

  factory Complete.fromJson(Map<String, dynamic> json) {
    return Complete(
      month: json["month"],
      count: json["count"],
    );
  }
}