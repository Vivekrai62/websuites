// class LeadListGenerateProformaRequestModel {
//   String address;
//   String city;
//   String currencyId;
//   String division;
//   String email;
//   String id;
//   String name;
//   int phone;
//   List<dynamic> products;
//   String remark;
//   String type;
//
//   LeadListGenerateProformaRequestModel({
//     required this.address,
//     required this.city,
//     required this.currencyId,
//     required this.division,
//     required this.email,
//     required this.id,
//     required this.name,
//     required this.phone,
//     required this.products,
//     required this.remark,
//     required this.type,
//   });
//
//   // Convert the object to JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'address': address,
//       'city': city,
//       'currencyId': currencyId,
//       'division': division,
//       'email': email,
//       'id': id,
//       'name': name,
//       'phone': phone,
//       'products': products,
//       'remark': remark,
//       'type': type,
//     };
//   }
//
//   // Create an object from JSON
//   factory LeadListGenerateProformaRequestModel.fromJson(Map<String, dynamic> json) {
//     return LeadListGenerateProformaRequestModel(
//       address: json['address'],
//       city: json['city'],
//       currencyId: json['currencyId'],
//       division: json['division'],
//       email: json['email'],
//       id: json['id'],
//       name: json['name'],
//       phone: json['phone'],
//       products: json['products'] ?? [],
//       remark: json['remark'],
//       type: json['type'],
//     );
//   }
// }


class LeadDetailGenerateProformaRequestModel {
  String address;
  String city;
  String currencyId;
  String division;
  String email;
  String id;
  String name;
  int phone;
  List<Product> products;
  String remark;
  String type;

  LeadDetailGenerateProformaRequestModel({
    required this.address,
    required this.city,
    required this.currencyId,
    required this.division,
    required this.email,
    required this.id,
    required this.name,
    required this.phone,
    required this.products,
    required this.remark,
    required this.type,
  });

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'address': address,
      'city': city,
      'currencyId': currencyId,
      'division': division,
      'email': email,
      'id': id,
      'name': name,
      'phone': phone,
      'products': products.map((product) => product.toJson()).toList(),
      'remark': remark,
      'type': type,
    };
  }

  // Create an object from JSON
  factory LeadDetailGenerateProformaRequestModel.fromJson(Map<String, dynamic> json) {
    return LeadDetailGenerateProformaRequestModel(
      address: json['address'],
      city: json['city'],
      currencyId: json['currencyId'],
      division: json['division'],
      email: json['email'],
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      products: (json['products'] as List<dynamic>)
          .map((productJson) => Product.fromJson(productJson))
          .toList(),
      remark: json['remark'],
      type: json['type'],
    );
  }
}

class Product {
  double total;
  double gst;
  int quantity;
  double salePrice;
  String? paymentMode;
  String paymentType;
  bool isUpload;
  String id;
  String tdsOption;
  String tdsPercentage;
  int duration;
  double receivedAmount;
  int installments;
  int installmentDay;

  Product({
    required this.total,
    required this.gst,
    required this.quantity,
    required this.salePrice,
    this.paymentMode,
    required this.paymentType,
    required this.isUpload,
    required this.id,
    required this.tdsOption,
    required this.tdsPercentage,
    required this.duration,
    required this.receivedAmount,
    required this.installments,
    required this.installmentDay,
  });

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'gst': gst,
      'quantity': quantity,
      'sale_price': salePrice,
      'payment_mode': paymentMode,
      'payment_type': paymentType,
      'is_upload': isUpload,
      'id': id,
      'tds_option': tdsOption,
      'tds_percentage': tdsPercentage,
      'duration': duration,
      'received_amount': receivedAmount,
      'installments': installments,
      'installment_day': installmentDay,
    };
  }

  // Create an object from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      total: json['total'],
      gst: json['gst'],
      quantity: json['quantity'],
      salePrice: json['sale_price'],
      paymentMode: json['payment_mode'],
      paymentType: json['payment_type'],
      isUpload: json['is_upload'],
      id: json['id'],
      tdsOption: json['tds_option'],
      tdsPercentage: json['tds_percentage'],
      duration: json['duration'],
      receivedAmount: json['received_amount'],
      installments: json['installments'],
      installmentDay: json['installment_day'],
    );
  }
}
