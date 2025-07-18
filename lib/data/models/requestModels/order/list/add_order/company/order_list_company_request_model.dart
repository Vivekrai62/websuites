class OrderCompanyRequestModel {
  final String customerId;
  final int limit;
  final int page;
  final String? range;
  final String search;

  OrderCompanyRequestModel({
    required this.customerId,
    required this.limit,
    required this.page,
    this.range,
    required this.search,
  });

  // Convert JSON to RequestModel
  factory OrderCompanyRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderCompanyRequestModel(
      customerId: json['customer_id'],
      limit: json['limit'],
      page: json['page'],
      range: json['range'],
      search: json['search'],
    );
  }

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'limit': limit,
      'page': page,
      'range': range,
      'search': search,
    };
  }
}
