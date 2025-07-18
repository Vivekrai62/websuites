// class CustomerActivationListResponseModel {
//   List<Item>? items;
//   Meta? meta;
//   String? userKey;
//
//   CustomerActivationListResponseModel({this.items, this.meta, this.userKey});
//
//   factory CustomerActivationListResponseModel.fromJson(Map<String, dynamic> json) {
//     return CustomerActivationListResponseModel(
//       items: json['items'] != null
//           ? List<Item>.from(json['items'].map((v) => Item.fromJson(v)))
//           : null,
//       meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
//       userKey: json['user_key'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'items': items?.map((v) => v.toJson()).toList(),
//       'meta': meta?.toJson(),
//       'user_key': userKey,
//     };
//   }
// }
//
// class Item {
//   String? id;
//   String? requestData;
//   String? customerSubmissionDate;
//   String? approvalDate;
//   String? createdAt;
//   String? updatedAt;
//   OrderProduct? orderProduct;
//   ActivationFor? activationFor;
//   CreatedBy? createdBy;
//   String? project;
//
//   Item({
//     this.id,
//     this.requestData,
//     this.customerSubmissionDate,
//     this.approvalDate,
//     this.createdAt,
//     this.updatedAt,
//     this.orderProduct,
//     this.activationFor,
//     this.createdBy,
//     this.project,
//   });
//
//   factory Item.fromJson(Map<String, dynamic> json) {
//     return Item(
//       id: json['id'],
//       requestData: json['request_data'],
//       customerSubmissionDate: json['customer_submission_date'],
//       approvalDate: json['approval_date'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       orderProduct: json['order_product'] != null
//           ? OrderProduct.fromJson(json['order_product'])
//           : null,
//       activationFor: json['activation_for'] != null
//           ? ActivationFor.fromJson(json['activation_for'])
//           : null,
//       createdBy: json['created_by'] != null
//           ? CreatedBy.fromJson(json['created_by'])
//           : null,
//       project: json['project'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'request_data': requestData,
//       'customer_submission_date': customerSubmissionDate,
//       'approval_date': approvalDate,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'order_product': orderProduct?.toJson(),
//       'activation_for': activationFor?.toJson(),
//       'created_by': createdBy?.toJson(),
//       'project': project,
//     };
//   }
// }
//
// class OrderProduct {
//   String? id;
//   String? productType;
//   String? paymentMode;
//   String? paymentType;
//   int? mrp;
//   int? salePrice;
//   int? gst;
//   int? gstPercentage;
//   String? tdsOption;
//   int? tds;
//   int? tdsPercentage;
//   String? gstInfo;
//   int? total;
//   int? quantity;
//   int? duration;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   Product? product;
//   Order? order;
//
//   OrderProduct({
//     this.id,
//     this.productType,
//     this.paymentMode,
//     this.paymentType,
//     this.mrp,
//     this.salePrice,
//     this.gst,
//     this.gstPercentage,
//     this.tdsOption,
//     this.tds,
//     this.tdsPercentage,
//     this.gstInfo,
//     this.total,
//     this.quantity,
//     this.duration,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.product,
//     this.order,
//   });
//
//   factory OrderProduct.fromJson(Map<String, dynamic> json) {
//     return OrderProduct(
//       id: json['id'],
//       productType: json['product_type'],
//       paymentMode: json['payment_mode'],
//       paymentType: json['payment_type'],
//       mrp: json['mrp'],
//       salePrice: json['sale_price'],
//       gst: json['gst'],
//       gstPercentage: json['gst_percentage'],
//       tdsOption: json['tds_option'],
//       tds: json['tds'],
//       tdsPercentage: json['tds_percentage'],
//       gstInfo: json['gst_info'],
//       total: json['total'],
//       quantity: json['quantity'],
//       duration: json['duration'],
//       status: json['status'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       deletedAt: json['deleted_at'],
//       product: json['product'] != null ? Product.fromJson(json['product']) : null,
//       order: json['order'] != null ? Order.fromJson(json['order']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'product_type': productType,
//       'payment_mode': paymentMode,
//       'payment_type': paymentType,
//       'mrp': mrp,
//       'sale_price': salePrice,
//       'gst': gst,
//       'gst_percentage': gstPercentage,
//       'tds_option': tdsOption,
//       'tds': tds,
//       'tds_percentage': tdsPercentage,
//       'gst_info': gstInfo,
//       'total': total,
//       'quantity': quantity,
//       'duration': duration,
//       'status': status,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'deleted_at': deletedAt,
//       'product': product?.toJson(),
//       'order': order?.toJson(),
//     };
//   }
// }

