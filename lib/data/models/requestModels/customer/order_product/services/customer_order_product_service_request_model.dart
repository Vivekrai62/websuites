class OrderProductServiceRequestModel {
  final String orderProduct;
  final String startDate;
  final String remark;
  final String endDate;
  final int reminderBeforeExpire;

  OrderProductServiceRequestModel({
    required this.orderProduct,
    required this.startDate,
    required this.remark,
    required this.endDate,
    required this.reminderBeforeExpire,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "order_product": orderProduct,
      "start_date": startDate,
      "remark": remark,
      "end_date": endDate,
      "reminder_before_expire": reminderBeforeExpire,
    };
  }
}
