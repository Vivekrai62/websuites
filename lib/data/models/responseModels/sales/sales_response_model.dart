class SalesResponseModel {
  SalesResponseModel({
    required this.items,
    required this.meta,
  });

  final List<Item> items;
  final Meta? meta;

  factory SalesResponseModel.fromJson(Map<String, dynamic> json){
    return SalesResponseModel(
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    );
  }

}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.saleTarget,
    required this.team,
    required this.createdAt,
    required this.updatedAt,
    required this.members,
    required this.product,
  });

  final String? id;
  final String? name;
  final DateTime? startDate;
  final DateTime? endDate;
  final int? saleTarget;
  final Team? team;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Member> members;
  final List<ProductElement> product;

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"],
      name: json["name"],
      startDate: DateTime.tryParse(json["start_date"] ?? ""),
      endDate: DateTime.tryParse(json["end_date"] ?? ""),
      saleTarget: json["sale_target"],
      team: json["team"] == null ? null : Team.fromJson(json["team"]),
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      members: json["members"] == null ? [] : List<Member>.from(json["members"]!.map((x) => Member.fromJson(x))),
      product: json["product"] == null ? [] : List<ProductElement>.from(json["product"]!.map((x) => ProductElement.fromJson(x))),
    );
  }

}

class Member {
  Member({
    required this.id,
    required this.saleTarget,
    required this.createdAt,
    required this.updatedAt,
    required this.achieveBreakdown,
  });

  final String? id;
  final int? saleTarget;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AchieveBreakdown> achieveBreakdown;

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
      id: json["id"],
      saleTarget: json["sale_target"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      achieveBreakdown: json["achieve_breakdown"] == null ? [] : List<AchieveBreakdown>.from(json["achieve_breakdown"]!.map((x) => AchieveBreakdown.fromJson(x))),
    );
  }

}

class AchieveBreakdown {
  AchieveBreakdown({
    required this.id,
    required this.achievePercentage,
    required this.incentive,
    required this.incentiveType,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? id;
  final int? achievePercentage;
  final int? incentive;
  final String? incentiveType;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory AchieveBreakdown.fromJson(Map<String, dynamic> json){
    return AchieveBreakdown(
      id: json["id"],
      achievePercentage: json["achieve_percentage"],
      incentive: json["incentive"],
      incentiveType: json["incentive_type"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

}

class ProductElement {
  ProductElement({
    required this.id,
    required this.incentiveType,
    required this.minimumSalePrice,
    required this.incentive,
    required this.isSale,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  final String? id;
  final String? incentiveType;
  final int? minimumSalePrice;
  final int? incentive;
  final bool? isSale;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProductProduct? product;

  factory ProductElement.fromJson(Map<String, dynamic> json){
    return ProductElement(
      id: json["id"],
      incentiveType: json["incentive_type"],
      minimumSalePrice: json["minimum_sale_price"],
      incentive: json["incentive"],
      isSale: json["is_sale"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      product: json["product"] == null ? null : ProductProduct.fromJson(json["product"]),
    );
  }

}

class ProductProduct {
  ProductProduct({
    required this.id,
    required this.productType,
    required this.serviceType,
    required this.name,
    required this.description,
    required this.mrp,
    required this.salePrice,
    required this.quantity,
    required this.duration,
    required this.downloadLink,
    required this.packing,
    required this.status,
    required this.isTaxable,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
    required this.distributorshipOnly,
    required this.zohoItemId,
    required this.projectActivationDisabled,
  });

  final String? id;
  final String? productType;
  final dynamic serviceType;
  final String? name;
  final String? description;
  final int? mrp;
  final int? salePrice;
  final int? quantity;
  final int? duration;
  final String? downloadLink;
  final String? packing;
  final bool? status;
  final bool? isTaxable;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final bool? distributorshipOnly;
  final dynamic zohoItemId;
  final bool? projectActivationDisabled;

  factory ProductProduct.fromJson(Map<String, dynamic> json){
    return ProductProduct(
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
      distributorshipOnly: json["distributorshipOnly"],
      zohoItemId: json["zoho_item_id"],
      projectActivationDisabled: json["project_activation_disabled"],
    );
  }

}

class Team {
  Team({
    required this.id,
    required this.bio,
    required this.email,
    required this.mobile,
    required this.status,
    required this.address,
    required this.teamDefault,
    required this.children,
    required this.password,
    required this.tracking,
    required this.deviceId,
    required this.lastName,
    required this.roleList,
    required this.smsSender,
    required this.createdAt,
    required this.firstName,
    required this.mobileApp,
    required this.smtpSender,
    required this.updatedAt,
    required this.profilePic,
    required this.crmCategory,
    required this.mailjetSender,
    required this.superSettings,
    required this.rememberToken,
    required this.rememberTokenTime,
  });

  final String? id;
  final dynamic bio;
  final String? email;
  final String? mobile;
  final bool? status;
  final dynamic address;
  final bool? teamDefault;
  final List<dynamic> children;
  final String? password;
  final bool? tracking;
  final String? deviceId;
  final String? lastName;
  final List<RoleList> roleList;
  final dynamic smsSender;
  final DateTime? createdAt;
  final String? firstName;
  final bool? mobileApp;
  final dynamic smtpSender;
  final DateTime? updatedAt;
  final dynamic profilePic;
  final String? crmCategory;
  final dynamic mailjetSender;
  final bool? superSettings;
  final String? rememberToken;
  final DateTime? rememberTokenTime;

  factory Team.fromJson(Map<String, dynamic> json){
    return Team(
      id: json["id"],
      bio: json["bio"],
      email: json["email"],
      mobile: json["mobile"],
      status: json["status"],
      address: json["address"],
      teamDefault: json["default"],
      children: json["children"] == null ? [] : List<dynamic>.from(json["children"]!.map((x) => x)),
      password: json["password"],
      tracking: json["tracking"],
      deviceId: json["device_id"],
      lastName: json["last_name"],
      roleList: json["role_list"] == null ? [] : List<RoleList>.from(json["role_list"]!.map((x) => RoleList.fromJson(x))),
      smsSender: json["smsSender"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      firstName: json["first_name"],
      mobileApp: json["mobile_app"],
      smtpSender: json["smtpSender"],
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      profilePic: json["profile_pic"],
      crmCategory: json["crm_category"],
      mailjetSender: json["mailjetSender"],
      superSettings: json["superSettings"],
      rememberToken: json["remember_token"],
      rememberTokenTime: DateTime.tryParse(json["remember_token_time"] ?? ""),
    );
  }

}

class RoleList {
  RoleList({
    required this.id,
    required this.name,
    required this.roleListDefault,
    required this.description,
  });

  final String? id;
  final String? name;
  final bool? roleListDefault;
  final String? description;

  factory RoleList.fromJson(Map<String, dynamic> json){
    return RoleList(
      id: json["id"],
      name: json["name"],
      roleListDefault: json["default"],
      description: json["description"],
    );
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

  final int? currentPage;
  final int? itemsPerPage;
  final int? totalPages;
  final int? totalItems;
  final int? itemCount;

  factory Meta.fromJson(Map<String, dynamic> json){
    return Meta(
      currentPage: json["currentPage"],
      itemsPerPage: json["itemsPerPage"],
      totalPages: json["totalPages"],
      totalItems: json["totalItems"],
      itemCount: json["itemCount"],
    );
  }

}
