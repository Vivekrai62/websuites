class CustomerActivationListRequestModel {
  final String? dateRange;
  final int limit;
  final int page;
  final String? sentBy;
  final String? service;

  CustomerActivationListRequestModel({
    this.dateRange,
    required this.limit,
    required this.page,
    this.sentBy,
    this.service,
  });

  // Optional: Add a method to convert the model to JSON format, if needed for API requests
  Map<String, dynamic> toJson() {
    return {
      'date_range': dateRange,
      'limit': limit,
      'page': page,
      'sent_by': sentBy,
      'service': service,
    };
  }
}
//
//

//NEW

// class CustomerActivationRequestModel {
//   String? dateRange;
//   int limit;
//   int page;
//   String? sentBy;
//   String? service;
//
//   // Constructor
//   CustomerActivationRequestModel({
//     this.dateRange,
//     required this.limit,
//     required this.page,
//     this.sentBy,
//     this.service,
//   });
//
//   // From JSON constructor
//   factory CustomerActivationRequestModel.fromJson(Map<String, dynamic> json) {
//     return CustomerActivationRequestModel(
//       dateRange: json['date_range'],
//       limit: json['limit'] ?? 15,  // Default value 15
//       page: json['page'] ?? 1,  // Default value 1
//       sentBy: json['sent_by'],
//       service: json['service'],
//     );
//   }
//
//   // To JSON method
//   Map<String, dynamic> toJson() {
//     return {
//       'date_range': dateRange,
//       'limit': limit,
//       'page': page,
//       'sent_by': sentBy,
//       'service': service,
//     };
//   }
// }















//NEW
