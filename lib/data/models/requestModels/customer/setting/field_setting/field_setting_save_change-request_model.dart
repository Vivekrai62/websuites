// class ColumnSettingSaveChangeRequest {
//   final String id;
//   final String leadField;
//   final String? fieldName;
//   final bool? status;
//
//   ColumnSettingSaveChangeRequest({
//     required this.id,
//     required this.leadField,
//     this.fieldName,
//     this.status,
//   });
//
//   // Factory method to update an instance from JSON
//   factory ColumnSettingSaveChangeRequest.fromJson(Map<String, dynamic> json) {
//     return ColumnSettingSaveChangeRequest(
//       id: json['id'] as String,
//       leadField: json['lead_field'] as String,
//       fieldName: json['field_name'] as String?,
//       status: json['status'] as bool?,
//     );
//   }
//
//   // Method to convert an instance to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'lead_field': leadField,
//       'field_name': fieldName,
//       'status': status,
//     };
//   }
// }
//
// Helper method to convert a customer_list of JSON objects into a customer_list of model instances
// List<ColumnSettingSaveChangeRequest> parseColumnSettingList(List<dynamic> jsonList) {
//   return jsonList.map((json) => ColumnSettingSaveChangeRequest.fromJson(json)).toList();
// }




class ColumnSettingSaveChangeRequest {
  List<ColumnField> leadFields;

  ColumnSettingSaveChangeRequest({required this.leadFields});

  // Convert to JSON format (for API)
  Map<String, dynamic> toJson() {
    return {
      'leadFields': leadFields.map((field) => field.toJson()).toList(),
    };
  }
}
class ColumnField {
  String id;
  String leadField;
  String fieldName;
  bool? status;

  ColumnField({
    required this.id,
    required this.leadField,
    required this.fieldName,
    this.status = false,
  });

  // Convert to JSON format (for API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leadField': leadField,
      'fieldName': fieldName,
      'status': status,
    };
  }
}






