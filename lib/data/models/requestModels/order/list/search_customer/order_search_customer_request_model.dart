class OrderSearchCustomerRequestModel {
  final int limit;
  final String search;

  OrderSearchCustomerRequestModel({required this.limit, required this.search});

  // Convert the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'search': search,
    };
  }
}
