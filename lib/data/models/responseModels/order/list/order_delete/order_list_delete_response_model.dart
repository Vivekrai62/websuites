class OrderDeleteResponseModel {
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
  Null deletedAt;
  Null deleteRemark;
  Null zohoSalesorderId;
  Customer? customer;

  OrderDeleteResponseModel(
      {this.orderNumber,
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
      this.zohoSalesorderId,
      this.customer});

  OrderDeleteResponseModel.fromJson(Map<String, dynamic> json) {
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
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  List<Null>? websites;
  String? primaryAddress;
  Null profileImage;
  String? dob;
  String? gstin;
  String? aboutClient;
  String? otherInformation;
  int? lat;
  int? lng;
  Null joinedAt;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  Null deleteRemark;
  Null zohoContactId;
  String? status;
  Null subStatus;
  List<Null>? customerToCustomFields;
  Null lastOrder;

  Customer(
      {this.id,
      this.firstName,
      this.lastName,
      this.primaryEmail,
      this.countryCode,
      this.primaryContact,
      this.organization,
      this.websites,
      this.primaryAddress,
      this.profileImage,
      this.dob,
      this.gstin,
      this.aboutClient,
      this.otherInformation,
      this.lat,
      this.lng,
      this.joinedAt,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.deleteRemark,
      this.zohoContactId,
      this.status,
      this.subStatus,
      this.customerToCustomFields,
      this.lastOrder});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    countryCode = json['country_code'];
    primaryContact = json['primary_contact'];
    organization = json['organization'];
    if (json['websites'] != null) {
      websites = <Null>[];
      json['websites'].forEach((v) {
        websites!.add((v));
      });
    }
    primaryAddress = json['primary_address'];
    profileImage = json['profile_image'];
    dob = json['dob'];
    gstin = json['gstin'];
    aboutClient = json['about_client'];
    otherInformation = json['other_information'];
    lat = json['lat'];
    lng = json['lng'];
    joinedAt = json['joined_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    deleteRemark = json['delete_remark'];
    zohoContactId = json['zoho_contact_id'];
    status = json['status'];
    subStatus = json['subStatus'];
    if (json['customerToCustomFields'] != null) {
      customerToCustomFields = <Null>[];
      json['customerToCustomFields'].forEach((v) {
        customerToCustomFields!.add((v));
      });
    }
    lastOrder = json['last_order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['organization'] = organization;
    if (websites != null) {
      data['websites'] = websites!.map((v) => ()).toList();
    }
    data['primary_address'] = primaryAddress;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['gstin'] = gstin;
    data['about_client'] = aboutClient;
    data['other_information'] = otherInformation;
    data['lat'] = lat;
    data['lng'] = lng;
    data['joined_at'] = joinedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_contact_id'] = zohoContactId;
    data['status'] = status;
    data['subStatus'] = subStatus;
    if (customerToCustomFields != null) {
      data['customerToCustomFields'] =
          customerToCustomFields!.map((v) => ()).toList();
    }
    data['last_order'] = lastOrder;
    return data;
  }
}
