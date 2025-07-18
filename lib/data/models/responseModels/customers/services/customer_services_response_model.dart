
//NEW NEW CODE
class CustomerServiceResponseModel {
  CustomerServiceResponseModel({
     required this.items,
     this.meta,
     this.userKey,
  });

  final List<Item> items;
  final Meta? meta;
  final dynamic userKey;

  factory CustomerServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerServiceResponseModel(
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      userKey: json["user_key"],
    );
  }
}

class Item {
  Item({
    this.id,
    this.startDate,
    this.endDate,
    this.remark,
    this.reminderBeforeExpire,
    this.status,
    this.quitReason,
    this.quitDate,
    this.createdAt,
    this.updatedAt,
    required this.deletedAt,
    this.isDisposed,
    this.orderProduct,
    this.parent,
  });
  final String? id;
  final DateTime? startDate;
  final DateTime? endDate;
  final dynamic remark;
  final DateTime? reminderBeforeExpire;
  final bool? status;
  final dynamic quitReason;
  final dynamic quitDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? isDisposed;
  final OrderProduct? orderProduct;
  final dynamic parent;


  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json["id"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      remark: json["remark"],
      reminderBeforeExpire:
          DateTime.tryParse(json["reminder_before_expire"] ?? ""),
      status: json["status"],
      quitReason: json["quit_reason"],
      quitDate: json["quit_date"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      isDisposed: json["isDisposed"],
      orderProduct: json["order_product"] == null
          ? null
          : OrderProduct.fromJson(json["order_product"]),
      parent: json["parent"],
    );
  }
}

class OrderProduct {
  OrderProduct({
     this.id,
     this.productType,
     this.paymentMode,
    this.paymentType,
    this.mrp,
     this.salePrice,
    this.gst,
     this.gstPercentage,
     this.tdsOption,
     this.tds,
     this.tdsPercentage,
     this.gstInfo,
     this.total,
     this.quantity,
    this.duration,
     this.status,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
    this.product,
    this.order,
  });

  final String? id;
  final String? productType;
  final String? paymentMode;
  final String? paymentType;
  final num? mrp;
  final num? salePrice;
  final num? gst;
  final num? gstPercentage;
  final String? tdsOption;
  final num? tds;
  final num? tdsPercentage;
  final String? gstInfo;
  final num? total;
  final num? quantity;
  final num? duration;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Product? product;
  final Order? order;

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json["id"],
      productType: json["product_type"],
      paymentMode: json["payment_mode"],
      paymentType: json["payment_type"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      gst: json["gst"],
      gstPercentage: json["gst_percentage"],
      tdsOption: json["tds_option"],
      tds: json["tds"],
      tdsPercentage: json["tds_percentage"],
      gstInfo: json["gst_info"],
      total: json["total"],
      quantity: json["quantity"],
      duration: json["duration"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      product:
          json["product"] == null ? null : Product.fromJson(json["product"]),
      order: json["order"] == null ? null : Order.fromJson(json["order"]),
    );
  }
}

class Order {
  Order({
     this.id,
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
    this.company,
    this.createdBy,
  });

  final String? id;
  final num? orderNumber;
  final num? gstFees;
  final num? tdsPercentage;
  final num? amount;
  final num? tdsAmount;
  final num? totalAmount;
  final num? payabaleAmount;
  final String? performaInvoice;
  final String? status;
  final String? remark;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final dynamic zohoSalesorderId;
  final Customer? customer;
  final Company? company;
  final CreatedBy? createdBy;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json["id"],
      orderNumber: json["order_number"],
      gstFees: json["gst_fees"],
      tdsPercentage: json["tds_percentage"],
      amount: json["amount"],
      tdsAmount: json["tds_amount"],
      totalAmount: json["total_amount"],
      payabaleAmount: json["payabale_amount"],
      performaInvoice: json["performa_invoice"],
      status: json["status"],
      remark: json["remark"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoSalesorderId: json["zoho_salesorder_id"],
      customer:
          json["customer"] == null ? null : Customer.fromJson(json["customer"]),
      company:
          json["company"] == null ? null : Company.fromJson(json["company"]),
      createdBy: json["created_by"] == null
          ? null
          : CreatedBy.fromJson(json["created_by"]),
    );
  }
}

class Company {
  Company({
     this.id,
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
     this.lng,
  });

  final String? id;
  final String? companyName;
  final String? companyEmail;
  final String? companyPhone;
  final num? countryCode;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final num? cCountryCode;
  final String? address;
  final String? website;
  final String? gst;
  final dynamic logo;
  final num? lat;
  final num? lng;

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json["id"],
      companyName: json["company_name"],
      companyEmail: json["company_email"],
      companyPhone: json["company_phone"],
      countryCode: json["country_code"],
      contactPersonName: json["contact_person_name"],
      contactPersonNumber: json["contact_person_number"],
      cCountryCode: json["c_country_code"],
      address: json["address"],
      website: json["website"],
      gst: json["gst"],
      logo: json["logo"],
      lat: json["lat"],
      lng: json["lng"],
    );
  }
}





