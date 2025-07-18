class OrderDeleteRequest {
  String? orderId;

  OrderDeleteRequest({this.orderId});

  // Converts JSON data to OrderRequest object
  OrderDeleteRequest.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
  }

  // Converts OrderRequest object to JSON data
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    return data;
  }
}
