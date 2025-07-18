class PaymentStatusChangeRequestModel {
  String? paymentId;
  String? remark;
  String? status;

  PaymentStatusChangeRequestModel({this.paymentId, this.remark, this.status});

  // Convert a PaymentRequestModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'remark': remark,
      'status': status,
    };
  }

  // Create a PaymentRequestModel instance from JSON
  factory PaymentStatusChangeRequestModel.fromJson(Map<String, dynamic> json) {
    return PaymentStatusChangeRequestModel(
      paymentId: json['payment_id'],
      remark: json['remark'],
      status: json['status'],
    );
  }
}
