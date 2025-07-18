class CustomerDetailsOrdersResModel {
  CustomerDetailsOrdersResModel({
    required this.id,
    required this.orderNumber,
    required this.migrationFlag,
    required this.orderSerialNumber,
    required this.amount,
    required this.currencyAmount,
    required this.discountAmount,
    required this.currencyDiscountAmount,
    required this.totalAmount,
    required this.currencyTotalAmount,
    required this.gstAmount,
    required this.currencyGstAmount,
    required this.receivedAmount,
    required this.currencyReceivedAmount,
    required this.dueAmount,
    required this.currencyDueAmount,
    required this.unapprovedAmount,
    required this.currencyUnapprovedAmount,
    required this.pdcAmount,
    required this.currencyPdcAmount,
    required this.tdsAmount,
    required this.currencyTdsAmount,
    required this.tdsPercentage,
    required this.tdsOption,
    required this.conversionRate,
    required this.orderGeographyType,
    required this.buyerName,
    required this.buyerEmail,
    required this.buyerMobile,
    required this.buyerAddress,
    required this.isFirst,
    required this.orderDate,
    required this.performaInvoice,
    required this.status,
    required this.paymentStatus,
    required this.remark,
    required this.deleteRemark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.zohoSalesorderId,
    required this.payabaleAmount,
    required this.gstFees,
    required this.createdBy,
    required this.division,
    required this.company,
    required this.orderProducts,
    required this.payments,
    required this.credituse,
  });

  final String? id;
  final int? orderNumber;
  final int? migrationFlag;
  final String? orderSerialNumber;
  final int? amount;
  final int? currencyAmount;
  final int? discountAmount;
  final int? currencyDiscountAmount;
  final int? totalAmount;
  final int? currencyTotalAmount;
  final int? gstAmount;
  final int? currencyGstAmount;
  final int? receivedAmount;
  final int? currencyReceivedAmount;
  final int? dueAmount;
  final int? currencyDueAmount;
  final int? unapprovedAmount;
  final int? currencyUnapprovedAmount;
  final int? pdcAmount;
  final int? currencyPdcAmount;
  final int? tdsAmount;
  final int? currencyTdsAmount;
  final int? tdsPercentage;
  final String? tdsOption;
  final int? conversionRate;
  final String? orderGeographyType;
  final String? buyerName;
  final String? buyerEmail;
  final String? buyerMobile;
  final String? buyerAddress;
  final bool? isFirst;
  final DateTime? orderDate;
  final dynamic performaInvoice;
  final String? status;
  final String? paymentStatus;
  final String? remark;
  final dynamic deleteRemark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic zohoSalesorderId;
  final int? payabaleAmount;
  final int? gstFees;
  final CreatedBy? createdBy;
  final Division? division;
  final Company? company;
  final List<OrderProduct> orderProducts;
  final List<Payment> payments;
  final List<dynamic> credituse;

  factory CustomerDetailsOrdersResModel.fromJson(Map<String, dynamic> json) {
    return CustomerDetailsOrdersResModel(
      id: json["id"],
      orderNumber: json["order_number"],
      migrationFlag: json["migration_flag"],
      orderSerialNumber: json["order_serial_number"],
      amount: json["amount"],
      currencyAmount: json["currency_amount"],
      discountAmount: json["discount_amount"],
      currencyDiscountAmount: json["currency_discount_amount"],
      totalAmount: json["total_amount"],
      currencyTotalAmount: json["currency_total_amount"],
      gstAmount: json["gst_amount"],
      currencyGstAmount: json["currency_gst_amount"],
      receivedAmount: json["received_amount"],
      currencyReceivedAmount: json["currency_received_amount"],
      dueAmount: json["due_amount"],
      currencyDueAmount: json["currency_due_amount"],
      unapprovedAmount: json["unapproved_amount"],
      currencyUnapprovedAmount: json["currency_unapproved_amount"],
      pdcAmount: json["pdc_amount"],
      currencyPdcAmount: json["currency_pdc_amount"],
      tdsAmount: json["tds_amount"],
      currencyTdsAmount: json["currency_tds_amount"],
      tdsPercentage: json["tds_percentage"],
      tdsOption: json["tds_option"],
      conversionRate: json["conversion_rate"],
      orderGeographyType: json["order_geography_type"],
      buyerName: json["buyer_name"],
      buyerEmail: json["buyer_email"],
      buyerMobile: json["buyer_mobile"],
      buyerAddress: json["buyer_address"],
      isFirst: json["is_first"],
      orderDate: DateTime.tryParse(json["order_date"] ?? ""),
      performaInvoice: json["performa_invoice"],
      status: json["status"],
      paymentStatus: json["payment_status"],
      remark: json["remark"],
      deleteRemark: json["delete_remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      zohoSalesorderId: json["zoho_salesorder_id"],
      payabaleAmount: json["payabale_amount"],
      gstFees: json["gst_fees"],
      createdBy: json["created_by"] == null ? null : CreatedBy.fromJson(json["created_by"]),
      division: json["division"] == null ? null : Division.fromJson(json["division"]),
      company: json["company"] == null ? null : Company.fromJson(json["company"]),
      orderProducts: json["order_products"] == null ? [] : List<OrderProduct>.from(json["order_products"]!.map((x) => OrderProduct.fromJson(x))),
      payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
      credituse: json["credituse"] == null ? [] : List<dynamic>.from(json["credituse"]!.map((x) => x)),
    );
  }

  // Add this method to handle a list of JSON objects
  static List<CustomerDetailsOrdersResModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CustomerDetailsOrdersResModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}

class Company {
  Company({
    required this.id,
    required this.companyName,
  });

  final String? id;
  final String? companyName;

  factory Company.fromJson(Map<String, dynamic> json){
    return Company(
      id: json["id"],
      companyName: json["company_name"],
    );
  }

}

class CreatedBy {
  CreatedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  final String? id;
  final String? firstName;
  final String? lastName;

  factory CreatedBy.fromJson(Map<String, dynamic> json){
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
    );
  }

}

