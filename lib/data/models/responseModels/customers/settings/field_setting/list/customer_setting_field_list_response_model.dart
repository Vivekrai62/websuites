class CustomerSettingFieldListResponseModel {
  String? id;
  String? name;
  String? displayName;
  bool? isRequired;
  bool? isInUse;
  bool? isStatusFixed;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<Null>? customerFieldEditRestrictions;
  List<Null>? restrictedRoles;

  CustomerSettingFieldListResponseModel(
      {this.id,
      this.name,
      this.displayName,
      this.isRequired,
      this.isInUse,
      this.isStatusFixed,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.customerFieldEditRestrictions,
      this.restrictedRoles});

  CustomerSettingFieldListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    displayName = json['displayName'];
    isRequired = json['isRequired'];
    isInUse = json['isInUse'];
    isStatusFixed = json['isStatusFixed'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['customer_field_edit_restrictions'] != null) {
      customerFieldEditRestrictions = <Null>[];
      json['customer_field_edit_restrictions'].forEach((v) {
        customerFieldEditRestrictions!.add((v));
      });
    }
    if (json['restricted_roles'] != null) {
      restrictedRoles = <Null>[];
      json['restricted_roles'].forEach((v) {
        restrictedRoles!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['displayName'] = displayName;
    data['isRequired'] = isRequired;
    data['isInUse'] = isInUse;
    data['isStatusFixed'] = isStatusFixed;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (customerFieldEditRestrictions != null) {
      data['customer_field_edit_restrictions'] =
          customerFieldEditRestrictions!.map((v) => ()).toList();
    }
    if (restrictedRoles != null) {
      data['restricted_roles'] = restrictedRoles!.map((v) => ()).toList();
    }
    return data;
  }

  static List<CustomerSettingFieldListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerSettingFieldListResponseModel.fromJson(json))
        .toList();
  }
}
