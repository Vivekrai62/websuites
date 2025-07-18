class CustomerMasterActivationSettingCreateRequestModel {
  final List<String> ccUsers;
  final bool isSentCustomer;
  final String mailTo;
  final String service;

  CustomerMasterActivationSettingCreateRequestModel({
    required this.ccUsers,
    required this.isSentCustomer,
    required this.mailTo,
    required this.service,
  });

  // Convert a RequestModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'cc_users': ccUsers,
      'is_sent_customer': isSentCustomer,
      'mail_to': mailTo,
      'service': service,
    };
  }

  // Create a RequestModel object from JSON
  factory CustomerMasterActivationSettingCreateRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerMasterActivationSettingCreateRequestModel(
      ccUsers: List<String>.from(json['cc_users'] ?? []),
      isSentCustomer: json['is_sent_customer'] ?? false,
      mailTo: json['mail_to'] ?? '',
      service: json['service'] ?? '',
    );
  }
}
