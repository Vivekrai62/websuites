class SettingDashSaveChangesRequestModel {
  final String roleId;
  final List<String> charts;

  SettingDashSaveChangesRequestModel({
    required this.roleId,
    required this.charts,
  });

  Map<String, dynamic> toJson() {
    return {
      'roleId': roleId,
      'charts': charts.map((e) => e.toString()).toList(), // Ensure each chart is converted to string
    };
  }
}