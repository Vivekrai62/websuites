class DailyAnalyticsResponseModel {
  String? name;
  int? approvedAmount;
  int? totalAmount;
  int? totalOrders;  // This field may come as a String or an Integer

  // Constructor with nullable fields
  DailyAnalyticsResponseModel({
    this.name,
    this.approvedAmount,
    this.totalAmount,
    this.totalOrders,
  });

  // Factory constructor to parse the data from JSON
  factory DailyAnalyticsResponseModel.fromJson(Map<String, dynamic> json) {
    return DailyAnalyticsResponseModel(
      name: json['name'] as String?,
      approvedAmount: _parseInt(json['approvedAmount']),
      totalAmount: _parseInt(json['totalAmount']),
      totalOrders: _parseInt(json['totalOrders']),  // Safe parsing for totalOrders
    );
  }

  // Helper method to safely parse integers from dynamic values
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  // Method to convert the class back to a JSON map
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (name != null) data['name'] = name;
    if (approvedAmount != null) data['approvedAmount'] = approvedAmount;
    if (totalAmount != null) data['totalAmount'] = totalAmount;
    if (totalOrders != null) data['totalOrders'] = totalOrders;
    return data;
  }

  @override
  String toString() {
    return 'DailyAnalyticsResponseModel{name: $name, approvedAmount: $approvedAmount, totalAmount: $totalAmount, totalOrders: $totalOrders}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DailyAnalyticsResponseModel &&
        other.name == name &&
        other.approvedAmount == approvedAmount &&
        other.totalAmount == totalAmount &&
        other.totalOrders == totalOrders;
  }

  @override
  int get hashCode {
    return name.hashCode ^
    approvedAmount.hashCode ^
    totalAmount.hashCode ^
    totalOrders.hashCode;
  }
}
