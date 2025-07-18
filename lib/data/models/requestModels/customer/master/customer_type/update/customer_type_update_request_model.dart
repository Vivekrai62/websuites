// class CustomerTypeUpdateRequestModel {
//   final String name;
//   final bool status;
//
//   CustomerTypeUpdateRequestModel({required this.name, required this.status});
//
//   // Factory method for creating an instance from a map (e.g., JSON)
//   factory CustomerTypeUpdateRequestModel.fromJson(Map<String, dynamic> json) {
//     return CustomerTypeUpdateRequestModel(
//       name: json['name'],
//       status: json['status'],
//     );
//   }
//
//   // Method to convert the instance back to a map (e.g., for sending as JSON)
//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'status': status,
//     };
//   }
// }

class CustomerTypeUpdateRequestModel {
  final String name;
  final bool status; // Ensure this is a bool

  CustomerTypeUpdateRequestModel({required this.name, required this.status});

  factory CustomerTypeUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerTypeUpdateRequestModel(
      name: json['name'],
      status: json['status'] == true, // Ensure status is treated as a boolean
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'status': status, // status should already be a bool
    };
  }
}
