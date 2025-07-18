class LeadProformasResModel {
  List<Items>? items;
  Meta? meta;

  LeadProformasResModel({this.items, this.meta});

  LeadProformasResModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta!.toJson();
    }
    return data;
  }
}

class Items {
  String? id;
  String? name;
  int? performaNumber;
  String? address;
  String? email;
  String? phone;
  dynamic performa;  // Use dynamic for nullable fields
  int? gstFees;
  int? amount;
  int? tdsPercentage;
  int? tdsAmount;
  int? currencyTdsAmount;
  String? tdsOption;
  int? totalAmount;
  String? remark;
  String? createdAt;
  String? updatedAt;
  Lead? lead;
  CreatedBy? createdBy;
  Division? division;
  Currency? currency;

  Items({
    this.id,
    this.name,
    this.performaNumber,
    this.address,
    this.email,
    this.phone,
    this.performa,
    this.gstFees,
    this.amount,
    this.tdsPercentage,
    this.tdsAmount,
    this.currencyTdsAmount,
    this.tdsOption,
    this.totalAmount,
    this.remark,
    this.createdAt,
    this.updatedAt,
    this.lead,
    this.createdBy,
    this.division,
    this.currency,
  });

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    performaNumber = json['performa_number'] as int?;
    address = json['address'] as String?;
    email = json['email'] as String?;
    phone = json['phone'] as String?;
    performa = json['performa'];  // dynamic field
    gstFees = json['gst_fees'] as int?;
    amount = json['amount'] as int?;
    tdsPercentage = json['tds_percentage'] as int?;
    tdsAmount = json['tds_amount'] as int?;
    currencyTdsAmount = json['currency_tds_amount'] as int?;
    tdsOption = json['tds_option'] as String?;
    totalAmount = json['total_amount'] as int?;
    remark = json['remark'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    lead = json['lead'] != null ? Lead.fromJson(json['lead']) : null;
    createdBy = json['created_by'] != null ? CreatedBy.fromJson(json['created_by']) : null;
    division = json['division'] != null ? Division.fromJson(json['division']) : null;
    currency = json['currency'] != null ? Currency.fromJson(json['currency']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['performa_number'] = performaNumber;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['performa'] = performa;
    data['gst_fees'] = gstFees;
    data['amount'] = amount;
    data['tds_percentage'] = tdsPercentage;
    data['tds_amount'] = tdsAmount;
    data['currency_tds_amount'] = currencyTdsAmount;
    data['tds_option'] = tdsOption;
    data['total_amount'] = totalAmount;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    return data;
  }
}

class Lead {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? organization;

  Lead({this.id, this.firstName, this.lastName, this.email, this.organization});

  Lead.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    email = json['email'] as String?;
    organization = json['organization'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['organization'] = organization;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;

  CreatedBy({this.id, this.firstName, this.lastName});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}

class Division {
  String? id;
  String? name;

  Division({this.id, this.name});

  Division.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
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
  String? name;
  String? code;
  String? symbol;

  Currency({this.id, this.name, this.code, this.symbol});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    name = json['name'] as String?;
    code = json['code'] as String?;
    symbol = json['symbol'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
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

  Meta({
    this.currentPage,
    this.itemsPerPage,
    this.totalPages,
    this.totalItems,
    this.itemCount,
  });

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'] as int?;
    itemsPerPage = json['itemsPerPage'] as int?;
    totalPages = json['totalPages'] as int?;
    totalItems = json['totalItems'] as int?;
    itemCount = json['itemCount'] as int?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentPage'] = currentPage;
    data['itemsPerPage'] = itemsPerPage;
    data['totalPages'] = totalPages;
    data['totalItems'] = totalItems;
    data['itemCount'] = itemCount;
    return data;
  }
}
