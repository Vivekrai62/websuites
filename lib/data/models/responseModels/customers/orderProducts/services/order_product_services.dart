class CustomerOrderProductServiceResponseModel {
  final StartBy startBy;
  final DateTime startDate;
  final DateTime reminderBeforeExpire;
  final OrderProduct orderProduct;
  final DateTime endDate;
  final String remark;
  final String? quitReason;
  final DateTime? quitDate;
  final String id;
  final bool status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final bool isDisposed;

  CustomerOrderProductServiceResponseModel({
    required this.startBy,
    required this.startDate,
    required this.reminderBeforeExpire,
    required this.orderProduct,
    required this.endDate,
    required this.remark,
    this.quitReason,
    this.quitDate,
    required this.id,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.isDisposed,
  });

  factory CustomerOrderProductServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return CustomerOrderProductServiceResponseModel(
      startBy: StartBy.fromJson(json['start_by']),
      startDate: DateTime.parse(json['start_date']),
      reminderBeforeExpire: DateTime.parse(json['reminder_before_expire']),
      orderProduct: OrderProduct.fromJson(json['order_product']),
      endDate: DateTime.parse(json['end_date']),
      remark: json['remark'],
      quitReason: json['quit_reason'],
      quitDate: json['quit_date'] != null ? DateTime.parse(json['quit_date']) : null,
      id: json['id'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      isDisposed: json['isDisposed'],
    );
  }
}

class StartBy {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;
  final String address;
  final String bio;
  final String? profilePic;
  final String password;
  final bool status;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String deviceId;
  final bool tracking;
  final String crmCategory;
  final bool mobileApp;
  final bool superSettings;
  final Role role;

  StartBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.address,
    required this.bio,
    this.profilePic,
    required this.password,
    required this.status,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    required this.deviceId,
    required this.tracking,
    required this.crmCategory,
    required this.mobileApp,
    required this.superSettings,
    required this.role,
  });

  factory StartBy.fromJson(Map<String, dynamic> json) {
    return StartBy(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
      bio: json['bio'],
      profilePic: json['profile_pic'],
      password: json['password'],
      status: json['status'],
      isDefault: json['default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deviceId: json['device_id'],
      tracking: json['tracking'],
      crmCategory: json['crm_category'],
      mobileApp: json['mobile_app'],
      superSettings: json['superSettings'],
      role: Role.fromJson(json['role']),
    );
  }
}

class Role {
  final String id;
  final String name;
  final String description;
  final bool isDefault;

  Role({
    required this.id,
    required this.name,
    required this.description,
    required this.isDefault,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      isDefault: json['default'],
    );
  }
}

class OrderProduct {
  final String id;
  final String productType;
  final String paymentMode;
  final String paymentType;
  final int mrp;
  final int salePrice;
  final int gst;
  final int gstPercentage;
  final String tdsOption;
  final int tds;
  final int tdsPercentage;
  final String? gstInfo;
  final int total;
  final int quantity;
  final int duration;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;
  final Order order;

  OrderProduct({
    required this.id,
    required this.productType,
    required this.paymentMode,
    required this.paymentType,
    required this.mrp,
    required this.salePrice,
    required this.gst,
    required this.gstPercentage,
    required this.tdsOption,
    required this.tds,
    required this.tdsPercentage,
    this.gstInfo,
    required this.total,
    required this.quantity,
    required this.duration,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
    required this.order,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) {
    return OrderProduct(
      id: json['id'],
      productType: json['product_type'],
      paymentMode: json['payment_mode'],
      paymentType: json['payment_type'],
      mrp: json['mrp'],
      salePrice: json['sale_price'],
      gst: json['gst'],
      gstPercentage: json['gst_percentage'],
      tdsOption: json['tds_option'],
      tds: json['tds'],
      tdsPercentage: json['tds_percentage'],
      gstInfo: json['gst_info'],
      total: json['total'],
      quantity: json['quantity'],
      duration: json['duration'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: Product.fromJson(json['product']),
      order: Order.fromJson(json['order']),
    );
  }
}

class Product {
  final String id;
  final String productType;
  final String? serviceType;
  final String name;
  final String description;
  final int mrp;
  final int salePrice;
  final int quantity;
  final int duration;
  final String downloadLink;
  final bool status;
  final bool isTaxable;

  Product({
    required this.id,
    required this.productType,
    this.serviceType,
    required this.name,
    required this.description,
    required this.mrp,
    required this.salePrice,
    required this.quantity,
    required this.duration,
    required this.downloadLink,
    required this.status,
    required this.isTaxable,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      productType: json['product_type'],
      serviceType: json['service_type'],
      name: json['name'],
      description: json['description'],
      mrp: json['mrp'],
      salePrice: json['sale_price'],
      quantity: json['quantity'],
      duration: json['duration'],
      downloadLink: json['download_link'],
      status: json['status'],
      isTaxable: json['is_taxable'],
    );
  }
}

class Order {
  final String id;
  final int orderNumber;
  final int amount;
  final int totalAmount;
  final String status;
  final Customer customer;

  Order({
    required this.id,
    required this.orderNumber,
    required this.amount,
    required this.totalAmount,
    required this.status,
    required this.customer,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      orderNumber: json['order_number'],
      amount: json['amount'],
      totalAmount: json['total_amount'],
      status: json['status'],
      customer: Customer.fromJson(json['customer']),
    );
  }
}

class Customer {
  final String id;
  final String firstName;
  final String lastName;
  final String primaryEmail;
  final int countryCode;
  final String primaryContact;
  final String organization;
  final String primaryAddress;
  final String aboutClient;

  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.primaryEmail,
    required this.countryCode,
    required this.primaryContact,
    required this.organization,
    required this.primaryAddress,
    required this.aboutClient,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      primaryEmail: json['primary_email'],
      countryCode: json['country_code'],
      primaryContact: json['primary_contact'],
      organization: json['organization'],
      primaryAddress: json['primary_address'],
      aboutClient: json['about_client'],
    );
  }
}
