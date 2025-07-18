class CustomerActivityNoActivityResponseModel {
  List<Items>? items;
  Meta? meta;

  CustomerActivityNoActivityResponseModel({this.items, this.meta});

  CustomerActivityNoActivityResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? firstName;
  String? lastName;
  String? primaryEmail;
  String? primaryContact;
  Company? company;
  CustomerType? customerType;
  LastOrder? lastOrder;
  LastCall? lastCall;
  LastCall? lastMeeting;
  List<CustomerAssigned>? customerAssigned;

  Items(
      {this.id,
      this.firstName,
      this.lastName,
      this.primaryEmail,
      this.primaryContact,
      this.company,
      this.customerType,
      this.lastOrder,
      this.lastCall,
      this.lastMeeting,
      this.customerAssigned});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    primaryEmail = json['primary_email'];
    primaryContact = json['primary_contact'];
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    customerType = json['customer_type'] != null
        ? CustomerType.fromJson(json['customer_type'])
        : null;
    lastOrder = json['lastOrder'] != null
        ? LastOrder.fromJson(json['lastOrder'])
        : null;
    lastCall =
        json['lastCall'] != null ? LastCall.fromJson(json['lastCall']) : null;
    lastMeeting = json['lastMeeting'] != null
        ? LastCall.fromJson(json['lastMeeting'])
        : null;
    if (json['customer_assigned'] != null) {
      customerAssigned = <CustomerAssigned>[];
      json['customer_assigned'].forEach((v) {
        customerAssigned!.add(CustomerAssigned.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['primary_email'] = primaryEmail;
    data['primary_contact'] = primaryContact;
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (customerType != null) {
      data['customer_type'] = customerType!.toJson();
    }
    if (lastOrder != null) {
      data['lastOrder'] = lastOrder!.toJson();
    }
    if (lastCall != null) {
      data['lastCall'] = lastCall!.toJson();
    }
    if (lastMeeting != null) {
      data['lastMeeting'] = lastMeeting!.toJson();
    }
    if (customerAssigned != null) {
      data['customer_assigned'] =
          customerAssigned!.map((v) => v.toJson()).toList();
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

class CustomerType {
  String? id;
  String? name;

  CustomerType({this.id, this.name});

  CustomerType.fromJson(Map<String, dynamic> json) {
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

class LastOrder {
  String? id;
  int? orderNumber;
  int? amount;
  String? createdAt;
  CreatedBy? createdBy;

  LastOrder(
      {this.id, this.orderNumber, this.amount, this.createdAt, this.createdBy});

  LastOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    amount = json['amount'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_number'] = orderNumber;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
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

class LastCall {
  String? id;
  String? remark;
  String? createdAt;
  CreatedBy? createdBy;

  LastCall({this.id, this.remark, this.createdAt, this.createdBy});

  LastCall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remark = json['remark'];
    createdAt = json['created_at'];
    createdBy = json['created_by'] != null
        ? CreatedBy.fromJson(json['created_by'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['remark'] = remark;
    data['created_at'] = createdAt;
    if (createdBy != null) {
      data['created_by'] = createdBy!.toJson();
    }
    return data;
  }
}

class CustomerAssigned {
  String? id;
  CreatedBy? user;

  CustomerAssigned({this.id, this.user});

  CustomerAssigned.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? CreatedBy.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class Meta {
  int? currentPage;
  int? itemsPerPage;
  int? totalPages;
  int? totalItems;
  int? itemCount;

  Meta(
      {this.currentPage,
      this.itemsPerPage,
      this.totalPages,
      this.totalItems,
      this.itemCount});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentPage'];
    itemsPerPage = json['itemsPerPage'];
    totalPages = json['totalPages'];
    totalItems = json['totalItems'];
    itemCount = json['itemCount'];
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
