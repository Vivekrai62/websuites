class OrderCreditDebitNoteRequestModel {
  double? amount;
  String? orderProduct;
  String? remark;
  String? type;

  OrderCreditDebitNoteRequestModel({
    this.amount,
    this.orderProduct,
    this.remark,
    this.type,
  });

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'order_product': orderProduct,
      'remark': remark,
      'type': type,
    };
  }

  // Factory method to update a RequestModel from JSON
  factory OrderCreditDebitNoteRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderCreditDebitNoteRequestModel(
      amount: json['amount'] as double?,
      orderProduct: json['order_product'] as String?,
      remark: json['remark'] as String?,
      type: json['type'] as String?,
    );
  }
}