class CreatedBy {
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
    this.createdByDefault,
    this.createdAt,
    this.updatedAt,
    this.deviceId,
    this.tracking,
    this.crmCategory,
    this.mobileApp,
    this.superSettings,
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobile;
  final String? address;
  final String? bio;
  final String? profilePic;
  final String? password;
  final bool? status;
  final String? rememberToken;
  final DateTime? rememberTokenTime;
  final bool? createdByDefault;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deviceId;
  final bool? tracking;
  final String? crmCategory;
  final bool? mobileApp;
  final bool? superSettings;

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobile: json["mobile"],
      address: json["address"],
      bio: json["bio"],
      profilePic: json["profile_pic"],
      password: json["password"],
      status: json["status"],
      rememberToken: json["remember_token"],
      rememberTokenTime: DateTime.tryParse(json["remember_token_time"] ?? ""),
      createdByDefault: json["default"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deviceId: json["device_id"],
      tracking: json["tracking"],
      crmCategory: json["crm_category"],
      mobileApp: json["mobile_app"],
      superSettings: json["superSettings"],
    );
  }
}



class Customer {
  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.primaryEmail,
    this.countryCode,
    this.primaryContact,
    this.organization,
    this.websites = const [],
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
    this.customerAssigned = const [],
  });

  final String? id;
  final String? firstName;
  final String? lastName;
  final String? primaryEmail;
  final num? countryCode;
  final String? primaryContact;
  final String? organization;
  final List<String> websites;
  final String? primaryAddress;
  final dynamic profileImage;
  final dynamic dob;
  final String? gstin;
  final String? aboutClient;
  final String? otherInformation;
  final num? lat;
  final num? lng;
  final dynamic joinedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final dynamic deleteRemark;
  final dynamic zohoContactId;
  final String? status;
  final dynamic subStatus;
  final List<CustomerAssigned> customerAssigned;

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      primaryEmail: json["primary_email"],
      countryCode: json["country_code"],
      primaryContact: json["primary_contact"],
      organization: json["organization"],
      websites: json["websites"] == null
          ? []
          : List<String>.from(json["websites"]!.map((x) => x)),
      primaryAddress: json["primary_address"],
      profileImage: json["profile_image"],
      dob: json["dob"],
      gstin: json["gstin"],
      aboutClient: json["about_client"],
      otherInformation: json["other_information"],
      lat: json["lat"],
      lng: json["lng"],
      joinedAt: json["joined_at"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      deleteRemark: json["delete_remark"],
      zohoContactId: json["zoho_contact_id"],
      status: json["status"],
      subStatus: json["subStatus"],
      customerAssigned: json["customer_assigned"] == null
          ? []
          : List<CustomerAssigned>.from(json["customer_assigned"]!
          .map((x) => CustomerAssigned.fromJson(x))),
    );
  }
}


class CustomerAssigned {
  CustomerAssigned({
     this.id,
     this.status,
     this.createdAt,
    this.updatedAt,
     this.user,
  });

  final String? id;
  final num? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final CreatedBy? user;

  factory CustomerAssigned.fromJson(Map<String, dynamic> json) {
    return CustomerAssigned(
      id: json["id"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      user: json["user"] == null ? null : CreatedBy.fromJson(json["user"]),
    );
  }
}

class Product {
  Product({
     this.id,
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
     this.projectActivationDisabled,
     this.productCategory,
  });

  final String? id;
  final String? productType;
  final dynamic serviceType;
  final String? name;
  final String? description;
  final num? mrp;
  final num? salePrice;
  final num? quantity;
  final num? duration;
  final String? downloadLink;
  final String? packing;
  final bool? status;
  final bool? isTaxable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? distributorshipOnly;
  final String? zohoItemId;
  final bool? projectActivationDisabled;
  final ProductCategory? productCategory;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      productType: json["product_type"],
      serviceType: json["service_type"],
      name: json["name"],
      description: json["description"],
      mrp: json["mrp"],
      salePrice: json["sale_price"],
      quantity: json["quantity"],
      duration: json["duration"],
      downloadLink: json["download_link"],
      packing: json["packing"],
      status: json["status"],
      isTaxable: json["is_taxable"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
      distributorshipOnly: json["distributorship_only"],
      zohoItemId: json["zoho_item_id"],
      projectActivationDisabled: json["project_activation_disabled"],
      productCategory: json["product_category"] == null
          ? null
          : ProductCategory.fromJson(json["product_category"]),
    );
  }
}

class ProductCategory {
  ProductCategory({
     this.id,
     this.name,
     this.status,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
  });

  final String? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      deletedAt: json["deleted_at"],
    );
  }
}

class Meta {
  Meta({
     this.currentPage,
     this.itemsPerPage,
     this.totalPages,
     this.totalItems,
     this.itemCount,
  });

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }
}
