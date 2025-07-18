class OrderPaymentUpdateResponseModel {
  String? id;
  int? amount;
  int? gstAndFees;
  String? paymentMode;
  String? paymentType;
  dynamic txnId;
  int? chequeNumber;
  dynamic chequeDate;
  String? uploadDocument;
  dynamic invoice;
  String? information;
  bool? isFresh;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Order? order;
  Product? product;

  OrderPaymentUpdateResponseModel(
      {this.id,
      this.amount,
      this.gstAndFees,
      this.paymentMode,
      this.paymentType,
      this.txnId,
      this.chequeNumber,
      this.chequeDate,
      this.uploadDocument,
      this.invoice,
      this.information,
      this.isFresh,
      this.status,
      this.remark,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.order,
      this.product});

  OrderPaymentUpdateResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    gstAndFees = json['gst_and_fees'];
    paymentMode = json['payment_mode'];
    paymentType = json['payment_type'];
    txnId = json['txn_id'];
    chequeNumber = json['cheque_number'];
    chequeDate = json['cheque_date'];
    uploadDocument = json['upload_document'];
    invoice = json['invoice'];
    information = json['information'];
    isFresh = json['is_fresh'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['gst_and_fees'] = gstAndFees;
    data['payment_mode'] = paymentMode;
    data['payment_type'] = paymentType;
    data['txn_id'] = txnId;
    data['cheque_number'] = chequeNumber;
    data['cheque_date'] = chequeDate;
    data['upload_document'] = uploadDocument;
    data['invoice'] = invoice;
    data['information'] = information;
    data['is_fresh'] = isFresh;
    data['status'] = status;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Order {
  String? id;
  int? orderNumber;
  int? gstFees;
  int? tdsPercentage;
  int? amount;
  int? tdsAmount;
  int? totalAmount;
  int? payabaleAmount;
  String? performaInvoice;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic deleteRemark;
  dynamic zohoSalesorderId;

  Order(
      {this.id,
      this.orderNumber,
      this.gstFees,
      this.tdsPercentage,
      this.amount,
      this.tdsAmount,
      this.totalAmount,
      this.payabaleAmount,
      this.performaInvoice,
      this.status,
      this.remark,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deleteRemark,
      this.zohoSalesorderId});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    gstFees = json['gst_fees'];
    tdsPercentage = json['tds_percentage'];
    amount = json['amount'];
    tdsAmount = json['tds_amount'];
    totalAmount = json['total_amount'];
    payabaleAmount = json['payabale_amount'];
    performaInvoice = json['performa_invoice'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoSalesorderId = json['zoho_salesorder_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['gst_fees'] = gstFees;
    data['tds_percentage'] = tdsPercentage;
    data['amount'] = amount;
    data['tds_amount'] = tdsAmount;
    data['total_amount'] = totalAmount;
    data['payabale_amount'] = payabaleAmount;
    data['performa_invoice'] = performaInvoice;
    data['status'] = status;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_salesorder_id'] = zohoSalesorderId;
    return data;
  }
}

class Product {
  String? id;
  String? productType;
  dynamic serviceType;
  String? name;
  String? description;
  int? mrp;
  int? salePrice;
  int? quantity;
  int? duration;
  String? downloadLink;
  String? packing;
  bool? status;
  bool? isTaxable;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  bool? distributorshipOnly;
  dynamic zohoItemId;
  bool? projectActivationDisabled;

  Product(
      {this.id,
      this.productType,
      this.serviceType,
      this.name,
      this.description,
      this.mrp,
      this.salePrice,
      this.quantity,
      this.duration,
      this.downloadLink,
      this.packing,
      this.status,
      this.isTaxable,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.distributorshipOnly,
      this.zohoItemId,
      this.projectActivationDisabled});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    serviceType = json['service_type'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    quantity = json['quantity'];
    duration = json['duration'];
    downloadLink = json['download_link'];
    packing = json['packing'];
    status = json['status'];
    isTaxable = json['is_taxable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    distributorshipOnly = json['distributorshipOnly'];
    zohoItemId = json['zoho_item_id'];
    projectActivationDisabled = json['project_activation_disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
    data['service_type'] = serviceType;
    data['name'] = name;
    data['description'] = description;
    data['mrp'] = mrp;
    data['sale_price'] = salePrice;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['download_link'] = downloadLink;
    data['packing'] = packing;
    data['status'] = status;
    data['is_taxable'] = isTaxable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['distributorshipOnly'] = distributorshipOnly;
    data['zoho_item_id'] = zohoItemId;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}
