class CustomerCompaniesRequestModel {
  String? assignedTo;
  String? customerId;
  int limit;
  int page;
  String? range;
  String? search;

  CustomerCompaniesRequestModel({
    this.assignedTo,
    this.customerId,
    required this.limit,
    required this.page,
    this.range,
    this.search,
  });

  // Convert model to JSON
  Map<String, dynamic> toJson() {
    return {
      'assigned_to': assignedTo ?? "",
      'customer_id': customerId ?? "",
      'limit': limit,
      'page': page,
      'range': range,
      'search': search ?? "",
    };
  }
}
