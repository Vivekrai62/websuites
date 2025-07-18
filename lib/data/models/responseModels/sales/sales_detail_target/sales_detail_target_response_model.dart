//"LIve URl ke According Response model"

class TargetDetailResponseModel {
  TargetIncentive? targetIncentive;

  TargetDetailResponseModel({this.targetIncentive});

  TargetDetailResponseModel.fromJson(Map<String, dynamic> json) {
    targetIncentive = json['targetIncentive'] != null
        ? TargetIncentive.fromJson(json['targetIncentive'])
        : null;
  }
  //
  //
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (targetIncentive != null) {
      data['targetIncentive'] = targetIncentive!.toJson();
    }
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
  TeamHead? teamHead;
  List<Product>? product;
  List<MinimumProduct>? minimumProduct;

  TargetIncentive(
      {this.id,
      this.name,
      this.startDate,
      this.endDate,
      this.saleTarget,
      this.team,
      this.createdAt,
      this.updatedAt,
      this.teamHead,
      this.product,
      this.minimumProduct});

  TargetIncentive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    saleTarget = json['sale_target'];
    team = json['team'] != null ? Team.fromJson(json['team']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teamHead =
        json['team_head'] != null ? TeamHead.fromJson(json['team_head']) : null;
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(Product.fromJson(v));
      });
    }
    if (json['minimum_product'] != null) {
      minimumProduct = <MinimumProduct>[];
      json['minimum_product'].forEach((v) {
        minimumProduct!.add(MinimumProduct.fromJson(v));
      });
    }
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
    if (teamHead != null) {
      data['team_head'] = teamHead!.toJson();
    }
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    if (minimumProduct != null) {
      data['minimum_product'] = minimumProduct!.map((v) => ()).toList();
    }
    return data;
  }
}

class Team {
  String? id;
  String? bio;
  String? email;
  String? mobile;
  String? address;
  bool? defaultAt;
  List<dynamic>? children;
  String? password;
  String? lastName;
  List<RoleList>? roleList;
  String? createdAt;
  String? firstName;
  String? updatedAt;
  dynamic profilePic;
  dynamic rememberToken;
  dynamic rememberTokenTime;

  Team(
      {this.id,
      this.bio,
      this.email,
      this.mobile,
      this.address,
      this.defaultAt,
      this.children,
      this.password,
      this.lastName,
      this.roleList,
      this.createdAt,
      this.firstName,
      this.updatedAt,
      this.profilePic,
      this.rememberToken,
      this.rememberTokenTime});

  Team.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bio = json['bio'];
    email = json['email'];
    mobile = json['mobile'];
    address = json['address'];
    defaultAt = json['default'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add((v));
      });
    }
    password = json['password'];
    lastName = json['last_name'];
    if (json['role_list'] != null) {
      roleList = <RoleList>[];
      json['role_list'].forEach((v) {
        roleList!.add(RoleList.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    firstName = json['first_name'];
    updatedAt = json['updated_at'];
    profilePic = json['profile_pic'];
    rememberToken = json['remember_token'];
    rememberTokenTime = json['remember_token_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bio'] = bio;
    data['email'] = email;
    data['mobile'] = mobile;
    data['address'] = address;
    data['default'] = defaultAt;
    if (children != null) {
      data['children'] = children!.map((v) => ()).toList();
    }
    data['password'] = password;
    data['last_name'] = lastName;
    if (roleList != null) {
      data['role_list'] = roleList!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['first_name'] = firstName;
    data['updated_at'] = updatedAt;
    data['profile_pic'] = profilePic;
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

class TeamHead {
  String? id;
  String? email;
  String? mobile;
  List<Null>? children;
  String? lastName;
  String? firstName;
  Key? key;

  TeamHead(
      {this.id,
      this.email,
      this.mobile,
      this.children,
      this.lastName,
      this.firstName,
      this.key});

  TeamHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    mobile = json['mobile'];
    if (json['children'] != null) {
      children = <Null>[];
      json['children'].forEach((v) {
        children!.add((v));
      });
    }
    lastName = json['last_name'];
    firstName = json['first_name'];
    key = json['key'] != null ? Key.fromJson(json['key']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['mobile'] = mobile;
    if (children != null) {
      data['children'] = children!.map((v) => ()).toList();
    }
    data['last_name'] = lastName;
    data['first_name'] = firstName;
    if (key != null) {
      data['key'] = key!.toJson();
    }
    return data;
  }
}

class Key {
  String? id;
  int? saleTarget;
  String? createdAt;
  String? updatedAt;
  List<AchieveBreakdown>? achieveBreakdown;

  Key(
      {this.id,
      this.saleTarget,
      this.createdAt,
      this.updatedAt,
      this.achieveBreakdown});

  Key.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    saleTarget = json['sale_target'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['achieve_breakdown'] != null) {
      achieveBreakdown = <AchieveBreakdown>[];
      json['achieve_breakdown'].forEach((v) {
        achieveBreakdown!.add(AchieveBreakdown.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sale_target'] = saleTarget;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (achieveBreakdown != null) {
      data['achieve_breakdown'] =
          achieveBreakdown!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AchieveBreakdown {
  String? id;
  int? achievePercentage;
  int? incentive;
  String? incentiveType;
  String? createdAt;
  String? updatedAt;

  AchieveBreakdown(
      {this.id,
      this.achievePercentage,
      this.incentive,
      this.incentiveType,
      this.createdAt,
      this.updatedAt});

  AchieveBreakdown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    achievePercentage = json['achieve_percentage'];
    incentive = json['incentive'];
    incentiveType = json['incentive_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['achieve_percentage'] = achievePercentage;
    data['incentive'] = incentive;
    data['incentive_type'] = incentiveType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MinimumProduct {
  String? id;
  int? quantity;
  String? createdAt;
  String? updatedAt;
  Product? product;

  MinimumProduct(
      {this.id, this.quantity, this.createdAt, this.updatedAt, this.product});

  MinimumProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['quantity'] = quantity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Product {
  String? id;
  String? name;
  String? incentiveType;
  int? minimumSalePrice;
  int? incentive;
  bool? isSale;
  String? createdAt;
  String? updatedAt;
  Product? product;

  Product(
      {this.id,
      this.incentiveType,
      this.minimumSalePrice,
      this.incentive,
      this.isSale,
      this.createdAt,
      this.updatedAt,
      this.product,
      this.name});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    incentiveType = json['incentive_type'];
    minimumSalePrice = json['minimum_sale_price'];
    incentive = json['incentive'];
    isSale = json['is_sale'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['incentive_type'] = incentiveType;
    data['minimum_sale_price'] = minimumSalePrice;
    data['incentive'] = incentive;
    data['is_sale'] = isSale;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}
