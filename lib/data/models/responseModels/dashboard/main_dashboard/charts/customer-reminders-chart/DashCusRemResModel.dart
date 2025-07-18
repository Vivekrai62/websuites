class DashCusRemResModel {
  DashCusRemResModel({
    required this.missing,
    required this.today,
    required this.upcomming,
    required this.data,
  });

  final int? missing;
  final int? today;
  final int? upcomming;
  final List<dynamic> data;

  factory DashCusRemResModel.fromJson(Map<String, dynamic> json){
    return DashCusRemResModel(
      missing: json["missing"],
      today: json["today"],
      upcomming: json["upcomming"],
      data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
    );
  }

}

