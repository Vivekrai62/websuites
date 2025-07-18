class OrderPaymentsResponseModel {
  List<Items>? items;
  Meta? meta;
  Null userKey;

  OrderPaymentsResponseModel({this.items, this.meta, this.userKey});

  OrderPaymentsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    userKey = json['user_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    data['user_key'] = userKey;
    return data;
  }
}

class Items {
  String? id;
  int? currencyAmount;
  String? paymentMode;
  String? entryType;
  Null txnId;
  int? chequeNumber;
  Null chequeDate;
  Null paymentDate;
  Null uploadDocument;
  Null information;
  bool? isFresh;
  bool? isFirst;
  String? status;
  String? remark;
  String? createdAt;
  CreatedBy? createdBy;
  Order? order;
  CreatedBy? customer;
  Null statusActionBy;
  Currency? currency;

  Items(
      {this.id,
      this.currencyAmount,
      this.paymentMode,
      this.entryType,
      this.txnId,
      this.chequeNumber,
      this.chequeDate,
      this.paymentDate,
      this.uploadDocument,
      this.information,
      this.isFresh,
      this.isFirst,
      this.status,
      this.remark,
      this.createdAt,
      this.createdBy,
      this.order,
      this.customer,
      this.statusActionBy,
      this.currency});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currencyAmount = json['currency_amount'];
    paymentMode = json['payment_mode'];
    entryType = json['entry_type'];
    txnId = json['txn_id'];
    chequeNumber = json['cheque_number'];
    chequeDate = json['cheque_date'];
    paymentDate = json['payment_date'];
    uploadDocument = json['upload_document'];
    information = json['information'];
    isFresh = json['is_fresh'];
    isFirst = json['is_first'];
    status = json['status'];
    remark = json['remark'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    customer =
        json['customer'] != null ? CreatedBy.fromJson(json['customer']) : null;
    statusActionBy = json['status_action_by'];
    currency =
        json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['currency_amount'] = currencyAmount;
    data['payment_mode'] = paymentMode;
    data['entry_type'] = entryType;
    data['txn_id'] = txnId;
    data['cheque_number'] = chequeNumber;
    data['cheque_date'] = chequeDate;
    data['payment_date'] = paymentDate;
    data['upload_document'] = uploadDocument;
    data['information'] = information;
    data['is_fresh'] = isFresh;
    data['is_first'] = isFirst;
    data['status'] = status;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['status_action_by'] = statusActionBy;
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;

  CreatedBy({this.id, this.firstName, this.lastName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Order {
  String? id;
  Null orderSerialNumber;
  Company? company;
  Division? division;

  Order({this.id, this.orderSerialNumber, this.company, this.division});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderSerialNumber = json['order_serial_number'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    division =
        json['division'] != null ? Division.fromJson(json['division']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_serial_number'] = orderSerialNumber;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    return data;
  }
}

class Company {
  String? id;
  String? companyName;

  Company({this.id, this.companyName});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    return data;
  }
}

class Division {
  String? id;
  String? name;

  Division({this.id, this.name});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Currency {
  String? id;
  String? symbol;

  Currency({this.id, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;
  int? totalAmount;
  int? approvedAmount;
  Null cancelledAmount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount,
      this.totalAmount,
      this.approvedAmount,
      this.cancelledAmount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
    totalAmount = json['totalAmount'];
    approvedAmount = json['approvedAmount'];
    cancelledAmount = json['cancelledAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    data['totalAmount'] = totalAmount;
    data['approvedAmount'] = approvedAmount;
    data['cancelledAmount'] = cancelledAmount;
    return data;
  }
}