// class Product {
//   String? id;
//   String? productType;
//   String? name;
//   String? description;
//   int? mrp;
//   int? salePrice;
//   int? quantity;
//   int? duration;
//   String? downloadLink;
//   String? packing;
//   bool? status;
//   bool? isTaxable;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? zohoItemId;
//   bool? projectActivationDisabled;
//
//   Product({
//     this.id,
//     this.productType,
//     this.name,
//     this.description,
//     this.mrp,
//     this.salePrice,
//     this.quantity,
//     this.duration,
//     this.downloadLink,
//     this.packing,
//     this.status,
//     this.isTaxable,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.zohoItemId,
//     this.projectActivationDisabled,
//   });
//
//   factory Product.fromJson(Map<String, dynamic> json) {
//     return Product(
//       id: json['id'],
//       productType: json['product_type'],
//       name: json['name'],
//       description: json['description'],
//       mrp: json['mrp'],
//       salePrice: json['sale_price'],
//       quantity: json['quantity'],
//       duration: json['duration'],
//       downloadLink: json['download_link'],
//       packing: json['packing'],
//       status: json['status'],
//       isTaxable: json['is_taxable'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       deletedAt: json['deleted_at'],
//       zohoItemId: json['zoho_item_id'],
//       projectActivationDisabled: json['project_activation_disabled'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'product_type': productType,
//       'name': name,
//       'description': description,
//       'mrp': mrp,
//       'sale_price': salePrice,
//       'quantity': quantity,
//       'duration': duration,
//       'download_link': downloadLink,
//       'packing': packing,
//       'status': status,
//       'is_taxable': isTaxable,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'deleted_at': deletedAt,
//       'zoho_item_id': zohoItemId,
//       'project_activation_disabled': projectActivationDisabled,
//     };
//   }
// }
//
// class Order {
//   String? id;
//   int? orderNumber;
//   int? gstFees;
//   int? tdsPercentage;
//   int? amount;
//   int? tdsAmount;
//   int? totalAmount;
//   int? payableAmount;
//   String? performaInvoice;
//   String? status;
//   String? remark;
//   String? createdAt;
//   String? updatedAt;
//   String? deletedAt;
//   String? deleteRemark;
//   String? zohoSalesOrderId;
//   Company? company;
//
//   Order({
//     this.id,
//     this.orderNumber,
//     this.gstFees,
//     this.tdsPercentage,
//     this.amount,
//     this.tdsAmount,
//     this.totalAmount,
//     this.payableAmount,
//     this.performaInvoice,
//     this.status,
//     this.remark,
//     this.createdAt,
//     this.updatedAt,
//     this.deletedAt,
//     this.deleteRemark,
//     this.zohoSalesOrderId,
//     this.company,
//   });
//
//   factory Order.fromJson(Map<String, dynamic> json) {
//     return Order(
//       id: json['id'],
//       orderNumber: json['order_number'],
//       gstFees: json['gst_fees'],
//       tdsPercentage: json['tds_percentage'],
//       amount: json['amount'],
//       tdsAmount: json['tds_amount'],
//       totalAmount: json['total_amount'],
//       payableAmount: json['payable_amount'],
//       performaInvoice: json['performa_invoice'],
//       status: json['status'],
//       remark: json['remark'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//       deletedAt: json['deleted_at'],
//       deleteRemark: json['delete_remark'],
//       zohoSalesOrderId: json['zoho_sales_order_id'],
//       company: json['company'] != null ? Company.fromJson(json['company']) : null,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'order_number': orderNumber,
//       'gst_fees': gstFees,
//       'tds_percentage': tdsPercentage,
//       'amount': amount,
//       'tds_amount': tdsAmount,
//       'total_amount': totalAmount,
//       'payable_amount': payableAmount,
//       'performa_invoice': performaInvoice,
//       'status': status,
//       'remark': remark,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//       'deleted_at': deletedAt,
//       'delete_remark': deleteRemark,
//       'zoho_sales_order_id': zohoSalesOrderId,
//       'company': company?.toJson(),
//     };
//   }
// }
//
// class Company {
//   String? id;
//   String? name;
//   String? description;
//   String? createdAt;
//   String? updatedAt;
//
//   Company({this.id, this.name, this.description, this.createdAt, this.updatedAt});
//
//   factory Company.fromJson(Map<String, dynamic> json) {
//     return Company(
//       id: json['id'],
//       name: json['name'],
//       description: json['description'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }
//
// class ActivationFor {
//   String? id;
//   String? name;
//
//   ActivationFor({this.id, this.name});
//
//   factory ActivationFor.fromJson(Map<String, dynamic> json) {
//     return ActivationFor(
//       id: json['id'],
//       name: json['name'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//     };
//   }
// }
//
// class CreatedBy {
//   String? id;
//   String? name;
//   String? email;
//
//   CreatedBy({this.id, this.name, this.email});
//
//   factory CreatedBy.fromJson(Map<String, dynamic> json) {
//     return CreatedBy(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }
//
//
//

