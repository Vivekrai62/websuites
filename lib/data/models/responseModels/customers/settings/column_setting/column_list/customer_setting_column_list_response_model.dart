class CustomerSettingColumnListResponseModel {
  String? id;
  String? leadField;
  String? fieldName;
  int? order;
  bool? filter;
  bool? allowGlobalSearch;
  bool? status;
  String? type;
  String? createdAt;
  String? updatedAt;
  List<Null>? hideCustomerColumnsFromRole;
  List<Null>? restrictedRoles;

  CustomerSettingColumnListResponseModel(
      {this.id,
      this.leadField,
      this.fieldName,
      this.order,
      this.filter,
      this.allowGlobalSearch,
      this.status,
      this.type,
      this.createdAt,
      this.updatedAt,
      this.hideCustomerColumnsFromRole,
      this.restrictedRoles});

  CustomerSettingColumnListResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leadField = json['lead_field'];
    fieldName = json['field_name'];
    order = json['order'];
    filter = json['filter'];
    allowGlobalSearch = json['allowGlobalSearch'];
    status = json['status'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['hide_customer_columns_from_role'] != null) {
      hideCustomerColumnsFromRole = <Null>[];
      json['hide_customer_columns_from_role'].forEach((v) {
        hideCustomerColumnsFromRole!.add((v));
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
    data['lead_field'] = leadField;
    data['field_name'] = fieldName;
    data['order'] = order;
    data['filter'] = filter;
    data['allowGlobalSearch'] = allowGlobalSearch;
    data['status'] = status;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (hideCustomerColumnsFromRole != null) {
      data['hide_customer_columns_from_role'] =
          hideCustomerColumnsFromRole!.map((v) => ()).toList();
    }
    if (restrictedRoles != null) {
      data['restricted_roles'] = restrictedRoles!.map((v) => ()).toList();
    }
    return data;
  }

  static List<CustomerSettingColumnListResponseModel> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => CustomerSettingColumnListResponseModel.fromJson(json))
        .toList();
  }
}
