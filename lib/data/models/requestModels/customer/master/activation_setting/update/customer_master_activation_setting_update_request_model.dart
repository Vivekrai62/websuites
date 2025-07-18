// class ActivationSettingUpdateRequestModel {
//   final bool isSentCustomer;
//   final String mailTo;
//   final String service;
//   final List<String> ccUsers;
//
//   ActivationSettingUpdateRequestModel({
//     required this.isSentCustomer,
//     required this.mailTo,
//     required this.service,
//     required this.ccUsers,
//   });
//
//   // Convert to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'is_sent_customer': isSentCustomer,
//       'mail_to': mailTo,
//       'service': service,
//       'cc_users': ccUsers,
//     };
//   }
// }

class ActivationSettingUpdateRequestModel {
  List<String> ccUsers;
  bool isSentCustomer;
  String mailTo;
  String service;

  ActivationSettingUpdateRequestModel({
    required this.ccUsers,
    required this.isSentCustomer,
    required this.mailTo,
    required this.service,
  });

  Map<String, dynamic> toJson() {
    return {
      'cc_users': ccUsers,
      'is_sent_customer': isSentCustomer, // Boolean value
      'mail_to': mailTo,
      'service': service,
    };
  }

  factory ActivationSettingUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return ActivationSettingUpdateRequestModel(
      ccUsers: List<String>.from(json['cc_users'] ?? []),
      isSentCustomer: json['is_sent_customer'] ?? false,
      mailTo: json['mail_to'] ?? '',
      service: json['service'] ?? '',
    );
  }
}