//NEW

class CustomerActivationListResponseModel {
  final List<Item> items;
  Meta? meta;
  String? userKey;

  CustomerActivationListResponseModel({required this.items});

  factory CustomerActivationListResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerActivationListResponseModel(
      items: (json['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList(),
    );
  }
}

class Item {
  final String id;
  final String? requestData;
  final String? customerSubmissionDate;
  final String? approvalDate;
  final String createdAt;
  final String updatedAt;
  final OrderProduct orderProduct;
  final ActivationFor activationFor;
  final CreatedBy createdBy;
  final dynamic project;

  Item({
    required this.id,
    this.requestData,
    this.customerSubmissionDate,
    this.approvalDate,
    required this.createdAt,
    required this.updatedAt,
    required this.orderProduct,
    required this.activationFor,
    required this.createdBy,
    this.project,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] ?? '', // Ensure non-null value
      requestData: json['request_data'] ?? '', // Provide fallback for null
      customerSubmissionDate: json['customer_submission_date'] ?? '', // Provide fallback for null
      approvalDate: json['approval_date'] ?? '', // Provide fallback for null
      createdAt: json['created_at'] ?? '', // Provide fallback for null
      updatedAt: json['updated_at'] ?? '', // Provide fallback for null
      orderProduct: OrderProduct.fromJson(json['order_product'] ?? {}), // Handle missing data gracefully
      activationFor: ActivationFor.fromJson(json['activation_for'] ?? {}), // Handle missing data gracefully
      createdBy: CreatedBy.fromJson(json['created_by'] ?? {}), // Handle missing data gracefully
      project: json['project'], // Leave as nullable
    );
  }
}

class OrderProduct {
  final String id;
  final String productType;
  final String paymentMode;
  final String paymentType;
  final double mrp;
  final double salePrice;
  final double gst;
  final double gstPercentage;
  final String tdsOption;
  final double tds;
  final double tdsPercentage;
  final String gstInfo;
  final double total;
  final int quantity;
  final int duration;
  final String status;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final Product product;
  final Order order;

