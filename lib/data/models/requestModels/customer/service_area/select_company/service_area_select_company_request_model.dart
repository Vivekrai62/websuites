class ServiceAreaSelectCompanyRequestModel {
  final int limit;
  final int page;
  final String customerId;

  ServiceAreaSelectCompanyRequestModel({
    required this.limit,
    required this.page,
    required this.customerId,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'page': page,
      'customer_id': customerId,
    };
  }

  // Factory method to update model from JSON
  factory ServiceAreaSelectCompanyRequestModel.fromJson(Map<String, dynamic> json) {
    return ServiceAreaSelectCompanyRequestModel(
      limit: json['limit'],
      page: json['page'],
      customerId: json['customer_id'],
    );
  }
}
