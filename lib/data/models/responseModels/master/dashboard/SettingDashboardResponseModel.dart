class SettingDashboardListResponseModel {
  final String? id; // Add this line
  final String? name;
  final List<String> charts;

  const SettingDashboardListResponseModel({
    this.id,
    this.name,
    this.charts = const [],
  });

  factory SettingDashboardListResponseModel.fromJson(Map<String, dynamic> json) {
    return SettingDashboardListResponseModel(
      id: json['id'] as String?, // Ensure this is included
      name: json['name'] as String?,
      charts: json['charts'] != null
          ? List<String>.from(json['charts'].map((x) => x.toString()))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'charts': charts,
  };
}