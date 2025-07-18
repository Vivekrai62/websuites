import 'package:get/get.dart';

class SalesAddProductResponseModel {
  int? quantity;
  TargetIncentive? targetIncentive;
  Product? product;
  String? id;
  String? createdAt;
  String? updatedAt;

  SalesAddProductResponseModel(
      {this.quantity,
      this.targetIncentive,
      this.product,
      this.id,
      this.createdAt,
      this.updatedAt});

  SalesAddProductResponseModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    targetIncentive = json['taregt_incentive'] != null
        ? TargetIncentive.fromJson(json['taregt_incentive'])
        : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    if (targetIncentive != null) {
      data['taregt_incentive'] = targetIncentive!.toJson();
    }
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['id'] = id;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class TargetIncentive {
  String? id;
  String? name;
  String? startDate;
  String? endDate;
  int? saleTarget;
  Team? team;
  String? createdAt;
  String? updatedAt;

  TargetIncentive(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.saleTarget,
      this.team,
      this.createdAt,
      this.updatedAt});

  TargetIncentive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    saleTarget = json['sale_target'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['sale_target'] = saleTarget;
    if (team != null) {
      data['team'] = team!.toJson();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Team {
  String? id;
  dynamic bio;
  String? email;
  String? mobile;
  bool? status;
  dynamic address;
  bool? defaultAt;
  List<Null>? children;
  String? password;
  bool? tracking;
  String? deviceId;
  String? lastName;
  List<RoleList>? roleList;
  dynamic smsSender;
  String? createdAt;
  String? firstName;
  bool? mobileApp;
  dynamic smtpSender;
  String? updatedAt;
  dynamic profilePic;
  String? crmCategory;
  dynamic mailjetSender;
  bool? superSettings;
  String? rememberToken;
  String? rememberTokenTime;

  Team(
      {this.id,
      this.bio,
      this.email,
      this.mobile,
      this.status,
      this.address,
      this.defaultAt,
      this.children,
      this.password,
      this.tracking,
      this.deviceId,
      this.lastName,
      this.roleList,
      this.smsSender,
      this.createdAt,
      this.firstName,
      this.mobileApp,
      this.smtpSender,
      this.updatedAt,
      this.profilePic,
      this.crmCategory,
      this.mailjetSender,
      this.superSettings,
      this.rememberToken,
      this.rememberTokenTime});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bio = json['bio'];
    email = json['email'];
    mobile = json['mobile'];
    status = json['status'];
    address = json['address'];
    defaultAt = json['default'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add((v));
      });
    }
    password = json['password'];
    tracking = json['tracking'];
    deviceId = json['device_id'];
    lastName = json['last_name'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    smsSender = json['smsSender'];
    createdAt = json['created_at'];
    firstName = json['first_name'];
    mobileApp = json['mobile_app'];
    smtpSender = json['smtpSender'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    crmCategory = json['crm_category'];
    mailjetSender = json['mailjetSender'];
    superSettings = json['superSettings'];
    rememberToken = json['remember_token'];
    rememberTokenTime = json['remember_token_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bio'] = bio;
    data['email'] = email;
    data['mobile'] = mobile;
    data['status'] = status;
    data['address'] = address;
    data['default'] = defaultAt;
    if (children != null) {
      data['children'] = children!.map((v) => ()).toList();
    }
    data['password'] = password;
    data['tracking'] = tracking;
    data['device_id'] = deviceId;
    data['last_name'] = lastName;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    data['smsSender'] = smsSender;
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['mobile_app'] = mobileApp;
    data['smtpSender'] = smtpSender;
    data['updated_at'] = updatedAt;
    data['profile_pic'] = profilePic;
    data['crm_category'] = crmCategory;
    data['mailjetSender'] = mailjetSender;
    data['superSettings'] = superSettings;
    data['remember_token'] = rememberToken;
    data['remember_token_time'] = rememberTokenTime;
    return data;
  }
}

class RoleList {
  String? id;
  String? name;
  bool? defaultAt;
  String? description;

  RoleList({this.id, this.name, this.defaultAt, this.description});

  RoleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    defaultAt = json['default'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['default'] = defaultAt;
    data['description'] = description;
    return data;
  }
}

class Product {
  String? id;
  String? productType;
  dynamic serviceType;
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
  dynamic deletedAt;
  bool? distributorshipOnly;
  dynamic zohoItemId;
  bool? projectActivationDisabled;

  Product(
      {this.id,
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
      this.projectActivationDisabled});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productType = json['product_type'];
    serviceType = json['service_type'];
    name = json['name'];
    description = json['description'];
    mrp = json['mrp'];
    salePrice = json['sale_price'];
    quantity = json['quantity'];
    duration = json['duration'];
    downloadLink = json['download_link'];
    packing = json['packing'];
    status = json['status'];
    isTaxable = json['is_taxable'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    distributorshipOnly = json['distributorshipOnly'];
    zohoItemId = json['zoho_item_id'];
    projectActivationDisabled = json['project_activation_disabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_type'] = productType;
    data['service_type'] = serviceType;
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
    data['distributorshipOnly'] = distributorshipOnly;
    data['zoho_item_id'] = zohoItemId;
    data['project_activation_disabled'] = projectActivationDisabled;
    return data;
  }
}
