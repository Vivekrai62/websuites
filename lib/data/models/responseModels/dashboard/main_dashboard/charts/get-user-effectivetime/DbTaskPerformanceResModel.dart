class DbTaskPerformanceResModel {
  DbTaskPerformanceResModel({
    required this.totalMinutes,
    required this.startTime,
    required this.totalHours,
  });

  final int? totalMinutes;
  final dynamic startTime;
  final int? totalHours;

  factory DbTaskPerformanceResModel.fromJson(Map<String, dynamic> json){
    return DbTaskPerformanceResModel(
      totalMinutes: json["totalMinutes"],
      startTime: json["startTime"],
      totalHours: json["total_hours"],
    );
  }
}