  OrderProduct({
    required this.id,
    required this.productType,
    required this.paymentMode,
    required this.paymentType,
    required this.mrp,
    required this.salePrice,
    required this.gst,
    required this.gstPercentage,
    required this.tdsOption,
    required this.tds,
    required this.tdsPercentage,
    required this.gstInfo,
    required this.total,
    required this.quantity,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.product,
    required this.order,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'] ?? '', // Ensure non-null value
      productType: json['product_type'] ?? '', // Provide fallback for null
      paymentMode: json['payment_mode'] ?? '', // Provide fallback for null
      paymentType: json['payment_type'] ?? '', // Provide fallback for null
      mrp: (json['mrp'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      salePrice: (json['sale_price'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      gst: (json['gst'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      gstPercentage: (json['gst_percentage'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      tdsOption: json['tds_option'] ?? '', // Provide fallback for null
      tds: (json['tds'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      tdsPercentage: (json['tds_percentage'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      gstInfo: json['gst_info'] ?? '', // Provide fallback for null
      total: (json['total'] ?? 0.0).toDouble(), // Fallback to 0.0 for null or invalid types
      quantity: json['quantity'] ?? 0, // Fallback to 0 for null or invalid types
      duration: json['duration'] ?? 0, // Fallback to 0 for null or invalid types
      status: json['status'] ?? '', // Provide fallback for null
      createdAt: json['created_at'] ?? '', // Provide fallback for null
      updatedAt: json['updated_at'] ?? '', // Provide fallback for null
      deletedAt: json['deleted_at'], // Leave as nullable
      product: Product.fromJson(json['product'] ?? {}), // Handle missing data gracefully
      order: Order.fromJson(json['order'] ?? {}), // Handle missing data gracefully
    );
  }
}




class Product {
  final String id;
  final String productType;
  final String? serviceType;
  final String name;
  final String description;
  final double mrp;
  final double salePrice;
  final int quantity;
  final int duration;
  final String downloadLink;
  final String packing;
  final bool status;
  final bool isTaxable;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final bool distributorshipOnly;
  final String zohoItemId;
  final bool projectActivationDisabled;

  Product({
    required this.id,
    required this.productType,
    this.serviceType,
    required this.name,
    required this.description,
    required this.mrp,
    required this.salePrice,
    required this.quantity,
    required this.duration,
    required this.downloadLink,
    required this.packing,
    required this.status,
    required this.isTaxable,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.distributorshipOnly,
    required this.zohoItemId,
    required this.projectActivationDisabled,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productType: json['product_type'],
      serviceType: json['service_type'],
      name: json['name'],
      description: json['description'],
      mrp: json['mrp'].toDouble(),
      salePrice: json['sale_price'].toDouble(),
      quantity: json['quantity'],
      duration: json['duration'],
      downloadLink: json['download_link'],
      packing: json['packing'],
      status: json['status'],
      isTaxable: json['is_taxable'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      distributorshipOnly: json['distributorshipOnly'],
      zohoItemId: json['zoho_item_id'],
      projectActivationDisabled: json['project_activation_disabled'],
    );
  }
}

class Order {
  final String id;
  final int orderNumber;
  final double gstFees;
  final double tdsPercentage;
  final double amount;
  final double tdsAmount;
  final double totalAmount;
  final double payableAmount;
  final String performaInvoice;
  final String status;
  final String remark;
  final String createdAt;
  final String updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final dynamic zohoSalesOrderId;
  final Company company;

  Order({
    required this.id,
    required this.orderNumber,
    required this.gstFees,
    required this.tdsPercentage,
    required this.amount,
    required this.tdsAmount,
    required this.totalAmount,
    required this.payableAmount,
    required this.performaInvoice,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.deleteRemark,
    this.zohoSalesOrderId,
    required this.company,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      gstFees: json['gst_fees'].toDouble(),
      tdsPercentage: json['tds_percentage'].toDouble(),
      amount: json['amount'].toDouble(),
      tdsAmount: json['tds_amount'].toDouble(),
      totalAmount: json['total_amount'].toDouble(),
      payableAmount: json['payabale_amount'].toDouble(),
      performaInvoice: json['performa_invoice'],
      status: json['status'],
      remark: json['remark'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      deleteRemark: json['delete_remark'],
      zohoSalesOrderId: json['zoho_salesorder_id'],
      company: Company.fromJson(json['company']),
    );
  }
}

class Company {
  final String id;
  final String companyName;
  final String companyEmail;
  final String companyPhone;
  final int countryCode;
  final String contactPersonName;
  final String contactPersonNumber;
  final int cCountryCode;
  final String address;
  final String website;
  final String gst;
  final dynamic logo;
  final double lat;
  final double lng;
  final Customer customer;

  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.cCountryCode,
    required this.address,
    required this.website,
    required this.gst,
    this.logo,
    required this.lat,
    required this.lng,
    required this.customer,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      companyName: json['company_name'],
      companyEmail: json['company_email'],
      companyPhone: json['company_phone'],
      countryCode: json['country_code'],
      contactPersonName: json['contact_person_name'],
      contactPersonNumber: json['contact_person_number'],
      cCountryCode: json['c_country_code'],
      address: json['address'],
      website: json['website'],
      gst: json['gst'],
      logo: json['logo'],
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
      customer: Customer.fromJson(json['customer']),
    );
  }
}

class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int countryCode;
  final String company;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.company,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      countryCode: json['country_code'],
      company: json['company'],
    );
  }
}

class ActivationFor {
  final String id;
  final String name;

  ActivationFor({
    required this.id,
    required this.name,
  });

  factory ActivationFor.fromJson(Map<String, dynamic> json) {
    return ActivationFor(
      id: json['id'],
      name: json['name'],
    );
  }
}

class CreatedBy {
  final String id;
  final String name;

  CreatedBy({
    required this.id,
    required this.name,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Meta {
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;

  Meta({this.currentPage, this.lastPage, this.perPage, this.total});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['current_page'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_page': currentPage,
      'last_page': lastPage,
      'per_page': perPage,
      'total': total
    };
  }
}


