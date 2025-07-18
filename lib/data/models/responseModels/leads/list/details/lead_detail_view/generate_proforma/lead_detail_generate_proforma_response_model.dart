class LeadDetailGenerateProformaResponseModel {
  String? name;
  int? performaNumber;
  String? address;
  String? email;
  int? phone;
  String? remark;
  City? city;
  dynamic company;
  City? createdBy;
  City? lead;
  dynamic customer;
  City? division;
  City? currency;
  dynamic performa;
  String? id;
  int? gstFees;
  int? tdsPercentage;
  int? amount;
  int? tdsAmount;
  int? totalAmount;
  String? createdAt;
  String? updatedAt;

  LeadDetailGenerateProformaResponseModel(
      {this.name,
      this.performaNumber,
      this.address,
      this.email,
      this.phone,
      this.remark,
      this.city,
      this.company,
      this.createdBy,
      this.lead,
      this.customer,
      this.division,
      this.currency,
      this.performa,
      this.id,
      this.gstFees,
      this.tdsPercentage,
      this.amount,
      this.tdsAmount,
      this.totalAmount,
      this.createdAt,
      this.updatedAt});

  LeadDetailGenerateProformaResponseModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    performaNumber = json['performa_number'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    remark = json['remark'];
    city = json['city'] != null ? City.fromJson(json['city']) : null;
    company = json['company'];
    createdBy =
        json['created_by'] != null ? City.fromJson(json['created_by']) : null;
    lead = json['lead'] != null ? City.fromJson(json['lead']) : null;
    customer = json['customer'];
    division =
        json['division'] != null ? City.fromJson(json['division']) : null;
    currency =
        json['currency'] != null ? City.fromJson(json['currency']) : null;
    performa = json['performa'];
    id = json['id'];
    gstFees = json['gst_fees'];
    tdsPercentage = json['tds_percentage'];
    amount = json['amount'];
    tdsAmount = json['tds_amount'];
    totalAmount = json['total_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['performa_number'] = performaNumber;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['remark'] = remark;
    if (city != null) {
      data['city'] = city!.toJson();
    }
    data['company'] = company;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    if (lead != null) {
      data['lead'] = lead!.toJson();
    }
    data['customer'] = customer;
    if (division != null) {
      data['division'] = division!.toJson();
    }
    if (currency != null) {
      data['currency'] = currency!.toJson();
    }
    data['performa'] = performa;
    data['id'] = id;
    data['gst_fees'] = gstFees;
    data['tds_percentage'] = tdsPercentage;
    data['amount'] = amount;
    data['tds_amount'] = tdsAmount;
    data['total_amount'] = totalAmount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class City {
  String? id;

  City({this.id});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
