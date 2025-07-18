class CustomerOrderlessServiceCreateRequestModel {
  String startDate;
  String endDate;
  String productId;
  int reminderBeforeExpire;
  String companyId;
  String remark;

  CustomerOrderlessServiceCreateRequestModel({
    required this.startDate,
    required this.endDate,
    required this.productId,
    required this.reminderBeforeExpire,
    required this.companyId,
    required this.remark,
  });

  Map<String, dynamic> toJson() {
    return {
      "start_date": startDate,
      "end_date": endDate,
      "productId": productId,
      "reminder_before_expire": reminderBeforeExpire,
      "companyId": companyId,
      "remark": remark,
    };
  }
}