class Division {
  Division({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Division.fromJson(Map<String, dynamic> json){
    return Division(
      id: json["id"],
      name: json["name"],
    );
  }

}

class OrderProduct {
  OrderProduct({
    required this.id,
    required this.productType,
    required this.productName,
    required this.paymentMode,
    required this.paymentType,
    required this.mrp,
    required this.salePrice,
    required this.amount,
    required this.currencyAmount,
    required this.discountAmount,
    required this.currencyDiscountAmount,
    required this.totalAmount,
    required this.currencyTotalAmount,
    required this.gstAmount,
    required this.currencyGstAmount,
    required this.receivedAmount,
    required this.currencyReceivedAmount,
    required this.dueAmount,
    required this.currencyDueAmount,
    required this.unapprovedAmount,
    required this.currencyUnapprovedAmount,
    required this.pdcAmount,
    required this.currencyPdcAmount,
    required this.gstPercentage,
    required this.gstInfo,
    required this.quantity,
    required this.duration,
    required this.status,
    required this.currencyMrp,
    required this.currencySalePrice,
    required this.conversionRate,
    required this.paymentStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.gst,
    required this.tdsOption,
    required this.tds,
    required this.tdsPercentage,
    required this.total,
    required this.isFree,
    required this.product,
    required this.payments,
  });

  final String? id;
  final String? productType;
  final String? productName;
  final dynamic paymentMode;
  final dynamic paymentType;
  final int? mrp;
  final int? salePrice;
  final int? amount;
  final int? currencyAmount;
  final int? discountAmount;
  final int? currencyDiscountAmount;
  final int? totalAmount;
  final int? currencyTotalAmount;
  final int? gstAmount;
  final int? currencyGstAmount;
  final int? receivedAmount;
  final int? currencyReceivedAmount;
  final int? dueAmount;
  final int? currencyDueAmount;
  final int? unapprovedAmount;
  final int? currencyUnapprovedAmount;
  final int? pdcAmount;
  final int? currencyPdcAmount;
  final int? gstPercentage;
  final String? gstInfo;
  final int? quantity;
  final int? duration;
  final String? status;
  final int? currencyMrp;
  final int? currencySalePrice;
  final int? conversionRate;
  final String? paymentStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? gst;
  final String? tdsOption;
  final int? tds;
  final int? tdsPercentage;
  final int? total;
  final bool? isFree;
  final Product? product;
  final List<dynamic> payments;

  factory OrderProduct.fromJson(Map<String, dynamic> json){
    return OrderProduct(
      id: json["id"],
      productType: json["product_type"],
      productName: json["product_name"],
      paymentMode: json["payment_mode"],
      paymentType: json["payment_type"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      amount: json["amount"],
      currencyAmount: json["currency_amount"],
      discountAmount: json["discount_amount"],
      currencyDiscountAmount: json["currency_discount_amount"],
      totalAmount: json["total_amount"],
      currencyTotalAmount: json["currency_total_amount"],
      gstAmount: json["gst_amount"],
      currencyGstAmount: json["currency_gst_amount"],
      receivedAmount: json["received_amount"],
      currencyReceivedAmount: json["currency_received_amount"],
      dueAmount: json["due_amount"],
      currencyDueAmount: json["currency_due_amount"],
      unapprovedAmount: json["unapproved_amount"],
      currencyUnapprovedAmount: json["currency_unapproved_amount"],
      pdcAmount: json["pdc_amount"],
      currencyPdcAmount: json["currency_pdc_amount"],
      gstPercentage: json["gst_percentage"],
      gstInfo: json["gst_info"],
      quantity: json["quantity"],
      duration: json["duration"],
      status: json["status"],
      currencyMrp: json["currency_mrp"],
      currencySalePrice: json["currency_sale_price"],
      conversionRate: json["conversion_rate"],
      paymentStatus: json["payment_status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      gst: json["gst"],
      tdsOption: json["tds_option"],
      tds: json["tds"],
      tdsPercentage: json["tds_percentage"],
      total: json["total"],
      isFree: json["is_free"],
      product: json["product"] == null ? null : Product.fromJson(json["product"]),
      payments: json["payments"] == null ? [] : List<dynamic>.from(json["payments"]!.map((x) => x)),
    );
  }

}

class Product {
  Product({
    required this.id,
    required this.productType,
    required this.serviceType,
    required this.courseType,
    required this.name,
    required this.description,
    required this.composition,
    required this.landingCost,
    required this.mrp,
    required this.salePrice,
    required this.recurringFrequency,
    required this.customRecurringFrequency,
    required this.quantity,
    required this.duration,
    required this.downloadLink,
    required this.packing,
    required this.status,
    required this.isTaxable,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.distributorshipOnly,
    required this.zohoItemId,
    required this.projectActivationDisabled,
  });

  final String? id;
  final String? productType;
  final String? serviceType;
  final dynamic courseType;
  final String? name;
  final String? description;
  final dynamic composition;
  final dynamic landingCost;
  final int? mrp;
  final int? salePrice;
  final String? recurringFrequency;
  final dynamic customRecurringFrequency;
  final int? quantity;
  final int? duration;
  final dynamic downloadLink;
  final dynamic packing;
  final bool? status;
  final bool? isTaxable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? distributorshipOnly;
  final dynamic zohoItemId;
  final bool? projectActivationDisabled;

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json["id"],
      productType: json["product_type"],
      serviceType: json["service_type"],
      courseType: json["course_type"],
      name: json["name"],
      description: json["description"],
      composition: json["composition"],
      landingCost: json["landing_cost"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      recurringFrequency: json["recurring_frequency"],
      customRecurringFrequency: json["custom_recurring_frequency"],
      quantity: json["quantity"],
      duration: json["duration"],
      downloadLink: json["download_link"],
      packing: json["packing"],
      status: json["status"],
      isTaxable: json["is_taxable"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      distributorshipOnly: json["distributorshipOnly"],
      zohoItemId: json["zoho_item_id"],
      projectActivationDisabled: json["project_activation_disabled"],
    );
  }

}

class Payment {
  Payment({
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
    required this.uploadDocument,
    required this.invoice,
    required this.information,
    required this.isFresh,
    required this.isFirst,
    required this.status,
    required this.remark,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.gstAndFees,
    required this.paymentType,
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
  final String? uploadDocument;
  final String? invoice;
  final String? information;
  final bool? isFresh;
  final bool? isFirst;
  final String? status;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? gstAndFees;
  final String? paymentType;

  factory Payment.fromJson(Map<String, dynamic> json){
    return Payment(
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
      uploadDocument: json["upload_document"],
      invoice: json["invoice"],
      information: json["information"],
      isFresh: json["is_fresh"],
      isFirst: json["is_first"],
      status: json["status"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      gstAndFees: json["gst_and_fees"],
      paymentType: json["payment_type"],
    );
  }

}
