class CustomerDetailsPaymentResModel {
  CustomerDetailsPaymentResModel({
    required this.id,
    required this.amount,
    required this.currencyAmount,
    required this.conversionRate,
    required this.paymentMode,
    required this.entryType,
    required this.txnId,
    required this.chequeNumber,
    required this.chequeDate,
    required this.paymentDate,
    required this.invoice,
    required this.information,
    required this.isFresh,
    required this.isFirst,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.paymentType,
    required this.order,
    required this.paymentAllocations,
    required this.currency,
  });

  final String? id;
  final int? amount;
  final int? currencyAmount;
  final int? conversionRate;
  final String? paymentMode;
  final String? entryType;
  final dynamic txnId;
  final int? chequeNumber;
  final dynamic chequeDate;
  final DateTime? paymentDate;
  final String? invoice;
  final String? information;
  final bool? isFresh;
  final bool? isFirst;
  final String? status;
  final String? remark;
  final DateTime? createdAt;
  final String? paymentType;
  final Order? order;
  final List<PaymentAllocation> paymentAllocations;
  final Currency? currency;

  factory CustomerDetailsPaymentResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsPaymentResModel(
      id: json["id"],
      amount: json["amount"],
      currencyAmount: json["currency_amount"],
      conversionRate: json["conversion_rate"],
      paymentMode: json["payment_mode"],
      entryType: json["entry_type"],
      txnId: json["txn_id"],
      chequeNumber: json["cheque_number"],
      chequeDate: json["cheque_date"],
      paymentDate: DateTime.tryParse(json["payment_date"] ?? ""),
      invoice: json["invoice"],
      information: json["information"],
      isFresh: json["is_fresh"],
      isFirst: json["is_first"],
      status: json["status"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      paymentType: json["payment_type"],
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
      paymentAllocations: json["payment_allocations"] == null
          ? []
          : List<PaymentAllocation>.from(
          json["payment_allocations"]!.map((x) => PaymentAllocation.fromJson(x))),
      currency: json["currency"] == null ? null : Currency.fromJson(json["currency"]),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsPaymentResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsPaymentResModel.fromJson(json)).toList();
  }
}

class Currency {
  Currency({
    required this.id,
    required this.name,
    required this.code,
    required this.symbol,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? symbol;

  factory Currency.fromJson(Map<String, dynamic> json){
    return Currency(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      symbol: json["symbol"],
    );
  }

}

class Order {
  Order({
    required this.id,
    required this.company,
  });

  final String? id;
  final Company? company;

  factory Order.fromJson(Map<String, dynamic> json){
    return Order(
      id: json["id"],
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );
  }

}

class Company {
  Company({
    required this.id,
    required this.customer,
  });

  final String? id;
  final Customer? customer;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    );
  }

}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory Customer.fromJson(Map<String, dynamic> json){
    return Customer(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

}

class PaymentAllocation {
  PaymentAllocation({
    required this.id,
    required this.amount,
    required this.currencyAmount,
    required this.remark,
    required this.customerService,
  });

  final String? id;
  final int? amount;
  final int? currencyAmount;
  final String? remark;
  final CustomerService? customerService;

  factory PaymentAllocation.fromJson(Map<String, dynamic> json){
    return PaymentAllocation(
      id: json["id"],
      amount: json["amount"],
      currencyAmount: json["currency_amount"],
      remark: json["remark"],
      customerService: json["customer_service"] == null ? null : CustomerService.fromJson(json["customer_service"]),
    );
  }

}

class CustomerService {
  CustomerService({
    required this.id,
    required this.productName,
    required this.recurringFrequency,
    required this.serviceType,
  });

  final String? id;
  final String? productName;
  final dynamic recurringFrequency;
  final String? serviceType;

  factory CustomerService.fromJson(Map<String, dynamic> json){
    return CustomerService(
      id: json["id"],
      productName: json["product_name"],
      recurringFrequency: json["recurring_frequency"],
      serviceType: json["service_type"],
    );
  }

}
