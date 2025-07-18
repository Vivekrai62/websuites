class CustomerOrderProductRenewRequestModel {
  final String serviceId;
  final String startDate;
  final String remark;
  final String endDate;
  final int reminderBeforeExpire;

  CustomerOrderProductRenewRequestModel({
    required this.serviceId,
    required this.startDate,
    required this.remark,
    required this.endDate,
    required this.reminderBeforeExpire,
  });

  // Convert the model to JSON
  Map<String, dynamic> toJson() {
    return {
      "service_id": serviceId,
      "start_date": startDate,
      "remark": remark,
      "end_date": endDate,
      "reminder_before_expire": reminderBeforeExpire,
    };
  }
}
