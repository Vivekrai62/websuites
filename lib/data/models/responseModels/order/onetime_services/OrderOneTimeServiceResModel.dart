class OrderOneTimeServiceResModel {
  OrderOneTimeServiceResModel({
    required this.items,
    required this.meta,
  });
  late final List<Items> items;
  late final Meta meta;

  OrderOneTimeServiceResModel.fromJson(Map<String, dynamic> json){
    items = List.from(json['items']).map((e)=>Items.fromJson(e)).toList();
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['items'] = items.map((e)=>e.toJson()).toList();
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Items {
  Items({
    required this.id,
    required this.productName,
    required this.statusType,
    this.recurringFrequency,
    required this.serviceType,
    this.customRecurringFrequency,
    this.startDate,
    required this.endDate,
    this.pausedUntillDate,
    this.pausedDate,
    required this.isFree,
    required this.orderProduct,
    required this.customer,
    this.project,
    required this.company,
  });
  late final String id;
  late final String productName;
  late final String statusType;
  late final String? recurringFrequency;
  late final String serviceType;
  late final Null customRecurringFrequency;
  late final String? startDate;
  late final String endDate;
  late final Null pausedUntillDate;
  late final Null pausedDate;
  late final bool isFree;
  late final OrderProduct orderProduct;
  late final Customer customer;
  late final Project? project;
  late final Company company;

  Items.fromJson(Map<String, dynamic> json){
    id = json['id'];
    productName = json['product_name'];
    statusType = json['status_type'];
    recurringFrequency = null;
    serviceType = json['service_type'];
    customRecurringFrequency = null;
    startDate = null;
    endDate = json['end_date'];
    pausedUntillDate = null;
    pausedDate = null;
    isFree = json['is_free'];
    orderProduct = OrderProduct.fromJson(json['order_product']);
    customer = Customer.fromJson(json['customer']);
    project = null;
    company = Company.fromJson(json['company']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['product_name'] = productName;
    _data['status_type'] = statusType;
    _data['recurring_frequency'] = recurringFrequency;
    _data['service_type'] = serviceType;
    _data['custom_recurring_frequency'] = customRecurringFrequency;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['paused_untill_date'] = pausedUntillDate;
    _data['paused_date'] = pausedDate;
    _data['is_free'] = isFree;
    _data['order_product'] = orderProduct.toJson();
    _data['customer'] = customer.toJson();
    _data['project'] = project;
    _data['company'] = company.toJson();
    return _data;
  }
}

class OrderProduct {
  OrderProduct({
    required this.id,
    required this.paymentStatus,
    required this.isFree,
    required this.order,
  });
  late final String id;
  late final String paymentStatus;
  late final bool isFree;
  late final Order order;

  OrderProduct.fromJson(Map<String, dynamic> json){
    id = json['id'];
    paymentStatus = json['payment_status'];
    isFree = json['is_free'];
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['payment_status'] = paymentStatus;
    _data['is_free'] = isFree;
    _data['order'] = order.toJson();
    return _data;
  }
}

class Order {
  Order({
    required this.id,
    required this.orderSerialNumber,
  });
  late final String id;
  late final String orderSerialNumber;

  Order.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderSerialNumber = json['order_serial_number'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_serial_number'] = orderSerialNumber;
    return _data;
  }
}

class Customer {
  Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
  });
  late final String id;
  late final String firstName;
  late final String lastName;

  Customer.fromJson(Map<String, dynamic> json){
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    return _data;
  }
}

class Project {
  Project({
    required this.id,
    required this.projectName,
    required this.startDate,
    required this.deadline,
    this.finishDate,
  });
  late final String id;
  late final String projectName;
  late final String startDate;
  late final String deadline;
  late final Null finishDate;

  Project.fromJson(Map<String, dynamic> json){
    id = json['id'];
    projectName = json['project_name'];
    startDate = json['start_date'];
    deadline = json['deadline'];
    finishDate = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['project_name'] = projectName;
    _data['start_date'] = startDate;
    _data['deadline'] = deadline;
    _data['finish_date'] = finishDate;
    return _data;
  }
}

class Company {
  Company({
    required this.id,
    required this.companyName,
    required this.companyEmail,
    required this.companyPhone,
    required this.countryCode,
  });
  late final String id;
  late final String companyName;
  late final String companyEmail;
  late final String companyPhone;
  late final int countryCode;

  Company.fromJson(Map<String, dynamic> json){
    id = json['id'];
    companyName = json['company_name'];
    companyEmail = json['company_email'];
    companyPhone = json['company_phone'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['company_name'] = companyName;
    _data['company_email'] = companyEmail;
    _data['company_phone'] = companyPhone;
    _data['country_code'] = countryCode;
    return _data;
  }
}

class Meta {
  Meta({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalPages,
    required this.totalItems,
    required this.itemCount,
  });
  late final int currentPage;
  late final int itemsPerPage;
  late final int totalPages;
  late final int totalItems;
  late final int itemCount;

  Meta.fromJson(Map<String, dynamic> json){
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currentPage'] = currentPage;
    _data['itemsPerPage'] = itemsPerPage;
    _data['totalPages'] = totalPages;
    _data['totalItems'] = totalItems;
    _data['itemCount'] = itemCount;
    return _data;
  }
}