
import '../../responseModels/dashboard/db_latest_customer_response_model.dart';

class DBTransactionsRequestModel {
  List<Items>? items;
  Meta? meta;
  String? user_key;

  DBTransactionsRequestModel ({
    this.items,
    this.meta,
    this.user_key
});

  Map<String,dynamic> toJson () {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items !.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      data['meta'] = meta !.toJson();
    }
    data['user_key'] = user_key;
    return data;
  }
}



  class Items {
  String? id;
  int? amount;
  int? gstAndFees;
  String? paymentMode;
  String? paymentType;
  String? txnId;
  int? chequeNumber;
  String? chequeDate;
  String? uploadDocument;
  String? invoice;
  String? information;
  bool? isFresh;
  String? status;
  String? remark;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  CreatedBy? created_by;
  Order? order;
  Product? product;
  String? statusActionBy;

  Items({
    this.id,
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
    this.created_by,
    this.order,
    this.product,
    this.statusActionBy});

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
    if (created_by != null) {
      data['created_by'] = created_by!.toJson();
    }
    if (order != null) {
      data['order'] = order!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['status_action_by'] = statusActionBy;
    return data;
  }
  }

class Product {
  String? id;
  String? productType;
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
  String? deletedAt;
  String? zohoItemId;
  bool? projectActivationDisabled;

  Product(
      {this.id,
        this.productType,
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
        this.zohoItemId,
        this.projectActivationDisabled});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
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
    data['zoho_item_id'] = zohoItemId;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}

class Company {
  String? id;
  String? companyName;
  String? companyEmail;
  String? companyPhone;
  int? countryCode;
  String? contactPersonName;
  String? contactPersonNumber;
  int? cCountryCode;
  String? address;
  String? website;
  String? gst;
  String? logo;
  int? lat;
  int? lng;

  Company(
      {this.id,
        this.companyName,
        this.companyEmail,
        this.companyPhone,
        this.countryCode,
        this.contactPersonName,
        this.contactPersonNumber,
        this.cCountryCode,
        this.address,
        this.website,
        this.gst,
        this.logo,
        this.lat,
        this.lng});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['company_email'] = companyEmail;
    data['company_phone'] = companyPhone;
    data['country_code'] = countryCode;
    data['contact_person_name'] = contactPersonName;
    data['contact_person_number'] = contactPersonNumber;
    data['c_country_code'] = cCountryCode;
    data['address'] = address;
    data['website'] = website;
    data['gst'] = gst;
    data['logo'] = logo;
    data['lat'] = lat;
    data['lng'] = lng;
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
  String? deletedAt;
  String? deleteRemark;
  String? zohoSalesorderId;
  Customer? customer;
  Company? company;

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
        this.zohoSalesorderId,
        this.customer,
        this.company});

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
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? companyName;
  String? firstName;
  String? lastName;
  String? primaryEmail;
  int? countryCode;
  String? primaryContact;
  String? organization;
  String? primaryAddress;
  String? profileImage;
  String? dob;
  String? aboutClient;
  String? otherInformation;
  double? lat;
  double? lng;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? deleteRemark;
  String? zohoContactId;
  List<Divisions>? divisions;

  Customer(
      {this.id,
        this.companyName,
        this.firstName,
        this.lastName,
        this.primaryEmail,
        this.countryCode,
        this.primaryContact,
        this.organization,
        this.primaryAddress,
        this.profileImage,
        this.dob,
        this.aboutClient,
        this.otherInformation,
        this.lat,
        this.lng,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.deleteRemark,
        this.zohoContactId,
        this.divisions});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['country_code'] = countryCode;
    data['primary_contact'] = primaryContact;
    data['organization'] = organization;
    data['primary_address'] = primaryAddress;
    data['profile_image'] = profileImage;
    data['dob'] = dob;
    data['about_client'] = aboutClient;
    data['other_information'] = otherInformation;
    data['lat'] = lat;
    data['lng'] = lng;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['delete_remark'] = deleteRemark;
    data['zoho_contact_id'] = zohoContactId;
    if (divisions != null) {
      data['divisions'] = divisions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Divisions {
  String? id;
  String? name;
  String? status;
  String? mobileNo;
  String? contactPerson;
  String? email;
  String? address;
  String? logo;
  String? createdAt;
  String? updatedAt;
  String? zohoOrganizationId;
  String? zohoTaxExemptionId;

  Divisions({
    this.id,
    this.name,
    this.status,
    this.mobileNo,
    this.contactPerson,
    this.email,
    this.address,
    this.logo,
    this.createdAt,
    this.updatedAt,
    this.zohoOrganizationId,
    this.zohoTaxExemptionId,
  });

  // Factory constructor for creating a Divisions object from JSON
  factory Divisions.fromJson(Map<String, dynamic> json) {
    return Divisions(
      id: json['id'] as String?,
      name: json['name'] as String?,
      status: json['status'] as String?,
      mobileNo: json['mobile_no'] as String?,
      contactPerson: json['contact_person'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      logo: json['logo'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      zohoOrganizationId: json['zoho_organization_id'] as String?,
      zohoTaxExemptionId: json['zoho_tax_exemption_id'] as String?,
    );
  }

  // Method for converting a Divisions object to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['mobile_no'] = mobileNo;
    data['contact_person'] = contactPerson;
    data['email'] = email;
    data['address'] = address;
    data['logo'] = logo;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['zoho_organization_id'] = zohoOrganizationId;
    data['zoho_tax_exemption_id'] = zohoTaxExemptionId;
    return data;
  }
}


class CreatedBy {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobile;
  String? address;
  String? bio;
  String? profilePic;
  String? password;
  bool? status;
  String? rememberToken;
  String? rememberTokenTime;
  bool? isdefault;
  String? createdAt;
  String? updatedAt;
  String? deviceId;
  bool? tracking;
  String? crmCategory;
  bool? mobileApp;
  bool? superSettings;

  CreatedBy({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobile,
    this.address,
    this.bio,
    this.profilePic,
    this.password,
    this.status,
    this.rememberToken,
    this.rememberTokenTime,
    this.isdefault,
    this.createdAt,
    this.updatedAt,
    this.deviceId,
    this.tracking,
    this.crmCategory,
    this.mobileApp,
    this.superSettings});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['bio'] = bio;
    data['profile_pic'] = profilePic;
    data['password'] = password;
    data['status'] = status;
    data['remember_token'] = rememberToken;
    data['remember_token_time'] = rememberTokenTime;
    data['default'] = isdefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['device_id'] = deviceId;
    data['tracking'] = tracking;
    data['crm_category'] = crmCategory;
    data['mobile_app'] = mobileApp;
    data['superSettings'] = superSettings;
    return data;
  }
}

