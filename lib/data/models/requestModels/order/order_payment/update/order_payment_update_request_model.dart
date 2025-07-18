// class OrderPaymentUpdateRequestModel {
//   final int amount;
//
//   OrderPaymentUpdateRequestModel({required this.amount});
//
//   // Convert the model to a JSON object for API requests
//   Map<String, dynamic> toJson() {
//     return {
//       'amount': amount,
//     };
//   }
// }


class OrderPaymentUpdateRequestModel {
  final int amount;

  OrderPaymentUpdateRequestModel({required this.amount});

  // Convert RequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
    };
  }

  // Create RequestModel from JSON
  factory OrderPaymentUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    return OrderPaymentUpdateRequestModel(
      amount: json['amount'],
    );
  }
}



// class OrderPaymentUpdateRequestModel {
//   final double amount;
//
//   OrderPaymentUpdateRequestModel({
//     required this.amount
//   });
//
//   Map<String, dynamic> toJson() => {
//     'amount': amount, // Ensures it's a number
//   };
//
//   factory OrderPaymentUpdateRequestModel.fromJson(Map<String, dynamic> json) {
//     return OrderPaymentUpdateRequestModel(
//         amount: (json['amount'] as num).toDouble()
//     );
//   }
// }


