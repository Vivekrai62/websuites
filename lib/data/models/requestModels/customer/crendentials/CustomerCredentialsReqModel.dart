class CustomerCredentialsReqModel {
  String assignedTo;
  String customerId;
  int limit;
  int page;
  dynamic range;
  String search;

  CustomerCredentialsReqModel({
    required this.assignedTo,
    required this.customerId,
    required this.limit,
    required this.page,
    this.range,
    required this.search,
  });

  // Convert JSON to Dart object
  factory CustomerCredentialsReqModel.fromJson(Map<String, dynamic> json) {
    return CustomerCredentialsReqModel(
      assignedTo: json['assigned_to'] ?? '',
      customerId: json['customer_id'] ?? '',
      limit: json['limit'] ?? 30,
      page: json['page'] ?? 1,
      range: json['range'],
      search: json['search'] ?? '',
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'assigned_to': assignedTo,
      'customer_id': customerId,
      'limit': limit,
      'page': page,
      'range': range,
      'search': search,
    };
  }
}
