class OrderProformaListResponseModel {
  String? id;
  String? name;
  int? performa_number;
  String? address;
  String? email;
  String? phone;
  String? performa;
  int? gst_fees;
  int? tds_percentage;
  int? amount;
  int? tds_amount;
  int? total_amount;
  String? remark;
  String? created_at;
  String? updated_at;
  String? lead;
  Customer? customer;
  CreatedBy? created_by;
  List<Products>? products;

  OrderProformaListResponseModel(
      {this.id,
        this.name,
        this.performa_number,
        this.address,
        this.email,
        this.phone,
        this.performa,
        this.gst_fees,
        this.tds_percentage,
        this.amount,
        this.tds_amount,
        this.total_amount,
        this.remark,
        this.created_at,
        this.updated_at,
        this.lead,
        this.customer,
        this.created_by,
        this.products});

  OrderProformaListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    performa_number = json['performa_number'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    performa = json['performa'];
    gst_fees = json['gst_fees'];
    tds_percentage = json['tds_percentage'];
    amount = json['amount'];
    tds_amount = json['tds_amount'];
    total_amount = json['total_amount'];
    remark = json['remark'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    lead = json['lead'];
    customer = json['customer'] != null
        ? Customer.fromJson(json['customer'])
        : null;
    created_by = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['performa_number'] = performa_number;
    data['address'] = address;
    data['email'] = email;
    data['phone'] = phone;
    data['performa'] = performa;
    data['gst_fees'] = gst_fees;
    data['tds_percentage'] = tds_percentage;
    data['amount'] = amount;
    data['tds_amount'] = tds_amount;
    data['total_amount'] = total_amount;
    data['remark'] = remark;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['lead'] = lead;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (created_by != null) {
      data['created_by'] = created_by!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? first_name;
  String? last_name;
  String? primary_email;

  Customer({this.id, this.first_name, this.last_name, this.primary_email});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
    primary_email = json['primary_email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    data['primary_email'] = primary_email;
    return data;
  }
}

class CreatedBy {
  String? id;
  String? first_name;
  String? last_name;

  CreatedBy({this.id, this.first_name, this.last_name});

  CreatedBy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    first_name = json['first_name'];
    last_name = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = first_name;
    data['last_name'] = last_name;
    return data;
  }
}

class Products {
  String? id;
  String? product_type;
  String? payment_mode;
  String? payment_type;
  int? mrp;
  int? sale_price;
  int? gst;
  int? gst_percentage;
  String? tds_option;
  int? tds;
  int? tds_percentage;
  String? gst_info;
  int? total;
  int? quantity;
  int? duration;
  String? status;
  String? created_at;
  String? updated_at;
  String? deleted_at;

  Products(
      {this.id,
        this.product_type,
        this.payment_mode,
        this.payment_type,
        this.mrp,
        this.sale_price,
        this.gst,
        this.gst_percentage,
        this.tds_option,
        this.tds,
        this.tds_percentage,
        this.gst_info,
        this.total,
        this.quantity,
        this.duration,
        this.status,
        this.created_at,
        this.updated_at,
        this.deleted_at
      });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product_type = json['product_type'];
    payment_mode = json['payment_mode'];
    payment_type = json['payment_type'];
    mrp = json['mrp'];
    sale_price = json['sale_price'];
    gst = json['gst'];
    gst_percentage = json['gst_percentage'];
    tds_option = json['tds_option'];
    tds = json['tds'];
    tds_percentage = json['tds_percentage'];
    gst_info = json['gst_info'];
    total = json['total'];
    quantity = json['quantity'];
    duration = json['duration'];
    status = json['status'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
    deleted_at = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = product_type;
    data['payment_mode'] = payment_mode;
    data['payment_type'] = payment_type;
    data['mrp'] = mrp;
    data['sale_price'] = sale_price;
    data['gst'] = gst;
    data['gst_percentage'] = gst_percentage;
    data['tds_option'] = tds_option;
    data['tds'] = tds;
    data['tds_percentage'] = tds_percentage;
    data['gst_info'] = gst_info;
    data['total'] = total;
    data['quantity'] = quantity;
    data['duration'] = duration;
    data['status'] = status;
    data['created_at'] = created_at;
    data['updated_at'] = updated_at;
    data['deleted_at'] = deleted_at;
    return data;
  }
}