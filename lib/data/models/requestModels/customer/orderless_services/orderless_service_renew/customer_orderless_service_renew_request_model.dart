class CustomerOrderlessServiceRenewRequestModel {
  final String startDate;
  final String remark;
  final String endDate;
  final int reminderBeforeExpire;

  CustomerOrderlessServiceRenewRequestModel({
    required this.startDate,
    required this.remark,
    required this.endDate,
    required this.reminderBeforeExpire,
  });

  // Convert the model to JSON to send in a request
  Map<String, dynamic> toJson() {
    return {
      'start_date': startDate,
      'remark': remark,
      'end_date': endDate,
      'reminder_before_expire': reminderBeforeExpire,
    };
  }

  // Create a model from JSON if needed
  factory CustomerOrderlessServiceRenewRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerOrderlessServiceRenewRequestModel(
      startDate: json['start_date'],
      remark: json['remark'],
      endDate: json['end_date'],
      reminderBeforeExpire: json['reminder_before_expire'],
    );
  }
}
