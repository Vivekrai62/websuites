class SalesAddTargetRequestModel {
  String? name;
  String? startDate;
  String? endDate;
  int? saleTarget;
  String? teamHead;

  SalesAddTargetRequestModel({
    this.name,
    this.startDate,
    this.endDate,
    this.saleTarget,
    this.teamHead,
  });

  // Factory constructor to update an instance from JSON
  factory SalesAddTargetRequestModel.fromJson(Map<String, dynamic> json) {
    return SalesAddTargetRequestModel(
      name: json['name'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      saleTarget: json['sale_target'] as int?,
      teamHead: json['team_head'] as String?,
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'sale_target': saleTarget,
      'team_head': teamHead,
    };
  }
}
