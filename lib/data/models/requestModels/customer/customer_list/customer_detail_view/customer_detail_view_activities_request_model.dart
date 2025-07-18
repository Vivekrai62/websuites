class RequestModel {
  final String activity;
  final String customer;
  final int limit;

  RequestModel({
    required this.activity,
    required this.customer,
    required this.limit,
  });

  // Convert a JSON map to the RequestModel instance
  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      activity: json['activity'] as String,
      customer: json['customer'] as String,
      limit: json['limit'] as int,
    );
  }

  // Convert the RequestModel instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'customer': customer,
      'limit': limit,
    };
  }
}
